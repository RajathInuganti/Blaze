%{

    #define YYERROR_VERBOSE 1

    #include <stdio.h>
    #include <stdlib.h>

    #include "lex.yy.c"
    #include "hash.h"

    void yyerror(char *s);
    int yylex();
    int yywrap();
    void store_type();
    void put(char keyword, char *key);

    /* These are the entries (values of the hash table).
       The key would be the name of the identifier. */
    typedef struct entry {
        int scope;
        char *keyword;
        char *type;
        int lineno;
    } entry;

    ht *symtable;
    int size = 1;
    /* start with global scope val: 0 */
    int scope = 0;
    char type[20];

    extern int yylineno;
%}

%union {
    char *str;
}

%token PRINTF SCANF
%token INT FLOAT CHAR VOID
%token FOR WHILE IF ELSE RETURN CONTINUE BREAK
%token TRUE FALSE
%token NUMBER FLOATVAL UNARY
%token LE GE EQ NE GT LT
%token AND OR NOT
%token ADD SUBTRACT DIVIDE MULTIPLY
%token STR CHARACTER
%token <str> IDENTIFIER

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
    : type_specifier IDENTIFIER { put('I', $2); }
    | type_specifier IDENTIFIER { put('I', $2); } '=' expression
    | IDENTIFIER '=' expression
    ;

function_declaration
    : type_specifier IDENTIFIER { put('F', $2); } '(' parameter_list ')' '{' statement_list '}'
    ;

parameter_list
    : parameter_list ',' parameter
    | parameter
    |
    ;

parameter
    : type_specifier IDENTIFIER { put('P', $2); }
    ;

type_specifier
    : INT { store_type(); }
    | FLOAT { store_type(); }
    | CHAR { store_type(); }
    | VOID { store_type(); }
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

value
    : NUMBER
    | FLOATVAL
    | CHARACTER
    | IDENTIFIER
    | TRUE
    | FALSE
    ;

%%

void store_type() {
   strcpy(type, yytext);
}

void put(char keyword, char *key) {
    entry *et = malloc(sizeof(entry));
    et->lineno = yylineno;
    et->scope = scope;
    if(keyword == 'I') {
        et->type = strdup(type);
        et->keyword = strdup("Identifier");
    } else if(keyword == 'F') {
        et->type = strdup(type);
        et->keyword = strdup("Function");
    } else if(keyword == 'P') {
        et->type = strdup(type);
        et->keyword = strdup("Parameter");
    }
    ht_set(symtable, key, et);
}

/* yacc error handler */
void yyerror(char *s){
    fprintf (stderr, "Error | Line: %d\n%s\n", yylineno, s);
}

int main(void){

    symtable = ht_create();

    int ret = yyparse();

    hti it = ht_iterator(symtable);
    while (ht_next(&it)) {
        printf("%s\n", it.key);
        entry *value = (entry *)it.value;
        printf("*----------Entry----------*:\n");
        printf("%s\n", value->keyword);
        printf("%s\n", value->type);
        printf("%d\n", value->lineno);
        printf("*----------End of Entry----------*:\n");
        free(it.value);
    }

    ht_destroy(symtable);
    return ret;
}

