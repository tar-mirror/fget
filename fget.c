#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#ifndef NODNS
#include "dns.h"
#endif
#include "strerr.h"
#include "byte.h"
#include "scan.h"
#include "socket.h"
#include "ip6.h"
#include "ndelay.h"
#include "stralloc.h"
#include "env.h"

static char seed[256];

#define VERSION "fget 0.1"
#define FATAL VERSION ": fatal: "

static int force=0;	/* force IP version */

static stralloc host = {0};
static stralloc request = {0};
static unsigned short port;
static char *path;
static char *username=0;
static char *password=0;

static stralloc out = {0};
static stralloc fqdn = {0};

uint32 interface=0;

static enum { FTP, HTTP, HTTPPROXY } method;

void parseurl(char *url, int resolve) {
  char *tmphost=url;
  char *tmp;
  /* the host part may start with "username@" or "username:password@" */
  {
    for (tmp=url; *tmp && *tmp!='/' && *tmp!='@'; tmp++) ;
    if (*tmp=='@') {
      username=url;
      *tmp=0;
      tmphost=tmp+1;
      for (tmp=username; *tmp && *tmp!=':'; tmp++) ;
      if (*tmp==':') {
	password=tmp+1;
	*tmp=0;
      }
    }
  }
  if (*tmphost=='[') {	/* IPv6 IP */
    static char ip[16];
    for (tmp=++tmphost; *tmp && *tmp!=']'; tmp++) ;
    if (*tmp!=']') goto urlsyntax;
    stralloc_copyb(&host,tmphost,tmp-tmphost);
    *tmp=0; tmp++;
  } else {
    static char ip[16];
    for (tmp=tmphost; *tmp && *tmp!=':' && *tmp!='/'; tmp++) ;
    if (*tmp==0) goto urlsyntax;
    stralloc_copyb(&host,tmphost,tmp-tmphost);
  }

  if (*tmp==':') {
    unsigned long tmpport;
    int len=scan_ulong(++tmp,&tmpport);
    if (len==0) goto urlsyntax;
    tmp+=len;
    if (tmpport>65535) goto urlsyntax;
    port=tmpport;
  }
  if (*tmp==0)
    path="/";
  else if (*tmp=='/')
    path=tmp;
  else
    goto urlsyntax;

  if (resolve) {
#ifndef NODNS
    if (dns_ip6_qualify(&out,&fqdn,&host))
      strerr_die1sys(0,"fget: dns_ip6_qualify failed: ");
#else
    {
      char ip[16];
      if (!stralloc_readyplus(&host,1))
	strerr_die1x(0,"fget: out of memory.");
      host.s[host.len]=0;
      if (ip6_scan(host.s,ip)==0) {
	if (ip4_scan(host.s,ip+12)==0)
	  strerr_die1x(0,"fget: no DNS support compiled in.");
	byte_copy(ip,12,V4mappedprefix);
      }
    }
#endif
    if (out.len==0) {
      stralloc_0(&host);
      strerr_die2x(0,"fget: no such host: ",host.s);
    }
  }

  return;
urlsyntax:
  strerr_die1x(0,"invalid url syntax\n");
}

void build_http_request(stralloc *request,char *path)
{
  static stralloc auth = {0};
  static stralloc b64 = {0};
  static char base64[]="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
  char buf[20];

  stralloc_copys(request,"GET ");
  stralloc_cats(request,path);
  stralloc_cats(request," HTTP/1.0\r\nHost: ");
  stralloc_cat(request,&host);
  stralloc_cats(request,":");
  stralloc_catb(request,buf,fmt_ulong(buf,port));
  if (username) {
    int i;
    unsigned char *tmp;

    stralloc_cats(request,"\r\nAuthorization: Basic ");

    stralloc_copys(&auth,username);
    stralloc_cats(&auth,":");
    if (password) stralloc_cats(&auth,password);
    /* I couldn't express base64 any terser. */
    tmp=auth.s;
    {
      short written=0,temp=0,bits=0;
      for (i=0; i<auth.len; i++) {
	temp<<=8; temp+=auth.s[i]; bits+=8;
	while (bits>6) {
	  stralloc_append(request,base64+((temp>>(bits-6))&63));
	  bits-=6; written++;
	}
      }
      if (bits) {
	temp<<=(6-bits); written++;
	stralloc_append(request,base64+(temp&63));
      }
      while (written&3) { stralloc_append(request,"="); written++; }
    }
  }
  stralloc_cats(request,"\r\n\r\n");
}

