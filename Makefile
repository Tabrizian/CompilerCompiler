all: lex parse run

lex:
	flex lax.lex

parse:
	bison -d parser.y
	gcc lex.yy.c parser.tab.h parser.tab.c -o parser.out

run:
	./parser.out


