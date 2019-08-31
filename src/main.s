.include "radixsort.s"
.global _start


.section .data
    arr: .word 170, 45, 75, 90, 802, 69, 4, 20
    n: .word 8
    #arr: .word 423,65,1004,53,5
    #n: .word 5
    #arr: .word 2, 90, 20, 1
    #n: .word 4
    #arr: .word 24985, 399824, 298342
    #n: .word 3



.section .text



_start:
    la t0,n
    ld a2,0(t0)
    la a3,arr
    jal ra,radixsort
exit:

    li t0,0        #radixsort completed ---- check x/8d &arr for output
    li t1,100      #radixsort completed ---- check x/8d &arr for output
wait:
    addi t0,t0,1   #radixsort completed ---- check x/8d &arr for output
    blt t0,t1,wait #radixsort completed ---- check x/8d &arr for output

    li a7, 93
    ecall
    