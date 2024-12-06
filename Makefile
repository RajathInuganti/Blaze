

build:
		flex lexer.lex && bison -v -d parser.y && gcc -ll parser.tab.c third_party/hash.c -Ithird_party

run:
		./a.out<test.c