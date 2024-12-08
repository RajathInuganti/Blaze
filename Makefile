

build:
		flex lexer.lex && bison -v -d parser.y && gcc -ll parser.tab.c third_party/hash.c -Ithird_party -fsanitize=address -static-libsan -g -O1

run:
		MallocNanoZone=0 ./a.out<test.c