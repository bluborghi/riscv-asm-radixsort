.include "functions.s"
.global _start


.section .data
    arr: .word 170, 45, 75, 90, 802, 69, 4, 20
    n: .word 8



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
    