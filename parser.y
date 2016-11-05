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
%token PUNC_KW ID REAL FAKE_ID NUMCONST FAKE_NUMCONST FAKE_REAL CHARCONST_SINGLEQOUTE CHARCONST BOOLCONST WHITESPACE COMMENT KW_RECORD KW_STATIC KW_INT KW_REAL KW_BOOL KW_CHAR KW_IF KW_ELSE KW_SWITCH KW_END KW_CASE KW_DEFAULT KW_WHILE KW_RETURN KW_SEMICOLON KW_BREAK KW_PLUS KW_MINUS KW_EQUAL KW_DIVIDE KW_MULTIPLY KW_MODULU KW_COND_OR KW_COND_AND KW_COND_ELSE KW_COND_THEN KW_COND_NOT KW_RELOP KW_COLON PAR_OP PAR_CL BR_OP BR_CL CR_OP CR_CL Unknown

%%
program : declarationList {
            fprintf(fout, "Rule 1 \t\t program -> declarationList\n");
        };
declarationList : declarationList declaration {
            fprintf(fout, "Rule 2 \t\t declarationList -> declarationList declaration\n");
        }; | declaration
        {
            fprintf(fout, "Rule 3 \t\t declarationList -> declarationList declaration\n");
        };
declaration : varDeclaration
        {
            fprintf(fout, "Rule 4 \t\t declarationList -> declarationList declaration\n");
        }; | funDeclaration
        {
            fprintf(fout, "Rule 5 \t\t declarationList -> declarationList declaration\n");
        }; | recDeclaration
        {
            fprintf(fout, "Rule 6 \t\t declarationList -> declarationList declaration\n");
        };

recDeclaration : KW_RECORD ID PAR_OP localDeclarations PAR_CL
               {
                 fprintf(fout, "Rule 7 \t\t declarationList -> declarationList declaration\n");
               };
varDeclaration : typeSpecifier varDeclist PUNC_KW {
                 fprintf(fout, "Rule 8 \t\t declarationList -> declarationList declaration\n");
                };
scopedVarDeclaration : scopedTypeSpecifier varDeclist PUNC_KW {
                 fprintf(fout, "Rule 9 \t\t declarationList -> declarationList declaration\n");
                };
varDecList : varDecList  PUNC_KW varDeclInitialize {
                 fprintf(fout, "Rule 10 \t\t declarationList -> declarationList declaration\n");
                };|
		varDeclInitialize{
		 fprintf(fout, "Rule 11 \t\t declarationList -> declarationList declaration\n");
		};	
varDeclInitialize : varDeclId {
                 fprintf(fout, "Rule 12 \t\t declarationList -> declarationList declaration\n");
                };|
		varDeclId KW_COLON simpleExpression{
		 fprintf(fout, "Rule 13 \t\t declarationList -> declarationList declaration\n");
		};
varDeclId : ID {
		fprintf(fout, "Rule 14 \t\t declarationList -> declarationList declaration\n");
		};|
		ID BR_OP NUMCONST BR_CL{
		fprintf(fout, "Rule 15 \t\t declarationList -> declarationList declaration\n");
		};
scopedTypeSpecifier : KW_STATIC typeSpecifier{
		fprintf(fout, "Rule 16 \t\t declarationList -> declarationList declaration\n");
		};|
		typeSpecifier{
		fprintf(fout, "Rule 17 \t\t declarationList -> declarationList declaration\n");
		};
typeSpecifier : returnTypeSpecifier{
		fprintf(fout, "Rule 18 \t\t declarationList -> declarationList declaration\n");
		};|
		RECTYPE{
		fprintf(fout, "Rule 19 \t\t declarationList -> declarationList declaration\n");
		};
returnTypeSpecifier : KW_INT{
		fprintf(fout, "Rule 20 \t\t declarationList -> declarationList declaration\n");
		};|
		 KW_REAL{
		fprintf(fout, "Rule 21 \t\t declarationList -> declarationList declaration\n");
		};|
		KW_BOOL{
		fprintf(fout, "Rule 22 \t\t declarationList -> declarationList declaration\n");
		};|
		KW_CHAR{
		fprintf(fout, "Rule 23 \t\t declarationList -> declarationList declaration\n");
		};
funDeclaration : typeSpecifier ID PAR_OP params PAR_CL statement{
		fprintf(fout, "Rule 24 \t\t declarationList -> declarationList declaration\n");
		};|
		 ID PAR_OP params PAR_CL statement{
		fprintf(fout, "Rule 25 \t\t declarationList -> declarationList declaration\n");
		};|

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
