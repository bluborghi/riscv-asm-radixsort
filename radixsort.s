.equ bytes,4
.global _start

.section .data
    #arr: .dword 170, 45, 75, 90, 802, 24, 2, 66
    arr: .word 742,534,61
    tmp: .word 0,0,0
    n: .word 3
    count: .word 0,0,0,0,0,0,0,0,0,0

.section .text



_start:
    la t0,n
    ld a2,0(t0)
    la a3,arr
    jal ra,radixsort
exit:
    nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop


    li a7, 93
    ecall


max:
#a2=n #a3=array address #a0=max #a1=max address
li t3,0     #i
loop1: 
    li t0,bytes
    mul t1,t3,t0 #offset
    add t0,a3,t1 #address of arr[i]
    lw t2,0(t0)  #arr[i]

    beq t3,zero,then1 #if first iteraction
    j else1 #if max is already initialized
then1:
    #set first element as max
    addi a0,t2,0
    addi a1,t0,0
    j endif1
else1:
    bgt t2,a0,then2 #if arr[i]>max
    j endif2 #do nothing
then2:
    #set arr[i] as max
    addi a0,t2,0
    addi a1,t0,0
endif2:
endif1:
    
    addi t3,t3,1 #i++
    blt t3,a2,loop1 #i<n
endloop1:
    ret

radixsort:  #a2=n #a3=array address
    addi sp,sp,-8
    sd ra,0(sp)
    jal ra,max
    ld ra,0(sp)
    addi sp,sp,+8 
    
    #for (int exp = 1; max >= exp; exp *= 10) 
	#	countSort(arr, n, exp); 
    
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
    ret


countingsort: #a2=n #a3=array address #a4=exp
    #int count[10] = {0}
    li t0,0     #i
    li t3,10    #n
    la t1,count
loop5:
    li t2, bytes
    mul t2,t0,t2    #t2 = offset
    add t2,t1,t2    #t2 = addr of count[i]
    sw  zero,0(t2)  #count[i] = 0

    addi t0,t0,1    #i++
    blt t0,t3,loop5 #i<n
endloop5:

    li t0,0 #i=0
loop3:
    li t1,bytes
    mul t1,t0,t1 #offset from arr[0] to arr[i]
    add t2,a3,t1 #t2 = address of arr[i]
    lw t3,0(t2)  #t3 = arr[i]

    # count[ (arr[i]/exp)%10 ]++; 
    div t4,t3,a4
    li t1,10
    rem t4,t4,t1 #t4 = (arr[i]/exp)%10 //index of count array
    la a5,count  #a5 = count array address
    li t1,bytes
    mul t1,t4,t1 #offset from count[0] to count[t4]
    add t5,a5,t1 #t5 = address of count[t4]
    lw t6,0(t5)  #t6 = count[t4]
    addi t6,t6,1 #t6 = t6 + 1
    sw t6,0(t5)  #count[t4] = count[t4] + 1

    addi t0,t0,1
    blt t0,a2,loop3
endloop3:


#for (i = 1; i < 10; i++) 
#		count[i] += count[i - 1]; 
    li t0,1 #i=1
loop4:
    la a5,count  #a5 = count array address
    li t1,bytes
    addi t0,t0,-1   #t0 = i-1
    mul t1,t0,t1    #offset from count[0] to count[i-1]
    add t2,a5,t1    #t2 = address of count[i-1]
    lw t4,0(t2)     #t4 = count[i-1]
    addi t0,t0,+1   #t0 = i
    li t1,bytes
    mul t1,t0,t1    #offset from count[0] to count[i]
    add t2,a5,t1    #t2 = address of count[i]
    lw t3,0(t2)     #t3 = count[i]
    add t3,t3,t4   #t3 = count[i] + count[i - 1]; 
    sw t3,0(t2)     #count[i] = t3

    addi t0,t0,1
    li t1,10
    blt t0,t1,loop4
endloop4:

    ret
