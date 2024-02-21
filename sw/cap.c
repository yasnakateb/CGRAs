#include <stdio.h>

// #define LOOP_SIZE 100
#define SIZE 5 
void cap(int *a, int *b, int *m) {
  int i;
  int c1 = 2;
  int c2 = 3;
  int c3 = 6;
  for (i = 0; i < SIZE; i++) {
  //DFGLoop:cap
      b[i] = (((((a[i] * 3 * c1) >> 2)) * c1 ))* (((((m[i] * 3 * a[i]) >> 2)) * a[i]));
  }
}



int main (){


  //int a [SIZE]= {2, 4, 8, 16,32};
  //int m [SIZE]= {1, 2, 3, 4, 5};


  int a [SIZE]= {1, 2, 3, 4, 5};
  int m [SIZE]= {1, 2, 3, 4, 5};

  int b [SIZE]= {0, 0, 0, 0, 0};

  cap(a, b, m);

  for (int i = 0 ; i < SIZE; i++){
    printf("B [%d] = %d \n", i, b[i]);
  }

  return 0;
}
