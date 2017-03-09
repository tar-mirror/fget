# Don't edit Makefile! Use conf-* for configuration.

SHELL=/bin/sh

all: fget fget_nodns install dietfget dietfget_nodns

setup: install
	./install

fget: \
load dns_ipq6.o dns_random.o dns_rcrw.o dns_ip6.o dns_ipq.o  \
dns_packet.o dns_resolve.o dns_sortip6.o dns_transmit.o dns_dfd.o  \
dns_domain.o dns_ip.o dns_rcip.o dns_sortip.o strerr_die.o strerr_sys.o \
error.o error_str.o ndelay_off.o openreadclose.o readclose.o  \
socket_bind.o socket_conn.o socket_tcp.o socket_udp.o socket_conn6.o  \
socket_tcp6.o env.o iopause.o ndelay_on.o open_read.o taia_add.o  \
taia_approx.o taia_frac.o taia_less.o taia_now.o taia_pack.o taia_sub.o \
taia_uint.o tai_pack.o byte_chr.o byte_copy.o byte_diff.o byte_zero.o  \
case_diffb.o fmt_ulong.o ip4_scan.o scan_ulong.o str_chr.o str_len.o  \
str_start.o uint16_pack.o uint16_unpack.o uint32_unpack.o ip6_scan.o  \
scan_0x.o alloc.o stralloc_cat.o stralloc_catb.o stralloc_cats.o  \
stralloc_copy.o stralloc_eady.o stralloc_opyb.o stralloc_opys.o  \
stralloc_pend.o alloc_re.o socket_getifidx.o buffer_2.o buffer_put.o  \
fget.o
	./load fget dns_ipq6.o dns_random.o dns_rcrw.o dns_ip6.o \
	dns_ipq.o dns_packet.o dns_resolve.o dns_sortip6.o \
	dns_transmit.o dns_dfd.o dns_domain.o dns_ip.o dns_rcip.o \
	dns_sortip.o strerr_die.o strerr_sys.o error.o error_str.o \
	ndelay_off.o openreadclose.o readclose.o socket_bind.o \
	socket_conn.o socket_tcp.o socket_udp.o socket_conn6.o \
	socket_tcp6.o env.o iopause.o ndelay_on.o open_read.o taia_add.o \
	taia_approx.o taia_frac.o taia_less.o taia_now.o taia_pack.o \
	taia_sub.o taia_uint.o tai_pack.o byte_chr.o byte_copy.o \
	byte_diff.o byte_zero.o case_diffb.o fmt_ulong.o ip4_scan.o \
	scan_ulong.o str_chr.o str_len.o str_start.o uint16_pack.o \
	uint16_unpack.o uint32_unpack.o ip6_scan.o scan_0x.o alloc.o \
	stralloc_cat.o stralloc_catb.o stralloc_cats.o stralloc_copy.o \
	stralloc_eady.o stralloc_opyb.o stralloc_opys.o stralloc_pend.o \
	alloc_re.o socket_getifidx.o buffer_2.o buffer_put.o

fget_nodns: \
load strerr_die.o strerr_sys.o error_str.o ndelay_off.o socket_conn6.o \
socket_tcp6.o env.o ndelay_on.o byte_copy.o byte_diff.o byte_zero.o  \
fmt_ulong.o ip4_scan.o scan_ulong.o str_chr.o str_len.o str_start.o  \
uint16_pack.o ip6_scan.o scan_0x.o stralloc_cat.o stralloc_catb.o  \
stralloc_cats.o stralloc_eady.o stralloc_opyb.o stralloc_opys.o  \
stralloc_pend.o alloc_re.o socket_getifidx.o buffer_2.o buffer_put.o  \
error.o socket_conn.o alloc.o fget_nodns.o socket_tcp.o
	./load fget_nodns strerr_die.o strerr_sys.o error_str.o \
	ndelay_off.o socket_conn6.o socket_tcp6.o env.o ndelay_on.o \
	byte_copy.o byte_diff.o byte_zero.o fmt_ulong.o ip4_scan.o \
	scan_ulong.o str_chr.o str_len.o str_start.o uint16_pack.o \
	ip6_scan.o scan_0x.o stralloc_cat.o stralloc_catb.o \
	stralloc_cats.o stralloc_eady.o stralloc_opyb.o stralloc_opys.o \
	stralloc_pend.o alloc_re.o socket_getifidx.o buffer_2.o \
	buffer_put.o error.o socket_conn.o alloc.o socket_tcp.o

