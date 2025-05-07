# Compute fib using this algorithm
#
# int fib(int n) {
#     if (n <= 1 ) {
# 	return n;
#     }
#     
#     int nm1 = 1;	# n - 1
#     int nm2 = 0;	# n - 2
#     int result;		# our result
#     for(int i = 2; i <= n; i++) {
# 	result = nm2 + nm1;
# 	nm2 = nm1;
# 	nm1 = result;
#     }
# 
#     return result;
# }

    .globl fib
fib:	
    li	    a1, 1		    # if a0 <= 1
    bgt	    a0, a1, _fib_big	    # .
    ret				    # since fib(0) is 0 and fib(1) is one,
				    # in either case we can leave a0 as
				    # our input paramter as our return 
				    # parameter
_fib_big:
    mv	    t0, a0		    # t0 = n
    li	    t1, 1		    # t1 = nm1 
    li	    t2, 0		    # t2 = nm2
    li	    t3, 2		    # t3 = i
_fib_loop:
    bgtu    t3, t0, _fib_exit	    # if i no longer <= n, exit
    addw    a0, t2, t1		    # result = nm2 + nm1
    mv	    t2, t1		    # nm2 = nm1
    mv	    t1, a0		    # nm1 = result
    addi    t3, t3, 1		    # i++
    j	    _fib_loop
_fib_exit:
    ret				    # Return result in a0


# From https://youtu.be/-M55pxfBAmU?si=gS53UV_hyFIC44vF&t=1354
# "RISC-V Assembly Code #7: Example Program"
# by hhp3

# Compute fib(n) using this algorithm
#
#    int fib (int n) {
#      if (n <= 1) return n;
#      return fib(n-1) + fib(n-2)
#    }

    .globl fib_r
fib_r:
    li	    a1, 1		    # if a0 <= 1
    bgt	    a0, a1, ELSE	    # .
    ret				    #   return
ELSE:				    # endif
    addi    sp, sp, -24		    # Allocate stack frame
    sd	    s1, 0(sp)		    # Save s1, s2, ra
    sd	    s2,	8(sp)		    # .
    sd	    ra, 16(sp)		    # .
    addi    s2, a0, -2		    # s2 = n-2
    addi    a0, a0, -1		    # a0 = n-1
    call    fib_r		    # a0 = fib(a0)
    mv	    s1, a0		    # s1 = a0
    mv	    a0, s2		    # a0 = n-2
    call    fib_r		    # a0 = fib(a0)
    add	    a0, a0, s1		    # a0 = a0 + s1
    ld	    s1, 0(sp)		    # Restore s1, s2, ra
    ld	    s2, 8(sp)		    # .
    ld	    ra, 16(sp)		    # .
    addi    sp, sp, 24		    # Pop stack frame
    ret				    # Return a0
