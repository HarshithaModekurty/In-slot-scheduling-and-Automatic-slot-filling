#include <stdio.h>

int main(void) {
    int limit = 10;
    int accumulator = 0;
    for (int i = 1; i <= limit; ++i) {
        accumulator += i;
    }
    printf("sum=%d\n", accumulator);
    return 0;
}
