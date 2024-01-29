#define LOOP_SIZE 100

void sum(int *a, int *b, int *c) {
  int i;
  for (i = 0; i < LOOP_SIZE; i++) {
    //DFGLoop:x
    c[i] = a[i] + b[i];
  }
}
