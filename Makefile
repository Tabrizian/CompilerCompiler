all: lex run

lex:
	flex lax.lex
	gcc lex.yy.c -o compilercompiler.out

run:
	cat input.txt | ./compilercompiler.out


