all: lex parse run
debug: lex parse-debug run

lex:
	flex lax.lex

parse:
	bison -d parser.y
	g++ -std=c++11 lex.yy.c parser.tab.h parser.tab.c -o parser.out

parse-debug:
	bison -d parser.y
	bison --verbose parser.y
	g++ -std=c++11 lex.yy.c parser.tab.h parser.tab.c -o parser.out

run:
	./parser.out

clean:
	rm lex.yy.c parser.tab.c parser.tab.h parser.out
