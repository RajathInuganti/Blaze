/*** Definition Section with includes, statements, variables etc.
that can be accessed inside yylex() and main() ***/
%{
    #include "parser.tab.h"
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
"printf"    { strcpy(yylval.obj.name, (yytext)); return PRINTF; }
"scanf"     { strcpy(yylval.obj.name, (yytext)); return SCANF; }
"int"       { strcpy(yylval.obj.name, (yytext)); return INT; }
"float"     { strcpy(yylval.obj.name, (yytext)); return FLOAT; }
"char"      { strcpy(yylval.obj.name, (yytext)); return CHAR; }
"void"      { strcpy(yylval.obj.name, (yytext)); return VOID; }

"for"       { strcpy(yylval.obj.name, (yytext)); return FOR; }
"while"     { strcpy(yylval.obj.name, (yytext)); return WHILE; }
"if"        { strcpy(yylval.obj.name, (yytext)); return IF; }
"else"      { strcpy(yylval.obj.name, (yytext)); return ELSE; }
"return"    { strcpy(yylval.obj.name, (yytext)); return RETURN; }
"continue"  { strcpy(yylval.obj.name, (yytext)); return CONTINUE; }
"break"     { strcpy(yylval.obj.name, (yytext)); return BREAK; }

"true"      { strcpy(yylval.obj.name, (yytext)); return TRUE; }
"false"     { strcpy(yylval.obj.name, (yytext)); return FALSE; }

[-]?{digit}+                { strcpy(yylval.obj.name, (yytext)); return NUMBER; }
[-]?{digit}+\.{digit}{1,6}  { strcpy(yylval.obj.name, (yytext)); return FLOATVAL; }
{alpha}({alpha}|{digit})*   { strcpy(yylval.obj.name, (yytext)); return IDENTIFIER; }
{unary}                     { strcpy(yylval.obj.name, (yytext)); return UNARY; }

"<="    { strcpy(yylval.obj.name, (yytext)); return LE; }
">="    { strcpy(yylval.obj.name, (yytext)); return GE; }
"=="    { strcpy(yylval.obj.name, (yytext)); return EQ; }
"!="    { strcpy(yylval.obj.name, (yytext)); return NE; }
">"	    { strcpy(yylval.obj.name, (yytext)); return GT; }
"<"	    { strcpy(yylval.obj.name, (yytext)); return LT; }
"&&"	{ strcpy(yylval.obj.name, (yytext)); return AND; }
"||"	{ strcpy(yylval.obj.name, (yytext)); return OR; }
"!"     { strcpy(yylval.obj.name, (yytext)); return NOT; }
"+"     { strcpy(yylval.obj.name, (yytext)); return ADD; }
"-"     { strcpy(yylval.obj.name, (yytext)); return SUBTRACT; }
"/"     { strcpy(yylval.obj.name, (yytext)); return DIVIDE; }
"*"     { strcpy(yylval.obj.name, (yytext)); return MULTIPLY; }


\/\/.*  { ; }
[ \t]*  { ; }
[\n]    { ; }
.	    { return *yytext; }

["].*["]    { strcpy(yylval.obj.name, (yytext)); return STR; }
['].[']     { strcpy(yylval.obj.name, (yytext)); return CHARACTER; }
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