inline int isdigit(char c) {
  return (c>='0' && c<='9');
}

inline int isresponsecode(char *s) {
  return (isdigit(s[0]) && isdigit(s[1]) && isdigit(s[2]) && (s[3]==' ' || s[3]=='-'));
}

inline int iscrlf(char *s) {
  return *s=='\r' && s[1]=='\n';
}

static stralloc response = {0};

int parseresponse(int s) {
  int result=0;
  int len;
  char buf[1024];

  stralloc_copys(&response,"");
  for (;;) {
    char *tmp,*last;
    len=read(s,buf,1024);
    if (len==0) return 0;
    stralloc_catb(&response,buf,len);
    if (response.len>6 && isresponsecode(response.s))
      if (response.s[3]==' ' && iscrlf(response.s+response.len-2)) {
/*	printf("a %c%c%c\n",response.s[0],response.s[1],response.s[2]); */
	return (response.s[0]-'0')*100+(response.s[1]-'0')*10+response.s[2]-'0';
      }
    if (response.len>8) {
      tmp=response.s+5; last=response.s+response.len-8;
      for (; tmp<last; tmp++)
	if (iscrlf(tmp) && isresponsecode(tmp+2))
	  if (tmp[5]==' ' && iscrlf(response.s+response.len-2)) {
/*	    printf("b %c%c%c\n",tmp[2],tmp[3],tmp[4]); */
	    return (tmp[2]-'0')*100+(tmp[3]-'0')*10+tmp[4]-'0';
	  }
    }
  }
  return result;
}

int parsepasvport(stralloc *s) {
/* "227 text (127,0,0,1,128,61)" */
  int last=str_chr(s->s,'\r');
  unsigned long a,b;
  if (last==0) return -1;
  last--;
  while (last>0 && !isdigit(s->s[last])) --last;
  s->s[last+1]=0;
  while (last>0 && isdigit(s->s[last])) --last;
  if (scan_ulong(s->s+last+1,&b)==0) return -1;
  s->s[last--]=0;
  while (last>0 && isdigit(s->s[last])) --last;
  if (scan_ulong(s->s+last+1,&a)==0) return -1;
  return a*256+b;
}

int parseepsvport(stralloc *s) {
/* "229 text (|||1234|)" with '|' variable */
  int i=str_chr(s->s,'(');
  char sep;
  unsigned long port;
  if (i==0) return -1;
  sep=s->s[i+1];
  if (s->s[i+2]!=sep || s->s[i+3]!=sep) return -1;
  if (scan_ulong(s->s+i+4,&port)==0) return -1;
  return port;
}