dietfget: \
load dns_ipq6.o dns_random.o dns_rcrw.o dns_ip6.o dns_ipq.o  \
dns_packet.o dns_resolve.o dns_sortip6.o dns_transmit.o dns_dfd.o  \
dns_domain.o dns_ip.o dns_rcip.o dns_sortip.o strerr_die.o strerr_sys.o \
error.o error_str.o ndelay_off.o openreadclose.o readclose.o  \
socket_bind.o socket_conn.o socket_tcp.o socket_udp.o socket_conn6.o  \
socket_tcp6.o env.o iopause.o ndelay_on.o open_read.o taia_add.o  \
taia_approx.o taia_frac.o taia_less.o taia_now.o taia_pack.o taia_sub.o \
taia_uint.o tai_pack.o byte_chr.o byte_copy.o byte_diff.o byte_zero.o  \
case_diffb.o fmt_ulong.o ip4_scan.o scan_ulong.o str_chr.o str_len.o  \
str_start.o uint16_pack.o uint16_unpack.o uint32_unpack.o ip6_scan.o  \
scan_0x.o alloc.o stralloc_cat.o stralloc_catb.o stralloc_cats.o  \
stralloc_copy.o stralloc_eady.o stralloc_opyb.o stralloc_opys.o  \
stralloc_pend.o alloc_re.o socket_getifidx.o buffer_2.o buffer_put.o  \
fget.o
	gcc -nostdlib -s -o dietfget fget.o dns_ipq6.o dns_random.o dns_rcrw.o dns_ip6.o \
	dns_ipq.o dns_packet.o dns_resolve.o dns_sortip6.o \
	dns_transmit.o dns_dfd.o dns_domain.o dns_ip.o dns_rcip.o \
	dns_sortip.o strerr_die.o strerr_sys.o error.o error_str.o \
	ndelay_off.o openreadclose.o readclose.o socket_bind.o \
	socket_conn.o socket_tcp.o socket_udp.o socket_conn6.o \
	socket_tcp6.o env.o iopause.o ndelay_on.o open_read.o taia_add.o \
	taia_approx.o taia_frac.o taia_less.o taia_now.o taia_pack.o \
	taia_sub.o taia_uint.o tai_pack.o byte_chr.o byte_copy.o \
	byte_diff.o byte_zero.o case_diffb.o fmt_ulong.o ip4_scan.o \
	scan_ulong.o str_chr.o str_len.o str_start.o uint16_pack.o \
	uint16_unpack.o uint32_unpack.o ip6_scan.o scan_0x.o alloc.o \
	stralloc_cat.o stralloc_catb.o stralloc_cats.o stralloc_copy.o \
	stralloc_eady.o stralloc_opyb.o stralloc_opys.o stralloc_pend.o \
	alloc_re.o socket_getifidx.o buffer_2.o buffer_put.o \
	../dietlibc/start.o ../dietlibc/dietlibc.a -lgcc

dietfget_nodns: \
load strerr_die.o strerr_sys.o error_str.o ndelay_off.o socket_conn6.o \
socket_tcp6.o env.o ndelay_on.o byte_copy.o byte_diff.o byte_zero.o  \
fmt_ulong.o ip4_scan.o scan_ulong.o str_chr.o str_len.o str_start.o  \
uint16_pack.o ip6_scan.o scan_0x.o stralloc_cat.o stralloc_catb.o  \
stralloc_cats.o stralloc_eady.o stralloc_opyb.o stralloc_opys.o  \
stralloc_pend.o alloc_re.o socket_getifidx.o buffer_2.o buffer_put.o  \
error.o socket_conn.o alloc.o fget_nodns.o socket_tcp.o
	gcc -nostdlib -s -o dietfget_nodns fget_nodns.o strerr_die.o strerr_sys.o error_str.o \
	ndelay_off.o socket_conn6.o socket_tcp6.o env.o ndelay_on.o \
	byte_copy.o byte_diff.o byte_zero.o fmt_ulong.o ip4_scan.o \
	scan_ulong.o str_chr.o str_len.o str_start.o uint16_pack.o \
	ip6_scan.o scan_0x.o stralloc_cat.o stralloc_catb.o \
	stralloc_cats.o stralloc_eady.o stralloc_opyb.o stralloc_opys.o \
	stralloc_pend.o alloc_re.o socket_getifidx.o buffer_2.o \
	buffer_put.o error.o socket_conn.o alloc.o socket_tcp.o \
	../dietlibc/start.o ../dietlibc/dietlibc.a

compile: \
warn-auto.sh conf-cc
	( cat warn-auto.sh; \
	echo exec "`head -1 conf-cc`" '-c $${1+"$$@"}' \
	) > compile
	chmod 755 compile

