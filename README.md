# Compiler
My (humble) attempt at building a compiler

Lexical Analysis phase uses Flex.
Parsing - Syntactic Analysis phase uses Bison.
C is the primary language used for creating this toy compiler.

To install Flex: `brew install flex`
To install Bison: `brew install bison`

To build: enter `make build`.
To test: enter `make run`

Testing requires a file named `test.c`. Any generic `C` Language 
code can be used to test the parser & lexer.

