all: parse run

lex:
	flex lax.lex
	gcc lex.yy.c -o compilercompiler.out

parse:
	bison -d parser.y
	gcc lex.yy.c parser.tab.h parser.tab.c -o parser.out

run:
	./parser.out


