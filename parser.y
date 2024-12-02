%{

    #define YYERROR_VERBOSE 1

    #include <stdio.h>
    #include <stdlib.h>

    #include "lex.yy.c"

    void yyerror(char *s);
    int yylex();
    int yywrap();

    extern int yylineno;
%}

%token PRINTF SCANF
%token INT FLOAT CHAR VOID
%token FOR WHILE IF ELSE RETURN CONTINUE BREAK
%token TRUE FALSE
%token NUMBER FLOATVAL IDENTIFIER UNARY
%token LE GE EQ NE GT LT
%token AND OR NOT
%token ADD SUBTRACT DIVIDE MULTIPLY
%token STR CHARACTER

%start program

%left OR
%left AND
%left EQ NE
%left LT LE GT GE
%left ADD SUBTRACT
%left MULTIPLY DIVIDE
%right NOT
%right UNARY

%%

program
    : statement_list
    ;

statement_list
    : statement
    | statement_list statement
    ;

statement
    : declaration ';'
    | function_declaration
    | function_call ';'
    | control_flow
    | unary ';'
    | RETURN expression ';'
    | CONTINUE ';'
    | BREAK ';'
    | PRINTF '(' STR ')' ';'
    | SCANF '(' STR ',' '&' IDENTIFIER ')' ';'
    ;

declaration
    : type_specifier IDENTIFIER
    | type_specifier IDENTIFIER '=' expression
    | IDENTIFIER '=' expression
    ;

function_declaration
    : type_specifier IDENTIFIER '(' parameter_list ')' '{' statement_list '}'
    ;

parameter_list
    : parameter_list ',' parameter
    | parameter
    |
    ;

parameter
    : type_specifier IDENTIFIER
    ;

type_specifier
    : INT
    | FLOAT
    | CHAR
    | VOID
    ;

function_call
    : IDENTIFIER '(' argument_list ')'
    ;

argument_list
    : argument_list ',' expression
    | expression
    |
    ;

control_flow
    : IF '(' expression ')' '{' statement_list '}' else
    | WHILE '(' relop ')' '{' statement_list '}'
    | FOR '(' declaration ';' relop ';' unary ')' '{' statement_list '}'
    ;

else
    : ELSE '{' statement_list '}'
    |
    ;

expression
    : arithmetic
    | cop
    | relop
    | NOT expression
    | '(' expression ')'
    | function_call
    | value
    ;

unary
    : IDENTIFIER UNARY
    | UNARY IDENTIFIER
    ;

arithmetic
    : expression ADD expression
    | expression SUBTRACT expression
    | expression MULTIPLY expression
    | expression DIVIDE expression
    ;

relop
    : expression LT expression
    | expression GT expression
    | expression LE expression
    | expression GE expression
    | expression EQ expression
    | expression NE expression
    ;

cop
    : expression AND expression
    | expression OR expression
    ;


/*
expression
    : expression ADD expression
    | expression SUBTRACT expression
    | expression MULTIPLY expression
    | expression DIVIDE expression
    | expression LT expression
    | expression GT expression
    | expression LE expression
    | expression GE expression
    | expression EQ expression
    | expression NE expression
    | expression AND expression
    | expression OR expression
    | NOT expression
    | '(' expression ')'
    | function_call
    | value
    ; */

value
    : NUMBER
    | FLOATVAL
    | CHARACTER
    | IDENTIFIER
    | TRUE
    | FALSE
    ;

%%

/* yacc error handler */
void yyerror(char *s){
    fprintf (stderr, "Error | Line: %d\n%s\n", yylineno, s);
}

int main(void){
    return yyparse();
}