preprocess: \
warn-auto.sh conf-cc
	( cat warn-auto.sh; \
	echo exec "`head -1 conf-cc`" '-E $${1+"$$@"}' \
	) > preprocess
	chmod 755 preprocess

load: \
warn-auto.sh conf-ld
	( cat warn-auto.sh; \
	echo 'main="$$1"; shift'; \
	echo exec "`head -1 conf-ld`" \
	'-o "$$main" "$$main".o $${1+"$$@"}' \
	) > load
	chmod 755 load

choose: \
warn-auto.sh choose.sh
	cat warn-auto.sh choose.sh \
	> choose
	chmod 755 choose

iopause.h: \
choose compile load trypoll.c iopause.h1 iopause.h2
	./choose clr trypoll iopause.h1 iopause.h2 > iopause.h

uint32.h: \
preprocess tryulong.c uint32.h1 uint32.h2
	if test `./preprocess tryulong.c | tail -1` == 32; then cat uint32.h2; else cat uint32.h1; fi > uint32.h

uint64.h: \
preprocess tryulong.c uint64.h1 uint64.h2
	if test `./preprocess tryulong.c | tail -1` == 64; then cat uint64.h2; else cat uint64.h1; fi > uint64.h

haveip6.h: \
tryip6.c choose compile haveip6.h1 haveip6.h2
	./choose c tryip6 haveip6.h1 haveip6.h2 > haveip6.h

sockaddr_in6.h: \
trysa6.c choose compile sockaddr_in6.h1 sockaddr_in6.h2 haveip6.h
	./choose c trysa6 sockaddr_in6.h1 sockaddr_in6.h2 > sockaddr_in6.h

select.h: \
choose compile trysysel.c select.h1 select.h2
	./choose c trysysel select.h1 select.h2 > select.h

socket.lib: \
trylsock.c compile load
	( ( ./compile trylsock.c && \
	./load trylsock -lsocket -lnsl ) >/dev/null 2>&1 \
	&& echo -lsocket -lnsl || exit 0 ) > socket.lib
	rm -f trylsock.o trylsock

haven2i.h: \
tryn2i.c choose compile load socket.lib haven2i.h1 haven2i.h2
	cp /dev/null haven2i.h
	./choose cL tryn2i haven2i.h1 haven2i.h2 socket > haven2i.h

clean:
	rm -f `cat TARGETS`

tar:
	cd .. && tar cf fget.tar.bz2 fget --use=bzip2

install: \
load install.o strerr_sys.o strerr_die.o buffer_2.o buffer_put.o \
str_len.o error.o open_read.o byte_copy.o error_str.o buffer.o \
open_trunc.o buffer_copy.o buffer_get.o byte_cr.o hier.o auto_home.o
	./load install strerr_sys.o strerr_die.o buffer_2.o buffer_put.o \
	str_len.o error.o open_read.o byte_copy.o error_str.o buffer.o \
	open_trunc.o buffer_copy.o buffer_get.o byte_cr.o hier.o \
	auto_home.o

auto-str: \
load auto-str.o buffer_put.o error.o str_len.o byte_copy.o
	./load auto-str buffer_put.o error.o str_len.o byte_copy.o

auto_home.c: \
auto-str conf-home
	./auto-str auto_home `head -1 conf-home` > auto_home.c

# automatically generated dependancies follow
alloc.o: \
compile alloc.c alloc.h error.h
	./compile alloc.c

alloc_re.o: \
compile alloc_re.c alloc.h byte.h
	./compile alloc_re.c

auto-str.o: \
compile auto-str.c buffer.h readwrite.h exit.h
	./compile auto-str.c

auto_home.o: \
compile auto_home.c
	./compile auto_home.c

buffer.o: \
compile buffer.c buffer.h
	./compile buffer.c

buffer_2.o: \
compile buffer_2.c readwrite.h buffer.h
	./compile buffer_2.c

buffer_copy.o: \
compile buffer_copy.c buffer.h
	./compile buffer_copy.c

buffer_get.o: \
compile buffer_get.c buffer.h byte.h error.h
	./compile buffer_get.c

buffer_put.o: \
compile buffer_put.c buffer.h str.h byte.h error.h
	./compile buffer_put.c

byte_chr.o: \
compile byte_chr.c byte.h
	./compile byte_chr.c

byte_copy.o: \
compile byte_copy.c byte.h
	./compile byte_copy.c

byte_cr.o: \
compile byte_cr.c byte.h
	./compile byte_cr.c

byte_diff.o: \
compile byte_diff.c byte.h
	./compile byte_diff.c

byte_zero.o: \
compile byte_zero.c byte.h
	./compile byte_zero.c

