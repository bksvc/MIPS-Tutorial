.data
	bannermsg: .asciiz "MIPS Hesap makinesine hos geldiniz! \n"
	usagemsg: .asciiz "Lutfen yapmak istediginiz islemi seciniz, ornek: +, -, /, * \n"
	v1msg: .asciiz "Birinci Degiskeni gir: "
	v2msg: .asciiz "Ikinci Degiskeni gir: "
	vOperandmsg: .asciiz "Yapilacak islemi belirt: "
	outmsg: .asciiz "Islem Sonucu: "
	inputErrormsg: .asciiz "Hatali Girdi! \n"
	newLineFlag: .asciiz "\n"
	carryOutmsg: .asciiz "Bolumden kalan sonuc: "

# SET CALCULATE OPRANDS #

v1: .word 1
v2: .word 1
operationFlag: .word 2
out: .word 1
carryOut: .word 1

.text
main:
	# BANNER BASTIR VE PROGRAMIN OZELLIKLERINI TANIT #
	li $v0, 4
	la $a0, bannermsg
	syscall
	li $v0, 4
	la $a0, usagemsg
	syscall
	li $v0, 4
	la $a0, newLineFlag
	syscall
	# YAPILACAK ISLEMI ISTE #
	li $v0, 4
	la $a0, vOperandmsg
	syscall
	li $v0, 8 # syscall 8 al
	la $a0, operationFlag # operasyon bayragini a0'a yukle
	li $a1, 2 #a1'e 2bytelik yer ac
	syscall

	# MATEMATIKSEL IFADEYI ALACAK REGISTERI TANIMLA #
	lw $t0, 0($a0) #a0'in 0.indexini(default) oku ve t0'a yukle

	# MATEMATIKSEL IFADELERI GECICI REGISTERLARA YUKLE #
	li $t1, '+'
	li $t2, '-'
	li $t3, '*'
	li $t4, '/'

	# GECICI REGISTERLARDAKI VERIYI KARSILASTIR #
	beq $t0, $t1, toplama # hangi sembolde hangisi calisiyor kontrol et ve dogru surece git
	beq $t0, $t2, cikarma
	beq $t0, $t3, carpma
	beq $t0, $t4, bolme
	j operandError
toplama:
  li $v0, 4
  la $a0, newLineFlag
  syscall
	li $v0, 4
	la $a0, v1msg
	syscall
	li $v0, 5
	syscall
	sw $v0, v1
	li $v0, 4
	la $a0, newLineFlag
	syscall
	li $v0, 4
	la $a0, v2msg
	syscall
	li $v0, 5
	syscall
	sw $v0, v2
	lw $s1, v1
	lw $s2, v2
	# TOPLAMA ISLEMI BASLANGIC #
	add $s0, $s1, $s2
	j sonuc
cikarma:
  li $v0, 4
  la $a0, newLineFlag
  syscall
  li $v0, 4
  la $a0, v1msg
  syscall
  li $v0, 5
  syscall
  sw $v0, v1
  li $v0, 4
  la $a0, newLineFlag
  syscall
  li $v0, 4
  la $a0, v2msg
  syscall
  li $v0, 5
  syscall
  sw $v0, v2
  lw $s1, v1
  lw $s2, v2
	# CIKARMA ISLEMI BASLANGIC #
 	sub $s0, $s1, $s2
  j sonuc
carpma:
  li $v0, 4
  la $a0, newLineFlag
  syscall
  li $v0, 4
  la $a0, v1msg
	syscall
  li $v0, 5
  syscall
  sw $v0, v1
  li $v0, 4
  la $a0, newLineFlag
  syscall
  li $v0, 4
  la $a0, v2msg
	syscall
  li $v0, 5
  syscall
  sw $v0, v2
  lw $s1, v1
  lw $s2, v2
	# CARPMA ISLEMI BASLANGIC #
  mult $s1, $s2
	mflo $s0
  j sonuc
bolme:
  li $v0, 4
  la $a0, newLineFlag
  syscall
  li $v0, 4
  la $a0, v1msg
	syscall
  li $v0, 5
  syscall
  sw $v0, v1
  li $v0, 4
  la $a0, newLineFlag
  syscall
  li $v0, 4
  la $a0, v2msg
	syscall
  li $v0, 5
  syscall
  sw $v0, v2
  lw $s1, v1
  lw $s2, v2

	# BOLME ISLEMI BASLANGIC #
  div $s0, $s1, $s2
	mflo $s0 # SONUC
	mfhi $s4 # KALAN
	li $v0, 4
	la $a0, carryOutmsg
	syscall
	sw $s4, carryOut
	li $v0, 1
	lw $a0, carryOut
	syscall
  li $v0, 4
  la $a0, newLineFlag
  syscall
  j sonuc
sonuc:
	li $v0, 4
	la $a0, outmsg
	syscall
  sw $s0, out
	li $v0, 1
	lw $a0, out
	syscall
  li $v0, 4
  la $a0, newLineFlag
  syscall
	j main
operandError:
	li $v0, 4
	la $a0, inputErrormsg
	li $v0, 4
	la $a0, newLineFlag
	syscall
	j main
