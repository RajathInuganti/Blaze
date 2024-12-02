/*** Definition Section with includes, statements, variables etc.
that can be accessed inside yylex() and main() ***/
%{
    #include "parser.tab.h"
    int count = 0;
%}

%option yylineno

alpha [a-zA-Z]
digit [0-9]
unary "++"|"--"

/***
Rules for creating automata
{ printf("matched text: %s", yytext); }
***/

%%
"printf"    { return PRINTF; }
"scanf"     { return SCANF; }
"int"       { return INT; }
"float"     { return FLOAT; }
"char"      { return CHAR; }
"void"      { return VOID; }

"for"       { return FOR; }
"while"     { return WHILE; }
"if"        { return IF; }
"else"      { return ELSE; }
"return"    { return RETURN; }
"continue"  { return CONTINUE; }
"break"     { return BREAK; }

"true"      { return TRUE; }
"false"     { return FALSE; }

[-]?{digit}+                { return NUMBER; }
[-]?{digit}+\.{digit}{1,6}  { return FLOATVAL; }
{alpha}({alpha}|{digit})*   { return IDENTIFIER; }
{unary}                     { return UNARY; }

"<="    { return LE; }
">="    { return GE; }
"=="    { return EQ; }
"!="    { return NE; }
">"	    { return GT; }
"<"	    { return LT; }
"&&"	{ return AND; }
"||"	{ return OR; }
"!"     { return NOT; }
"+"     { return ADD; }
"-"     { return SUBTRACT; }
"/"     { return DIVIDE; }
"*"     { return MULTIPLY; }


\/\/.*  { ; }
[ \t]*  { ; }
[\n]    { count++; }
.	    { return *yytext; }

["].*["]    { return STR; }
['].[']     { return CHARACTER; }
%%

/*** Code Section which is compiled along with the
     the declaration section in the generated
     lex.yy.c file***/

int yywrap(){
    return 1;
}

/*** This article, by Anjaneya Tripathi, has been used as 
a reference for creating the lexical analyzer:
https://medium.com/codex/building-a-c-compiler-using-lex-and-yacc-446262056aaa ***/