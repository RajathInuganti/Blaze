

build:
		flex lexer.lex && gcc lex.yy.c

run:
		./a.out

clean:
		rm lex.yy.c a.out