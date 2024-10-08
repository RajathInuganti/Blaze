/*** Definition Section with includes, statements, variables etc.
that can be accessed inside yylex() and main() ***/
%{
    int count = 0;
%}

alpha [a-zA-Z]
digit [0-9]
unary "++"|"--"

/***
Rules for creating automata
{ printf("matched text: %s", yytext); }
***/

%%
"int"       { printf("INT"); }
"float"     { printf("FLOAT"); }
"char"      { printf("CHAR"); }
"void"      { printf("VOID"); }

"for"       { printf("FOR"); }
"while"     { printf("WHILE"); }
"if"        { printf("IF"); }
"else"      { printf("ELSE"); }
"return"    { printf("RETURN"); }
"continue"  { printf("CONTINUE"); }
"switch"    { printf("SWITCH"); }
"case"      { printf("CASE"); }
"default"   { printf("DEFAULT"); }
"break"     { printf("BREAK"); }

"true"      { printf("TRUE"); }
"false"     { printf("FALSE"); }

[-]?{digit}+                { printf("NUMBER"); }
[-]?{digit}+\.{digit}{1,6}  { printf("FLOATVAL"); }
{alpha}({alpha}|{digit})*   { printf("IDENTIFIER"); }
{unary}                     { printf("UNARY"); }

"<="    { printf("LE"); }
">="    { printf("GE"); }
"=="    { printf("EQ"); }
"!="    { printf("NE"); }
">"	    { printf("GT"); }
"<"	    { printf("LT"); }
"&&"	{ printf("AND"); }
"||"	{ printf("OR"); }
"+"     { printf("ADD"); }
"-"     { printf("SUBTRACT"); }
"/"     { printf("DIVIDE"); }
"*"     { printf("MULTIPLY"); }


\/\/.*                      { printf("COMMENT"); }
[ \t]*                      { printf("WHITESPACE"); }
[\n]                        { printf("NEWLINE"); }
.	                        { printf("RANDOM"); }

["].*["]    { printf("STR"); }
['].[']     { printf("CHARACTER"); }
%%

/*** Code Section which is compiled along with the
     the declaration section in the generated
     lex.yy.c file***/

int yywrap(){
    return 1;
}

int main(int argc, char **argv){

    yylex();

    return 0;
}