case_diffb.o: \
compile case_diffb.c case.h
	./compile case_diffb.c

dns_dfd.o: \
compile dns_dfd.c error.h alloc.h byte.h dns.h stralloc.h gen_alloc.h iopause.h taia.h tai.h uint64.h
	./compile dns_dfd.c

dns_domain.o: \
compile dns_domain.c error.h alloc.h case.h byte.h dns.h stralloc.h gen_alloc.h iopause.h taia.h tai.h uint64.h
	./compile dns_domain.c

dns_ip.o: \
compile dns_ip.c stralloc.h gen_alloc.h uint16.h byte.h dns.h iopause.h taia.h tai.h uint64.h
	./compile dns_ip.c

dns_ip6.o: \
compile dns_ip6.c stralloc.h gen_alloc.h uint16.h byte.h dns.h iopause.h taia.h tai.h uint64.h ip6.h ip4.h alloc.h
	./compile dns_ip6.c

dns_ipq.o: \
compile dns_ipq.c stralloc.h gen_alloc.h case.h byte.h str.h dns.h iopause.h taia.h tai.h uint64.h
	./compile dns_ipq.c

dns_ipq6.o: \
compile dns_ipq6.c stralloc.h gen_alloc.h case.h byte.h str.h dns.h iopause.h taia.h tai.h uint64.h ip6.h alloc.h
	./compile dns_ipq6.c

dns_packet.o: \
compile dns_packet.c error.h dns.h stralloc.h gen_alloc.h iopause.h taia.h tai.h uint64.h
	./compile dns_packet.c

dns_random.o: \
compile dns_random.c dns.h stralloc.h gen_alloc.h iopause.h taia.h tai.h uint64.h uint32.h
	./compile dns_random.c

dns_rcip.o: \
compile dns_rcip.c taia.h tai.h uint64.h openreadclose.h stralloc.h gen_alloc.h byte.h ip4.h env.h dns.h iopause.h
	./compile dns_rcip.c

dns_rcrw.o: \
compile dns_rcrw.c taia.h tai.h uint64.h env.h byte.h str.h openreadclose.h stralloc.h gen_alloc.h dns.h iopause.h
	./compile dns_rcrw.c

dns_resolve.o: \
compile dns_resolve.c iopause.h taia.h tai.h uint64.h byte.h dns.h stralloc.h gen_alloc.h
	./compile dns_resolve.c

dns_sortip.o: \
compile dns_sortip.c byte.h dns.h stralloc.h gen_alloc.h iopause.h taia.h tai.h uint64.h
	./compile dns_sortip.c

dns_sortip6.o: \
compile dns_sortip6.c byte.h dns.h stralloc.h gen_alloc.h iopause.h taia.h tai.h uint64.h
	./compile dns_sortip6.c

dns_transmit.o: \
compile dns_transmit.c socket.h uint16.h uint32.h alloc.h error.h byte.h readwrite.h dns.h stralloc.h gen_alloc.h iopause.h taia.h tai.h uint64.h
	./compile dns_transmit.c

env.o: \
compile env.c str.h env.h
	./compile env.c

error.o: \
compile error.c error.h
	./compile error.c

error_str.o: \
compile error_str.c error.h
	./compile error_str.c

fget.o: \
compile fget.c dns.h stralloc.h gen_alloc.h iopause.h taia.h tai.h uint64.h strerr.h byte.h scan.h socket.h uint16.h uint32.h ip6.h ndelay.h env.h
	./compile fget.c

fget_nodns.o: \
compile fget_nodns.c fget.c strerr.h byte.h scan.h socket.h uint16.h uint32.h ip6.h ndelay.h stralloc.h gen_alloc.h env.h
	./compile fget_nodns.c

fmt_ulong.o: \
compile fmt_ulong.c fmt.h
	./compile fmt_ulong.c

hier.o: \
compile hier.c
	./compile hier.c

install.o: \
compile install.c buffer.h strerr.h error.h open.h readwrite.h exit.h
	./compile install.c

iopause.o: \
compile iopause.c taia.h tai.h uint64.h select.h iopause.h
	./compile iopause.c

ip4_scan.o: \
compile ip4_scan.c scan.h ip4.h
	./compile ip4_scan.c

ip6_scan.o: \
compile ip6_scan.c scan.h ip4.h ip6.h
	./compile ip6_scan.c

ndelay_off.o: \
compile ndelay_off.c ndelay.h
	./compile ndelay_off.c

ndelay_on.o: \
compile ndelay_on.c ndelay.h
	./compile ndelay_on.c

open_read.o: \
compile open_read.c open.h
	./compile open_read.c

