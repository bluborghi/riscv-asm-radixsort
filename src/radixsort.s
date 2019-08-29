.equ bytes,4
.include "countingsort.s"
.include "arrayutils.s"
.section .text

radixsort:  #a2=n #a3=input array address 
    addi sp,sp,-8
    sd ra,0(sp)
    jal ra,max
    ld ra,0(sp)
    addi sp,sp,+8 
    
    #for (int exp = 1; max >= exp; exp *= 10) 
	#	countSort(arr, n, exp); 
    addi sp,sp,-16
    sd s0,0(sp)
    sd s1,8(sp)

    
    addi s0,a0,0    #s0 = max
    li s1,1         #s1 = exp
loop2:
    addi a4, s1, 0 #passing exp to countingsort

    addi sp,sp,-8
    sd ra,0(sp)
    jal ra,countingsort
    ld ra,0(sp)
    addi sp,sp,+8 

    li t0,10
    mul s1,s1,t0
    bge s0,s1,loop2    
endloop2:

   
    ld s0,0(sp)
    ld s1,8(sp)
    addi sp,sp,16
    ret
