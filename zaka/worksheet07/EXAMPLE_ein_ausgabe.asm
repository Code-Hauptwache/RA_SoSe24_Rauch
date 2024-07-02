#
# Beispiele zur Ein- und Ausgabe mit MARS
#
# Es werden Pseudoinstruktionen verwendet.
# MARS Settings: Permit extended (pseudo) instructions and formats
#
# Naeheres und weitere System Calls in der MARS Hilfe-Funktion
#
####################################################################
# Ausgabe einer Zeichenkette
####################################################################
	.text
	la $a0,some_string
	li $v0,4		# print string
	syscall
	.data 
some_string:
	.asciiz "Ein String"	# null-terminierte Zeichenkette
# 
####################################################################
# Eingabe einer Zeichenkette
####################################################################
	.text
	la $a0,buffer		# Puffer fuer null-terminierte Zeichenkette
	li $a1,128		# maximale Anzahl von Zeichen in diesem Beispiel: 127
	li $v0,8		# read string
	syscall
# Wenn Laenge der eingelesenen Zeichenkette = n-1, Terminierung \0
# Wenn Laenge der eingelesenen Zeichenkette < n-1, Terminierung \n\0
	.data
buffer:
	.space 128		# null-terminierte Zeichenkette maximaler Laenge 127
# 
####################################################################
# Ausgabe einer ganzen Zahl in Dezimaldarstellung mit Vorzeichen
####################################################################
	.text
	li $a0,-4711		# Auszugebende Zahl in $a0, hier -4711
	li $v0,1		# print integer
	syscall
# Ganze Zahl in Zweierkomplementdarstellung in $a0 wird in Dezimaldarstellung mit Vorzeichen ausgegeben
# 
####################################################################
# Eingabe einer ganzen Zahl in Dezimaldarstellung mit Vorzeichen
####################################################################
#
	.text
	li $v0,5		# read integer
	syscall
# $v0 enthaelt eingegebene Zahl in Zweierkomplementdarstellung
# 
####################################################################
# Ausgabe eines Zeichens
####################################################################
	.text
	li $a0,'\n'		# Auszugebendes Zeichen $a0, hier Zeilenvorschub
	li $v0,11		# print character
	syscall
# Zeichen in ASCII-Kodierung in $a0 wird ausgegeben
#
####################################################################
# Eingabe eines Zeichens
####################################################################
	.text
	li $v0,12		# read character
	syscall
# $v0 enthaelt eingelesenes Zeichen in ASCII-Kodierung
# 
####################################################################
# Ausgabe einer 32-bit Gleitkommazahl Zahl (IEEE single precision)
####################################################################
	.text
	la $a0,variable_ieee32	# Speicheradresse der auszugebenden Zahl
	lwc1 $f12,0($a0)	# Auszugebende Zahl in FP Register f12 
	li $v0,2		# print float
	syscall
# 32-bit Gleitkommazahl wird ausgegeben
	.data
variable_ieee32:
	.float 4.711
# 
####################################################################
# Eingabe einer 32-bit Gleitkommazahl Zahl (IEEE single precision)
####################################################################
	.text
	li $v0,6		# read float
	syscall
# FP Register f0 enthaelt eingelesene Zahl im IEEE single precision Format