open_trunc.o: \
compile open_trunc.c open.h
	./compile open_trunc.c

openreadclose.o: \
compile openreadclose.c error.h open.h readclose.h stralloc.h gen_alloc.h openreadclose.h
	./compile openreadclose.c

readclose.o: \
compile readclose.c readwrite.h error.h readclose.h stralloc.h gen_alloc.h
	./compile readclose.c

scan_0x.o: \
compile scan_0x.c scan.h
	./compile scan_0x.c

scan_ulong.o: \
compile scan_ulong.c scan.h
	./compile scan_ulong.c

socket_bind.o: \
compile socket_bind.c byte.h socket.h uint16.h uint32.h
	./compile socket_bind.c

socket_conn.o: \
compile socket_conn.c readwrite.h byte.h socket.h uint16.h uint32.h
	./compile socket_conn.c

socket_conn6.o: \
compile socket_conn6.c sockaddr_in6.h byte.h socket.h uint16.h uint32.h ip6.h haveip6.h error.h
	./compile socket_conn6.c

socket_getifidx.o: \
compile socket_getifidx.c socket.h uint16.h uint32.h haven2i.h
	./compile socket_getifidx.c

socket_tcp.o: \
compile socket_tcp.c ndelay.h socket.h uint16.h uint32.h readwrite.h
	./compile socket_tcp.c

socket_tcp6.o: \
compile socket_tcp6.c ndelay.h socket.h uint16.h uint32.h haveip6.h error.h readwrite.h
	./compile socket_tcp6.c

socket_udp.o: \
compile socket_udp.c ndelay.h socket.h uint16.h uint32.h readwrite.h
	./compile socket_udp.c

str_chr.o: \
compile str_chr.c str.h
	./compile str_chr.c

str_len.o: \
compile str_len.c str.h
	./compile str_len.c

str_start.o: \
compile str_start.c str.h
	./compile str_start.c

stralloc_cat.o: \
compile stralloc_cat.c byte.h stralloc.h gen_alloc.h
	./compile stralloc_cat.c

stralloc_catb.o: \
compile stralloc_catb.c stralloc.h gen_alloc.h byte.h
	./compile stralloc_catb.c

stralloc_cats.o: \
compile stralloc_cats.c byte.h str.h stralloc.h gen_alloc.h
	./compile stralloc_cats.c

stralloc_copy.o: \
compile stralloc_copy.c byte.h stralloc.h gen_alloc.h
	./compile stralloc_copy.c

stralloc_eady.o: \
compile stralloc_eady.c alloc.h stralloc.h gen_alloc.h gen_allocdefs.h
	./compile stralloc_eady.c

stralloc_opyb.o: \
compile stralloc_opyb.c stralloc.h gen_alloc.h byte.h
	./compile stralloc_opyb.c

stralloc_opys.o: \
compile stralloc_opys.c byte.h str.h stralloc.h gen_alloc.h
	./compile stralloc_opys.c

stralloc_pend.o: \
compile stralloc_pend.c alloc.h stralloc.h gen_alloc.h gen_allocdefs.h
	./compile stralloc_pend.c

strerr_die.o: \
compile strerr_die.c buffer.h exit.h strerr.h
	./compile strerr_die.c

strerr_sys.o: \
compile strerr_sys.c error.h strerr.h
	./compile strerr_sys.c

tai_pack.o: \
compile tai_pack.c tai.h uint64.h
	./compile tai_pack.c

taia_add.o: \
compile taia_add.c taia.h tai.h uint64.h
	./compile taia_add.c

taia_approx.o: \
compile taia_approx.c taia.h tai.h uint64.h
	./compile taia_approx.c

taia_frac.o: \
compile taia_frac.c taia.h tai.h uint64.h
	./compile taia_frac.c

taia_less.o: \
compile taia_less.c taia.h tai.h uint64.h
	./compile taia_less.c

taia_now.o: \
compile taia_now.c taia.h tai.h uint64.h
	./compile taia_now.c

taia_pack.o: \
compile taia_pack.c taia.h tai.h uint64.h
	./compile taia_pack.c

taia_sub.o: \
compile taia_sub.c taia.h tai.h uint64.h
	./compile taia_sub.c

taia_uint.o: \
compile taia_uint.c taia.h tai.h uint64.h
	./compile taia_uint.c

uint16_pack.o: \
compile uint16_pack.c uint16.h
	./compile uint16_pack.c

uint16_unpack.o: \
compile uint16_unpack.c uint16.h
	./compile uint16_unpack.c

uint32_unpack.o: \
compile uint32_unpack.c uint32.h
	./compile uint32_unpack.c

