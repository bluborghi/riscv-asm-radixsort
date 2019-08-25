.global _start

.section .data
    arr: .dword 24,21,44
    n: .dword 3

.section .text



_start:
    la t0,n
    ld a2,0(t0)
    la t0,arr
    ld a3,0(t0)
    jal ra,max
exit:
    li a7, 93
    ecall


max:
#a2=n #a3=array address #a0=max #a1=max address
li t3,0     #i
loop1: 
    li t0,8
    mul t1,t3,t0 #offset
    add t0,a0,t1 #address of arr[i]
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
