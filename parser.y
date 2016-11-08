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
%token PUNC_KW FAKE_ID  FAKE_NUMCONST FAKE_REAL CHARCONST_SINGLEQOUTE CHARCONST  WHITESPACE COMMENT KW_RECORD KW_STATIC KW_INT KW_REAL KW_BOOL KW_CHAR KW_IF KW_ELSE KW_SWITCH KW_END KW_CASE KW_DEFAULT KW_WHILE KW_RETURN KW_SEMICOLON KW_BREAK KW_PLUS KW_MINUS KW_EQUAL KW_DIVIDE KW_MULTIPLY KW_MODULU KW_COND_OR KW_COND_AND KW_COND_ELSE KW_COND_THEN KW_COND_NOT KW_RELOP KW_COLON KW_QUESTION_MARK PAR_OP PAR_CL BR_OP BR_CL CR_OP CR_CL Unknown

%token <ival> NUMCONST
%token <rval> REAL
%token <bval> BOOLCONST
%token <id> ID

%right KW_EQUAL
%left KW_PLUS KW_MINUS
%left KW_MULTIPLY KW_DIVIDE
%left KW_COND_OR
%left KW_COND_AND
%left KW_COND_ELSE

%%
program : declarationList {
            fprintf(fout, "Rule 1 \t\t program -> declarationList\n");
        };
declarationList : declarationList declaration {
            fprintf(fout, "Rule 2 \t\t declarationList -> declarationList declaration\n");
        }; | declaration
        {
            fprintf(fout, "Rule 3 \t\t declarationList -> declaration\n");
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

recDeclaration : KW_RECORD ID CR_OP localDeclarations CR_CL
               {
                 fprintf(fout, "Rule 7 \t\t declarationList -> declarationList declaration\n");
               };
varDeclaration : typeSpecifier varDecList KW_SEMICOLON
               {
                 fprintf(fout, "Rule 8 \t\t declarationList -> declarationList declaration\n");
               };

scopedVarDeclaration : scopedTypeSpecifier varDecList KW_SEMICOLON {
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
		};
params : paramList{
		fprintf(fout, "Rule 26 \t\t declarationList -> declarationList declaration\n");
		};| %empty
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
		};| %empty
		{
		fprintf(fout, "Rule 43 \t\t declarationList -> declarationList declaration\n");
		};
statementList :	statementList statement{
		fprintf(fout, "Rule 44 \t\t declarationList -> declarationList declaration\n");
		};| %empty
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
		};| %empty
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
expression : mutable KW_EQUAL expression{
		fprintf(fout, "Rule 59 \t\t declarationList -> declarationList declaration\n");
		};|
		mutable KW_PLUS KW_EQUAL expression {
		fprintf(fout, "Rule 60 \t\t declarationList -> declarationList declaration\n");
		};|
		mutable KW_MINUS KW_EQUAL expression{
		fprintf(fout, "Rule 61 \t\t declarationList -> declarationList declaration\n");
		};|
		mutable KW_MULTIPLY KW_EQUAL expression{
		fprintf(fout, "Rule 62 \t\t declarationList -> declarationList declaration\n");
		};|
		mutable KW_DIVIDE KW_EQUAL expression{
		fprintf(fout, "Rule 63 \t\t declarationList -> declarationList declaration\n");
		};|
		mutable KW_PLUS KW_PLUS {
		fprintf(fout, "Rule 64 \t\t declarationList -> declarationList declaration\n");
		};|
		mutable KW_MINUS KW_MINUS {
		fprintf(fout, "Rule 65 \t\t declarationList -> declarationList declaration\n");
		};|
		simpleExpression{
		fprintf(fout, "Rule 66 \t\t declarationList -> declarationList declaration\n");
		};
simpleExpression : simpleExpression KW_COND_OR simpleExpression {
		fprintf(fout, "Rule 67 \t\t declarationList -> declarationList declaration\n");
		};|
		simpleExpression KW_COND_AND simpleExpression {
		fprintf(fout, "Rule 68 \t\t declarationList -> declarationList declaration\n");
		};|
		simpleExpression KW_COND_OR KW_COND_ELSE simpleExpression {
		fprintf(fout, "Rule 69 \t\t declarationList -> declarationList declaration\n");
		};|
		simpleExpression KW_COND_AND KW_COND_THEN simpleExpression{
		fprintf(fout, "Rule 70 \t\t declarationList -> declarationList declaration\n");
		};|
		KW_COND_NOT simpleExpression{
		fprintf(fout, "Rule 71 \t\t declarationList -> declarationList declaration\n");
		};|
		relExpression{
		fprintf(fout, "Rule 72 \t\t declarationList -> declarationList declaration\n");
		};
