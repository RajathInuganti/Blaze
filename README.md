# Compiler
My (humble) attempt at building a compiler

Flex is used for the Lexical Analysis phase.
Bison is used for the parsing phase.
C is the primary language used for creating this toy compiler.

To build: enter `make build`.
To test: enter `make run`

Testing requires a file named `test.c`. Any generic `C` Language 
code can be used to test the parser & lexer.

