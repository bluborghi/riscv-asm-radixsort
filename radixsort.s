.global _start

.section .data
    #arr: .dword 170, 45, 75, 90, 802, 24, 2, 66
    arr: .dword 24,21,44
    tmp: .dword 0,0,0
    n: .dword 3
    count: .dword 0,0,0,0,0,0,0,0,0

.section .text



_start:
    la t0,n
    ld a2,0(t0)
    la a3,arr
    jal ra,radixsort
exit:
    li a7, 93
    ecall


max:
#a2=n #a3=array address #a0=max #a1=max address
li t3,0     #i
loop1: 
    li t0,8
    mul t1,t3,t0 #offset
    add t0,a3,t1 #address of arr[i]
    ld t2,0(t0)  #arr[i]

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
    li t0,0 #i=0

loop3:
    li t1,8
    mul t1,t0,t1 #offset from arr[0] to arr[i]
    add t2,a3,t1 #t2 = address of arr[i]
    ld t3,0(t2)  #t3 = arr[i]

    # count[ (arr[i]/exp)%10 ]++; 
    div t4,t3,a4
    li t1,10
    rem t4,t4,t1 #t4 = (arr[i]/exp)%10 //index of count array
    la a5,count #a5 = count array address
    li t1,8
    mul t1,t4,t1 #offset from count[0] to count[t4]
    add t5,a5,t1 #t5 = address of count[t4]
    ld t6,0(t5)  #t6 = count[t4]
    addi t6,t6,1 #t6 = t6 + 1
    sd t6,0(t5)  #count[t4] = count[t4] + 1

    addi t0,t0,1
    blt t0,a2,loop3
endloop3:



    ret
