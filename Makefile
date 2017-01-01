all: lex parse run
debug: lex parse-debug run

lex:
	flex lax.lex

parse:
	bison -d parser.y
	g++ -std=c++14 lex.yy.c list.cpp list.h parser.tab.h parser.tab.c -g -o parser.out

parse-debug:
	bison -d parser.y
	bison --verbose parser.y
	g++ -std=c++14 lex.yy.c list.cpp list.h parser.tab.h parser.tab.c -o parser.out

run:
	./parser.out

compile:
	gcc -g intermediatecode.c stack.c stack.h

clean:
	rm lex.yy.c parser.tab.c parser.tab.h parser.out
