extern char auto_home[];

void hier()
{
  h(auto_home,-1,-1,-1);
  d(auto_home,"bin",-1,-1,0755);

  c(auto_home,"bin","fget",-1,-1,0755);

  d(auto_home,"man",-1,-1,0755);
  d(auto_home,"man/man1",-1,-1,0755);
  c(auto_home,"man/man1","fget.1",-1,-1,0644);
}
