#include <stdio.h>

#define LOOP_SIZE 100

void accumulate(int *a, int *b, int *c, int *sum) {
  
  int i;
  for (i = 0; i < LOOP_SIZE; i++) {
  //DFGLoop:accumulate
    c[i] *= a[i] + b[i];
    sum[i] = sum[i] + c[i];
    //printf("Sum [%d] = %d \n", i, sum[i]);
  }
}

int main (){
  
  int a[100]={0};
  int b[100];
  int c[100];
  int sum[100];

  for (int i = 0; i < 100; i++) {
        b[i] = i;
        c[i] = 2;
        sum[i] = i;
        
  }

  accumulate(a, b, c, sum);

  for (int i = 0 ; i < LOOP_SIZE; i++){
    printf("C [%d] = %d \n", i, c[i]);
    printf("Sum [%d] = %d \n", i, sum[i]);
  }

  return 0;
}


