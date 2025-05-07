#include "kernel/types.h"
#include "user/user.h"

/* fib.s */
int fib(int n);
int fib_r(int n);

int main() {
    for (int i = 0; i<11; i++ ) {
	printf("fib(%d) = %d\n", i, fib(i));
	printf("fib_r(%d) = %d\n", i, fib_r(i));
    }
}
