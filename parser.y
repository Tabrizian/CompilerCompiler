%{

#include <stdio.h>

extern FILE *yyin;
extern int yylineno;
extern char *yytext;

void yyerror(const char *s);

FILE *fout;
%}

%union {
    int ival;
    float rval;
    _Bool bval;
    char *id;
}
%token PUNC_KW ID REAL FAKE_ID NUMCONST FAKE_NUMCONST FAKE_REAL CHARCONST_SINGLEQOUTE CHARCONST BOOLCONST WHITESPACE COMMENT KW_RECORD KW_STATIC KW_INT KW_REAL KW_BOOL KW_CHAR KW_IF KW_ELSE KW_SWITCH KW_END KW_CASE KW_DEFAULT KW_WHILE KW_RETURN KW_SEMICOLON KW_BREAK KW_PLUS KW_MINUS KW_EQUAL KW_DIVIDE KW_MULTIPLY KW_MODULU KW_COND_OR KW_COND_AND KW_COND_ELSE KW_COND_THEN KW_COND_NOT KW_RELOP PAR_OP PAR_CL BR_OP BR_CL CR_OP CR_CL Unknown

%%
program : declarationList {
            fprintf(fout, "Rule 1 \t\t program -> declarationList\n");
        };
declarationList : FAKE_ID
%%
int main() {

    // open a file handle to a particular file:
    yyin = fopen("input.txt", "r");
    fout = fopen("output.txt", "w");
    fprintf(fout, "\n \t \t \t PARSER \n");
    fprintf(fout, "Rule No. --> Rule Description \n");
    if (fout == NULL) {
        printf("Error opening file!\n");
        //exit(1);

    }

    // make sure it is valid:
    else if (!yyin) {
        printf("Error opening file!\n");
        //exit(1);
    }

    // set flex to read from it instead of defaulting to STDIN:
    // parse through the input until there is no more:
    else
        yyparse();

    return 0;

}



void yyerror(const char *s) {
    fprintf(fout, "**Error: Line %d near token '%s' --> Message: %s **\n",
        yylineno, yytext, s);
    printf("**Error: Line %d near token '%s' --> Message: %s **\n", yylineno,
        yytext, s);
}
