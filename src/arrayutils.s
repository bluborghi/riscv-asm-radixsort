.equ bytes,4
.section .text

max:
    #a2=n #a3=array address #a0=max #a1=max address
    li t3,0     #i=0
    lw t2,0(a3)  #arr[i]
    #set first element as max
    addi a0,t2,0
    addi a1,a3,0
    li t3,1 #i=1
    bge t3,a2,endloop1 #i>=n
loop1: 
    li t0,bytes
    mul t1,t3,t0 #offset
    add t0,a3,t1 #address of arr[i]
    lw t2,0(t0)  #arr[i]

    bgt t2,a0,then1 #if arr[i]>max
    j endif1 #do nothing
then1:
    #set arr[i] as max
    addi a0,t2,0
    addi a1,t0,0
endif1:
    addi t3,t3,1 #i++
    blt t3,a2,loop1 #i<n
endloop1:
ret