int fget(char *url) {
  int s=-1,ds=-1;
  char buf[1024];
  int len;
  char *proxy;
  int resolve=1;

  if (byte_equal(url,7,"http://")) {
    port=80;
    method=HTTP;
    if (proxy=env_get("http_proxy")) resolve=0;
    parseurl(url+7,resolve);
  } else if (byte_equal(url,6,"ftp://")) {
    port=21;
    method=FTP;
    if (proxy=env_get("ftp_proxy")) resolve=0;
    parseurl(url+6,resolve);
  } else
    strerr_die1x(0,"unsupported method\n");

  if (proxy) {
    if (method==FTP) username=password=0;
    build_http_request(&request,url);
    method=HTTPPROXY;
    parseurl(proxy+7,1);
  } else
    build_http_request(&request,path);
  s=socket_tcp6();
  if (s<0) strerr_die1sys(0,"fget: socket failed: ");
  ndelay_off(s);
  if (socket_connect6(s,out.s,port,interface)<0)
    strerr_die1sys(0,"fget: connect failed: ");
  if (method==HTTP || method==HTTPPROXY) {
    stralloc header = {0};
    write(s,request.s,request.len);
    for (;;) {
      int i,found;
      len=read(s,buf,1024);
      if (len<=0) break;
      stralloc_catb(&header,buf,len);
      if (header.len>4) {
	found=0;
	for (i=0; i<header.len-4; i++)
	  if (byte_equal(header.s+i,4,"\r\n\r\n")) {
	    found=1;
	    break;
	  }
	if (found) {
	  write(1,header.s+i+4,header.len-i-4);
	  header.len=i+4;
	  break;
	}
      }
    }
    if (len>0) {
      for (;;) {
	len=read(s,buf,1024);
	if (len<=0) break;
	write(1,buf,len);
      }
    }
    return 0;
  } else if (method==FTP) {
    int port=0;
    int res;
    if (parseresponse(s)!=220) goto error;
    if (username) {
      write(s,"USER ",5);
      write(s,username,str_len(username));
      write(s,"\r\n",2);
      if (password) {
	if ((res=parseresponse(s))!=331) goto error;
	write(s,"PASS ",5);
	write(s,password,str_len(password));
	write(s,"\r\n",2);
      } else
	if ((res=parseresponse(s))!=230) goto error;
    } else {
      write(s,"USER ftp\r\n",10);
      switch(parseresponse(s)) {
      case 331:
	write(s,"PASS fget@\r\n",12);
	if ((res=parseresponse(s))!=230) goto error;
	break;
      case 230:
	break;
      default:
/*	printf("res %d\n",res); */
	goto error;
      }
    }
    /* login successful */
    write(s,"EPSV\r\n",6);
    switch (res=parseresponse(s)) {
    case 229:
      port=parseepsvport(&response);
      break;
    case 500:
    case 501:
    case 502:
    case 503:
      write(s,"PASV\r\n",6);
      if (parseresponse(s)!=227) goto error;
      port=parsepasvport(&response);
      break;
    default:
      goto error;
    }
    ds=socket_tcp6();
    if (ds<0) strerr_die1sys(0,"fget: socket failed: ");
    ndelay_off(ds);
    if (socket_connect6(ds,out.s,port,interface)<0)
    strerr_die1sys(0,"fget: connect failed: ");
    {
      char *tmp=alloca(7+str_len(path));
      byte_copy(tmp,5,"RETR ");
      byte_copy(tmp+5,str_len(path),path);
      byte_copy(tmp+str_len(path)+5,2,"\r\n");
      write(s,tmp,str_len(path)+7);
    }
    if ((res=parseresponse(s))!=150) goto error;
    for (;;) {
      len=read(ds,buf,1024);
      if (len<=0) break;
      write(1,buf,len);
    }
    close(ds); ds=-1;
    if (parseresponse(s)!=226);
    write(s,"QUIT\r\n",6);
    if (parseresponse(s)!=221);
    close(s);
    return 0;
  }
error:
  if (ds>=0) close(ds);
  if (s>=0) close(s);
  return -1;
}

int main(int argc,char *argv[]) {
  char *x=env_get("INTERFACE");
  if (x) interface=socket_getifidx(x);

#ifndef NODNS
  dns_random_init(seed);
#endif
  if (!argv[1])
    strerr_die1x(0,"usage: fget url\n");
  fget(argv[1]);
#if 0
  printf("%s-connect to %s port %d and get %s\n",method==FTP?"ftp":"http",host.s,port,path);
  if (username)
    printf("login as %s, password %s\n",username,password);
#endif
  return 0;
}

