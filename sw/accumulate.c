#include <stdio.h>

#define LOOP_SIZE 4

void accumulate(int *a, int *b, int *c, int *sum) {
  
  int i;
  for (i = 0; i < LOOP_SIZE; i++) {
  //DFGLoop:accumulate
    c[i] *= a[i] + b[i];
    *sum += c[i];
    //printf("Sum [%d] = %d \n", i, sum[i]);
  }
}

int main (){
  
  int a[100]={0};
  int b[100];
  int c[100]={2};
  int sum = 1;

  for (int i = 0; i < 100; i++) {
        b[i] = i;
        c[i] = 2;        
  }

  accumulate(a, b, c, &sum);

  for (int i = 0 ; i < LOOP_SIZE; i++){
    printf("C [%d] = %d \n", i, c[i]);
  }
  printf("Sum = %d \n", sum);

  return 0;
}


