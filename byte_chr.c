#include "byte.h"

unsigned int byte_chr(const char* s,register unsigned int n,int c)
{
  register char ch;
  register const char *t;

  ch = c;
  t = s;
  for (;;) {
    if (!n) break; if (*t == ch) break; ++t; --n;
    if (!n) break; if (*t == ch) break; ++t; --n;
    if (!n) break; if (*t == ch) break; ++t; --n;
    if (!n) break; if (*t == ch) break; ++t; --n;
  }
  return t - s;
}