relExpression : mathlogicExpression relop mathlogicExpression {
		fprintf(fout, "Rule 73 \t\t declarationList -> declarationList declaration\n");
		};|
		mathlogicExpression {
		fprintf(fout, "Rule 74 \t\t declarationList -> declarationList declaration\n");
		};
relop : KW_RELOP{
		fprintf(fout, "Rule 75-80 \t\t declarationList -> declarationList declaration\n");
		};
mathlogicExpression : mathlogicExpression mathop mathlogicExpression {
		fprintf(fout, "Rule 81 \t\t declarationList -> declarationList declaration\n");
		};|
		unaryExpression{
		fprintf(fout, "Rule 82 \t\t declarationList -> declarationList declaration\n");
		};
mathop : KW_PLUS{
		fprintf(fout, "Rule 83 \t\t declarationList -> declarationList declaration\n");
		};|
		KW_MINUS{
		fprintf(fout, "Rule 84 \t\t declarationList -> declarationList declaration\n");
		};|
		KW_MULTIPLY{
		fprintf(fout, "Rule 85 \t\t declarationList -> declarationList declaration\n");
		};|
		KW_DIVIDE{
		fprintf(fout, "Rule 86 \t\t declarationList -> declarationList declaration\n");
		};|
		KW_MODULU{
		fprintf(fout, "Rule 87 \t\t declarationList -> declarationList declaration\n");
		};
unaryExpression : unaryop unaryExpression{
		fprintf(fout, "Rule 88 \t\t declarationList -> declarationList declaration\n");
		};|
		factor{
		fprintf(fout, "Rule 89 \t\t declarationList -> declarationList declaration\n");
		};
unaryop : KW_MINUS {
		fprintf(fout, "Rule 90 \t\t declarationList -> declarationList declaration\n");
		};|
		KW_MULTIPLY{
		fprintf(fout, "Rule 91 \t\t declarationList -> declarationList declaration\n");
		};|
		KW_QUESTION_MARK{
		fprintf(fout, "Rule 92 \t\t declarationList -> declarationList declaration\n");
		};
factor : immutable {
		fprintf(fout, "Rule 93 \t\t declarationList -> declarationList declaration\n");
		};|
		mutable{
		fprintf(fout, "Rule 94 \t\t declarationList -> declarationList declaration\n");
		};
mutable : ID {
		fprintf(fout, "Rule 95 \t\t declarationList -> declarationList declaration\n");
		};|
		mutable BR_OP expression BR_CL {
		fprintf(fout, "Rule 96 \t\t declarationList -> declarationList declaration\n");
		};|
		mutable PUNC_KW ID{
		fprintf(fout, "Rule 97 \t\t declarationList -> declarationList declaration\n");
		};
immutable : PAR_OP expression PAR_CL{
		fprintf(fout, "Rule 98 \t\t declarationList -> declarationList declaration\n");
		};|
		call {
		fprintf(fout, "Rule 99 \t\t declarationList -> declarationList declaration\n");
		};|
		constant{
		fprintf(fout, "Rule 100 \t\t declarationList -> declarationList declaration\n");
		};
call : ID PAR_OP args PAR_CL{
		fprintf(fout, "Rule 101 \t\t declarationList -> declarationList declaration\n");
		};
args : argList {
		fprintf(fout, "Rule 102 \t\t declarationList -> declarationList declaration\n");
		};| %empty
		{
		fprintf(fout, "Rule 103 \t\t declarationList -> declarationList declaration\n");
		};
argList : argList PUNC_KW expression {
		fprintf(fout, "Rule 104 \t\t declarationList -> declarationList declaration\n");
		};|
		expression{
		fprintf(fout, "Rule 105 \t\t declarationList -> declarationList declaration\n");
		};
constant : NUMCONST {
		fprintf(fout, "Rule 106 \t\t declarationList -> declarationList declaration\n");
		};|
		REAL{
		fprintf(fout, "Rule 107 \t\t declarationList -> declarationList declaration\n");
		};|
		CHARCONST {
		fprintf(fout, "Rule 108 \t\t declarationList -> declarationList declaration\n");
		};|
		BOOLCONST{
		fprintf(fout, "Rule 109 \t\t declarationList -> declarationList declaration\n");
		};
RECTYPE : ID {
		fprintf(fout, "Rule 110 \t\t declarationList -> declarationList declaration\n");
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
