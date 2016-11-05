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
varDeclaration : typeSpecifier varDeclist KW_SEMICOLON
               {
                 fprintf(fout, "Rule 8 \t\t declarationList -> declarationList declaration\n");
               };
scopedVarDeclaration : scopedTypeSpecifier varDeclList KW_SEMICOLON
                     {
                        fprintf(fout, "Rule 9 \t\t declarationList -> declarationList declaration\n");
                     };
varDeclList : varDeclList PUNC_KW varDeclInitialize
            {
                fprintf(fout, "Rule 10 \t\t declarationList -> declarationList declaration\n");
            }; | varDeclInitialize
                {
                    fprintf(fout, "Rule 11 \t\t declarationList -> declarationList declaration\n");
                };
varDeclInitialize : varDeclId
                  {
                    fprintf(fout, "Rule 12 \t\t declarationList -> declarationList declaration\n");
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
params : paramList{
		fprintf(fout, "Rule 26 \t\t declarationList -> declarationList declaration\n");
		};|
		{
		fprintf(fout, "Rule 27 \t\t declarationList -> declarationList declaration\n");
		};
paramList : paramList KW_SEMICOLON paramTypeList{
		fprintf(fout, "Rule 28 \t\t declarationList -> declarationList declaration\n");
		};|
		paramTypeList{
		fprintf(fout, "Rule 29 \t\t declarationList -> declarationList declaration\n");
		};
paramTypeList : typeSpecifier paramIdList {
		fprintf(fout, "Rule 30 \t\t declarationList -> declarationList declaration\n");
		};
paramIdList : paramIdList PUNC_KW paramId {
		fprintf(fout, "Rule 31 \t\t declarationList -> declarationList declaration\n");
		};|
		paramId{
		fprintf(fout, "Rule 32 \t\t declarationList -> declarationList declaration\n");
		};
paramId : ID {
		fprintf(fout, "Rule 33 \t\t declarationList -> declarationList declaration\n");
		};|
		ID BR_OP BR_CL{
		fprintf(fout, "Rule 34 \t\t declarationList -> declarationList declaration\n");
		};
statement : expressionStmt {
		fprintf(fout, "Rule 35 \t\t declarationList -> declarationList declaration\n");
		};|
		compoundStmt{
		fprintf(fout, "Rule 36 \t\t declarationList -> declarationList declaration\n");
		};|
		selectionStmt{
		fprintf(fout, "Rule 37 \t\t declarationList -> declarationList declaration\n");
		};|
		iterationStmt{
		fprintf(fout, "Rule 38 \t\t declarationList -> declarationList declaration\n");
		};|
		returnStmt{
		fprintf(fout, "Rule 39 \t\t declarationList -> declarationList declaration\n");
		};|
		breakStmt{
		fprintf(fout, "Rule 40 \t\t declarationList -> declarationList declaration\n");
		};
compoundStmt :	CR_OP localDeclarations statementList CR_CL{
		fprintf(fout, "Rule 41 \t\t declarationList -> declarationList declaration\n");
		};
localDeclarations :	localDeclarations scopedVarDeclaration{
		fprintf(fout, "Rule 42 \t\t declarationList -> declarationList declaration\n");
		};|
		{
		fprintf(fout, "Rule 43 \t\t declarationList -> declarationList declaration\n");
		};
statementList :	statementList statement{
		fprintf(fout, "Rule 44 \t\t declarationList -> declarationList declaration\n");
		};|
		{
		fprintf(fout, "Rule 45 \t\t declarationList -> declarationList declaration\n");
		};
expressionStmt :	expression KW_SEMICOLON{
		fprintf(fout, "Rule 46 \t\t declarationList -> declarationList declaration\n");
		};|
		KW_SEMICOLON{
		fprintf(fout, "Rule 47 \t\t declarationList -> declarationList declaration\n");
		};

selectionStmt : KW_IF PAR_OP simpleExpression PAR_CL statement {
		fprintf(fout, "Rule 48 \t\t declarationList -> declarationList declaration\n");
		};|
		KW_IF PAR_OP simpleExpression PAR_CL statement KW_ELSE statement{
		fprintf(fout, "Rule 49 \t\t declarationList -> declarationList declaration\n");
		};|
		KW_SWITCH PAR_OP simpleExpression PAR_CL caseElement defaultElement KW_END{
		fprintf(fout, "Rule 50 \t\t declarationList -> declarationList declaration\n");
		};

caseElement :KW_CASE NUMCONST KW_COLON statement KW_SEMICOLON { 
		fprintf(fout, "Rule 51 \t\t declarationList -> declarationList declaration\n");
		};|
		caseElement KW_CASE NUMCONST KW_COLON statement KW_SEMICOLON{
		fprintf(fout, "Rule 52 \t\t declarationList -> declarationList declaration\n");
		};
defaultElement : KW_DEFAULT KW_COLON statement KW_SEMICOLON {
		fprintf(fout, "Rule 53 \t\t declarationList -> declarationList declaration\n");
		};|
		{
		fprintf(fout, "Rule 54 \t\t declarationList -> declarationList declaration\n");
		};
iterationStmt : KW_WHILE PAR_OP simpleExpression PAR_CL statement {
		fprintf(fout, "Rule 55 \t\t declarationList -> declarationList declaration\n");
		};
returnStmt : KW_RETURN KW_SEMICOLON {
		fprintf(fout, "Rule 56 \t\t declarationList -> declarationList declaration\n");
		};|
		KW_RETURN expression KW_SEMICOLON {
		fprintf(fout, "Rule 57 \t\t declarationList -> declarationList declaration\n");
		};
breakStmt : KW_BREAK KW_SEMICOLON {
		fprintf(fout, "Rule 58 \t\t declarationList -> declarationList declaration\n");
		};


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