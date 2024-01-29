#include <stdio.h>

//#define LOOP_SIZE 100

#define SIZE 5

void mac2(int *a, int *b, int *c, int *d, int *sum, int *sum2) {
  int i;
  for (i = 0; i < SIZE; i++) {
    //DFGLoop:mac2
      *sum += a[i] * b[i];
      *sum2 += a[i] * (b[i] + 1) * c[i] * d[i];
  }
}



int main (){


  int a [SIZE]= {1, 1, 1, 1, 1};
  int b [SIZE]= {1, 1, 1, 1, 1};
  int c [SIZE]= {1, 1, 1, 1, 1};
  int d [SIZE]= {1, 1, 1, 1, 1};

  int sum [SIZE]= {0, 0, 0, 0, 0};
  int sum2 [SIZE]= {0, 0, 0, 0, 0};

  mac2(a, b, c, d, sum, sum2);

  for (int i = 0 ; i < SIZE; i++){
    printf("Sum [%d] = %d \n", i, sum[i]);
  }

  for (int i = 0 ; i < SIZE; i++){
    printf("Sum2 [%d] = %d \n", i, sum2[i]);
  }



  return 0;
}

