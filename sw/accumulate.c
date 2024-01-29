#define LOOP_SIZE 100
void accumulate(int *a, int *b, int *c, int *sum) {
  int i;
  for (i = 0; i < LOOP_SIZE; i++) {
  //DFGLoop:accumulate
    c[i] *= a[i] + b[i];
    *sum += c[i];
  }
}
