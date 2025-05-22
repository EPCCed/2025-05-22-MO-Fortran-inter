#include <stdlib.h>
#include <stdio.h>

typedef struct array_s {
  int nlen;
  float * data;
} array_t;

extern void f_subroutine(const array_t * a);

int main() {
  // Allocate and fill the array
  array_t a;
  a.nlen = 10;
  a.data = (float *)malloc(a.nlen * sizeof(float));
  printf("C array of size %2d:\n", a.nlen);
  for (int i = 0; i < a.nlen; ++i) {
    a.data[i] = 2 * i + 1.0f;
    printf("Element [%1d] %2.1f\n", i, a.data[i]);
  }

  // Call the Fortran subroutine, passing a by reference.
  f_subroutine(&a);
  
  // Free the allocated memory in a.
  free(a.data);
  a.data = NULL;

  return 0;
} 