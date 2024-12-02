

build:
		flex lexer.lex && bison -v -d parser.y && gcc -ll parser.tab.c

run:
		./a.out<test.b