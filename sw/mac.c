#define LOOP_SIZE 100

void mac(int *a, int *b, int *sum) {
  int i;
  for (i = 0; i < LOOP_SIZE; i++) {
      //DFGLoop:mac
      *sum += a[i] * b[i];
  }
}

