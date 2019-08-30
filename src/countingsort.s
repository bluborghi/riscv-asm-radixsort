.equ bytes,4

.section .data
    count: .word 0,0,0,0,0,0,0,0,0,0

.section .text


countingsort: #a2=n #a3=array address #a4=exp 
    addi sp,sp,-16
    sd s2,0(sp)
    sd s3,8(sp)

    li t0, bytes
    mul s2, t0, a2  #s2 = byte length of tmp array
    li t0, -1
    mul t1, s2, t0  #t1 = -s2
    add sp,sp,t1    #sp = sp - byte length of tmp array
    addi s3,sp,0    #s3 = tmp array address (aka "output" array in comments)

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

#   // Store count of occurrences in count[] 
#	for (i = 0; i < n; i++) 
#		count[ (arr[i]/exp)%10 ]++; 
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

    addi t0,t0,1    #i++
    blt t0,a2,loop3 #i<n
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

#   // Build the output array 
#   for (i = n - 1; i >= 0; i--) { 
#   	count[ (arr[i]/exp)%10 ]--; 
#   	output[count[ (arr[i]/exp)%10 ] ] = arr[i]; 
#   } 
    addi t0,a2,-1 #i=n-1
loop6:
    li t1,bytes
    mul t1,t0,t1 #offset from arr[0] to arr[i]
    add t2,a3,t1 #t2 = address of arr[i]
    lw t3,0(t2)  #t3 = arr[i]

    # count[ (arr[i]/exp)%10 ]--; 
    div t4,t3,a4
    li t1,10
    rem t4,t4,t1 #t4 = (arr[i]/exp)%10 //index of count array
    la a5,count  #a5 = count array address
    li t1,bytes
    mul t1,t4,t1 #offset from count[0] to count[t4]
    add t5,a5,t1 #t5 = address of count[t4]
    lw t6,0(t5)  #t6 = count[t4]
    addi t6,t6,-1 #t6 = t6 - 1
    sw t6,0(t5)  #count[t4] = count[t4] - 1

    #keeping t3=arr[i] and t6=count[ (arr[i]/exp)%10 ]
    #free tmp registers: t1,t2,t4,t5

    li t1,bytes
    mul t1,t6,t1 #offset from output[0] to output[t6]
    add t2,s3,t1 #t2 = address of output[t6]
    sw t3,0(t2)  #output[count[ (arr[i]/exp)%10 ] ] = arr[i];

    addi t0,t0,-1 #i--
    bge t0,zero,loop6 #i>=0
endloop6:

#   //Copy the output array to arr[], so that arr[] now 
#   //contains sorted numbers according to current digit 
#   for (i = 0; i < n; i++) 
#		arr[i] = output[i]; 
    li t0,0 #i=0
loop7:
    li t1,bytes
    mul t1,t0,t1 #offset from arr[0] to arr[i]
    add t2,a3,t1 #t2 = address of arr[i]
    add t3,s3,t1 #t3 = address of output[i]
    lw t4,0(t3)  #t4 = output[i]
    sw t4,0(t2)  #arr[i] = t4

    addi t0,t0,1    #i++
    blt t0,a2,loop7 #i<n
endloop7:

   
    add sp,sp,s2    #sp = sp + byte length of tmp array
    
    ld s2,0(sp)
    ld s3,8(sp)
    addi sp,sp,16

    ret
