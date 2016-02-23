.data
	
	data2: .word 0
	data1: .word 0x17D7840 #timmer speed
	#data1: .word 25000 #timmer speed
	data3: .word 1
	#data4: .word 250
	#data7: .word 7
	
.text

	lw $t6,data1#
	#lw $t7,data4#
	#lw $t5,data3#
	#lw $t4,data7#
	#lw $t3,data3#
	lw $t2,data2#
	lw $t1,data3#
	
	#lw $t4,data4#
	
	#add  $t3,$t2,$t1
	#mul  $t4,$t4,$t1
	add  $t2,$t2,$t1
	#add  $t5,$t2,$t1
	
LOOP:    beq $zero,$zero,LOOP
	
