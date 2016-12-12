%{
#include <cstdio>
#include <cstdlib>
#include <vector>
#include <fstream>
#include <iostream>
#include <string>
#include <cstring>

using namespace std;
extern FILE *yyin;
extern int yylineno;
extern char* yytext;
vector <string> quadruple[4];
vector <string> symbol_table[2];
vector <string> registers;
ofstream myfile;

int num = 0;

int symbol_table_lookup(char *token) {
}

void symbol_table_insert(string token, char *type) {
    symbol_table[0].push_back(token);
    symbol_table[1].push_back(type);
}

// What?!
char* new_temp(char *c) {
    string name("t");
    name += to_string(num);
    symbol_table_insert(name, c);
    num++;
    char *what = (char *) malloc(sizeof(char)*100);
    strcpy(what, name.c_str());
    return what;
}

void quadruple_print() {

    myfile.open("intermediatecode.c");
    myfile << "#include <stdio.h>\n\n";
    myfile << endl<<"int main(){\n\n";

    for(int i = 0 ; i < symbol_table[0].size() ; i++){
        if(symbol_table[1][i] == "integer")
            myfile << "int " << symbol_table[0][i]<<" ;"<<endl;
    }


    for(int i = 0; i < quadruple[0].size(); i++){
        myfile << "L" << i <<" : ";
        if(quadruple[2][i] == ":=")
                myfile<<quadruple[3][i]<<" = "<<quadruple[0][i]<<";"<<endl;
        else if(quadruple[2][i] == "+")
                myfile << quadruple[3][i]<<" = "<<quadruple[0][i]<<" + "<<quadruple[1][i]<<";" << endl;
        else if(quadruple[2][i] == "-")
                myfile << quadruple[3][i] << " = " << quadruple[0][i] << " - "
                    << quadruple[1][i]<<";" << endl;
        else if(quadruple[2][i] == "*")
                myfile << quadruple[3][i] << " = " << quadruple[0][i] << " * "
                    << quadruple[1][i] << ";" << endl;
        else if(quadruple[2][i] == "/")
                myfile << quadruple[3][i] << " = " <<quadruple[0][i] << " / "
                    <<  quadruple[1][i] << ";" << endl;
    }
    myfile << "L" << quadruple[0].size()<<":" <<" return 0;"<<endl;
    myfile << endl <<"}" <<endl;
}
void quadruple_push(char *arg1, char *arg2, char *op, char *result) {
    quadruple[0].push_back(arg1);
    quadruple[1].push_back(arg2);
    quadruple[2].push_back(op);
    quadruple[3].push_back(result);
}

void backpatch(char* a,int b){

}

char* merge(char* a,char* b){

}

char* makeList(int a){

}

char* intToCharStar(int a){
    char *str = new char[100];
    return str;
}

char* addToList(char* a){

}

void yyerror(const char *s);
extern int yylex(void);
FILE *fout;
%}
%union {
    struct {
        char *true_list;
        char *false_list;
        char *next_list;
        int quad;
        int is_boolean;
        char *place;
        char *code;
        char *type;
    } eval;
}
%token THEN PUNC_COMMA PUNC_DOT FAKE_ID  FAKE_NUMCONST FAKE_REAL
CHARCONST_SINGLEQOUTE CHARCONST   COMMENT KW_RECORD KW_STATIC KW_INT
KW_REAL KW_BOOL KW_CHAR KW_IF KW_ELSE KW_SWITCH KW_END KW_CASE KW_DEFAULT
KW_WHILE KW_RETURN KW_SEMICOLON KW_BREAK KW_PLUS KW_MINUS KW_EQUAL KW_DIVIDE
 KW_MULTIPLY KW_MODULU KW_COND_OR KW_COND_AND  KW_COND_THEN KW_COND_NOT
KW_RELOP KW_COLON KW_QUESTION_MARK PAR_OP PAR_CL BR_OP BR_CL CR_OP CR_CL
Unknown KW_PLUS_PLUS KW_MINUS_MINUS KW_MINUS_EQUAL KW_PLUS_EQUAL
KW_DIVIDE_EQUAL KW_MULTIPLY_EQUAL WHITESPACE
%token <eval> NUMCONST
%token <eval> REAL
%token <eval> BOOLCONST
%token <eval> ID
%token IF_WITHOUT_ELSE
%type <eval> program declarationList declaration recDeclaration varDeclaration
scopedVarDeclaration varDecList varDeclInitialize varDeclId scopedTypeSpecifier
typeSpecifier returnTypeSpecifier funDeclaration params paramList paramTypeList
paramIdList paramId statement compoundStmt localDeclarations statementList
expressionStmt selectionStmt caseElement defaultElement iterationStmt
returnStmt breakStmt expression simpleExpression relExpression relop
mathlogicExpression unaryExpression unaryop factor mutable immutable call
args argList constant
%left KW_COND_OR
%left KW_COND_AND
%left KW_PLUS KW_MINUS
%left KW_MULTIPLY KW_DIVIDE KW_MODULU
%left KW_COND_NOT
%nonassoc IF_WITHOUT_ELSE
%nonassoc ID_PREC
%left KW_COND_THEN
%left KW_ELSE
%%
program : declarationList
    {
        fprintf(fout, "Rule 1 \t\t program -> declarationList\n");
        quadruple_print();

    };
declarationList : declarationList declaration
    {
        fprintf(fout, "Rule 2 \t\t declarationList -> declarationList declaration\n");
    };
    | declaration
    {
        fprintf(fout, "Rule 3 \t\t declarationList -> declaration\n");
    };

declaration : varDeclaration
    {
        fprintf(fout, "Rule 4 \t\t declaration -> varDeclaration \n");
    };
    | funDeclaration
    {
        fprintf(fout, "Rule 5 \t\t declaration -> funDeclaration \n");
    };
    | recDeclaration
    {
        fprintf(fout, "Rule 6 \t\t declaration -> recDeclaration \n");
    };
recDeclaration : KW_RECORD ID CR_OP localDeclarations CR_CL
    {
        fprintf(fout, "Rule 7 \t\t recDeclaration -> KW_RECORD ID CR_OP localDeclarations CR_CL\n");
    };

varDeclaration : typeSpecifier varDecList KW_SEMICOLON
    {
        fprintf(fout, "Rule 8 \t\t varDeclaration -> typeSpecifier varDecList KW_SEMICOLON\n");
    };
    | ID varDecList KW_SEMICOLON
    {
        fprintf(fout, "Rule 8.1 \t\t varDeclaration -> ID varDecList KW_SEMICOLON\n");
    };

scopedVarDeclaration : scopedTypeSpecifier varDecList KW_SEMICOLON
    {
        fprintf(fout, "Rule 9 \t\t scopedVarDeclaration -> scopedTypeSpecifier varDecList KW_SEMICOLON\n");
    };

varDecList : varDecList  PUNC_COMMA varDeclInitialize
    {
        fprintf(fout, "Rule 10 \t\t varDecList -> varDecList  PUNC_COMMA varDeclInitialize\n");
    };
    | varDeclInitialize
    {
        fprintf(fout, "Rule 11 \t\t varDecList -> varDeclInitialize\n");
    };

varDeclInitialize : varDeclId
    {
        fprintf(fout, "Rule 12 \t\t varDeclInitialize -> varDeclId\n");
    };
    | varDeclId KW_COLON simpleExpression
    {
        fprintf(fout, "Rule 13 \t\t varDeclInitialize -> varDeclId KW_COLON simpleExpression\n");
    };

varDeclId : ID
    {
        fprintf(fout, "Rule 14 \t\t varDeclId -> ID\n");
    };
    | ID BR_OP NUMCONST BR_CL
    {
        fprintf(fout, "Rule 15 \t\t varDeclId -> ID BR_OP NUMCONST BR_CL\n");
    };

scopedTypeSpecifier : KW_STATIC typeSpecifier
    {
        fprintf(fout, "Rule 16 \t\t scopedTypeSpecifier -> KW_STATIC typeSpecifier\n");
    };
    | typeSpecifier
    {
        fprintf(fout, "Rule 17 \t\t scopedTypeSpecifier -> typeSpecifier\n");
    };
    | KW_STATIC ID
    {
        fprintf(fout, "Rule 17.1 \t\t scopedTypeSpecifier -> KW_STATIC ID\n");
    };

typeSpecifier : returnTypeSpecifier
    {
        fprintf(fout, "Rule 18 \t\t typeSpecifier -> returnTypeSpecifier\n");
    };

returnTypeSpecifier : KW_INT
    {
        fprintf(fout, "Rule 20 \t\t returnTypeSpecifier -> KW_INT\n");
    };
    | KW_REAL
    {
        fprintf(fout, "Rule 21 \t\t returnTypeSpecifier -> KW_REAL\n");
    };
    | KW_BOOL
    {
        fprintf(fout, "Rule 22 \t\t returnTypeSpecifier -> KW_BOOL\n");
    };
    | KW_CHAR
    {
        fprintf(fout, "Rule 23 \t\t returnTypeSpecifier -> KW_CHAR\n");
    };

funDeclaration : typeSpecifier ID PAR_OP params PAR_CL statement
    {
        fprintf(fout, "Rule 24 \t\t funDeclaration -> typeSpecifier ID PAR_OP params PAR_CL statement\n");
    };
    | ID PAR_OP params PAR_CL statement
    {
        fprintf(fout, "Rule 25 \t\t funDeclaration -> ID PAR_OP params PAR_CL statement\n");
    };
    | ID ID PAR_OP params PAR_CL statement
    {
        fprintf(fout, "Rule 25.1 \t\t funDeclaration -> ID PAR_OP params PAR_CL statement\n");
    };

params : paramList
    {
       fprintf(fout, "Rule 26 \t\t params -> paramList\n");
    };
    |
    {
        fprintf(fout, "Rule 27 \t\t params -> empty \n");
    };

paramList : paramList KW_SEMICOLON paramTypeList
    {
        fprintf(fout, "Rule 28 \t\t paramList -> paramList KW_SEMICOLON paramTypeList\n");
    };
    | paramTypeList { fprintf(fout, "Rule 29 \t\t paramList -> paramTypeList\n");
    };

paramTypeList : typeSpecifier paramIdList
    {
        fprintf(fout, "Rule 30 \t\t paramTypeList -> typeSpecifier paramIdList\n");
    };

paramIdList : paramIdList PUNC_COMMA paramId
    {
        fprintf(fout, "Rule 31 \t\t paramIdList -> paramIdList PUNC_COMMA paramId\n");
    };
    | paramId
    {
        fprintf(fout, "Rule 32 \t\t paramIdList -> paramId\n");
    };

paramId : ID {
        fprintf(fout, "Rule 33 \t\t paramId -> ID\n");
        };|
        ID BR_OP BR_CL{
        fprintf(fout, "Rule 34 \t\t paramId -> ID BR_OP BR_CL\n");
        };
statement : expressionStmt {
          fprintf(fout, "Rule 35 \t\t statement -> expressionStmt\n");
        };|
        compoundStmt{
        fprintf(fout, "Rule 36 \t\t statement -> compoundStmt\n");
        };|
        selectionStmt{
        fprintf(fout, "Rule 37 \t\t statement -> selectionStmt\n");
        };|
        iterationStmt{
        fprintf(fout, "Rule 38 \t\t statement -> iterationStmt\n");
        };|
        returnStmt{
        fprintf(fout, "Rule 39 \t\t statement -> returnStmt\n");
        };|
        breakStmt{
        fprintf(fout, "Rule 40 \t\t statement -> breakStmt\n");
        };
compoundStmt :	CR_OP localDeclarations statementList CR_CL{
             fprintf(fout, "Rule 41 \t\t compoundStmt -> CR_OP localDeclarations statementList CR_CL\n");
        };
localDeclarations :	localDeclarations scopedVarDeclaration{
                  fprintf(fout, "Rule 42 \t\t localDeclarations -> localDeclarations scopedVarDeclaration\n");
        };|{
        fprintf(fout, "Rule 43 \t\t localDeclarations -> empty\n");
        };
statementList :	statementList statement{
              fprintf(fout, "Rule 44 \t\t statementList -> statementList statement\n");
        };|{
        fprintf(fout, "Rule 45 \t\t statementList -> empty\n");
        };
expressionStmt :	expression KW_SEMICOLON{
               fprintf(fout, "Rule 46 \t\t expressionStmt -> expression KW_SEMICOLON\n");
        };|
        KW_SEMICOLON{
        fprintf(fout, "Rule 47 \t\t expressionStmt -> empty\n");
        };
selectionStmt : KW_IF PAR_OP simpleExpression PAR_CL statement %prec IF_WITHOUT_ELSE{
              fprintf(fout, "Rule 48 \t\t selectionStmt -> KW_IF PAR_OP simpleExpression PAR_CL statement\n");
        };|
        KW_IF PAR_OP simpleExpression PAR_CL statement KW_ELSE statement{
        fprintf(fout, "Rule 49 \t\t selectionStmt -> KW_IF PAR_OP simpleExpression PAR_CL statement KW_ELSE statement\n");
        };|
        KW_SWITCH PAR_OP simpleExpression PAR_CL caseElement defaultElement KW_END{
        fprintf(fout, "Rule 50 \t\t selectionStmt -> KW_SWITCH PAR_OP simpleExpression PAR_CL caseElement defaultElement KW_END declaration\n");
        };

caseElement : KW_CASE NUMCONST KW_COLON statement KW_SEMICOLON
    {
        fprintf(fout, "Rule 51 \t\t caseElement -> KW_CASE NUMCONST KW_COLON statement KW_SEMICOLON\n");
    };
    | caseElement KW_CASE NUMCONST KW_COLON statement KW_SEMICOLON
    {
        fprintf(fout, "Rule 52 \t\t caseElement -> KW_CASE NUMCONST KW_COLON statement KW_SEMICOLON\n");
    };

defaultElement : KW_DEFAULT KW_COLON statement KW_SEMICOLON {
               fprintf(fout, "Rule 53 \t\t defaultElement -> KW_DEFAULT KW_COLON statement KW_SEMICOLON\n");
        };|{
        fprintf(fout, "Rule 54 \t\t defaultElement -> empty\n");
        };
iterationStmt : KW_WHILE PAR_OP simpleExpression PAR_CL statement {
              fprintf(fout, "Rule 55 \t\t iterationStmt -> KW_WHILE PAR_OP simpleExpression PAR_CL statement\n");
        };
returnStmt : KW_RETURN KW_SEMICOLON {
           fprintf(fout, "Rule 56 \t\t returnStmt -> KW_RETURN KW_SEMICOLON\n");
        };|
        KW_RETURN expression KW_SEMICOLON {
        fprintf(fout, "Rule 57 \t\t returnStmt -> KW_RETURN expression KW_SEMICOLON\n");
        };
breakStmt : KW_BREAK KW_SEMICOLON {
          fprintf(fout, "Rule 58 \t\t breakStmt -> KW_BREAK KW_SEMICOLON\n");
        };
expression : mutable KW_EQUAL expression
    {
        fprintf(fout, "Rule 59 \t\t expression -> mutable KW_EQUAL expression\n");
    };
    | mutable KW_PLUS_EQUAL expression
    {
        fprintf(fout, "Rule 60 \t\t expression -> mutable KW_PLUS_EQUAL expression\n");
    };
    | mutable KW_MINUS_EQUAL expression
    {
        fprintf(fout, "Rule 61 \t\t expression -> mutable KW_MINUS_EQUAL expression\n");
    };
    | mutable KW_MULTIPLY_EQUAL expression
    {
        fprintf(fout, "Rule 62 \t\t expression -> mutable KW_MULTIPLY_EQUAL expression\n");
    };
    | mutable KW_DIVIDE_EQUAL expression
    {
        fprintf(fout, "Rule 63 \t\t expression -> mutable KW_DIVIDE_EQUAL expression\n");
    };
    | mutable KW_PLUS_PLUS
    {
        fprintf(fout, "Rule 64 \t\t expression -> mutable KW_PLUS_PLUS\n");
    };
    | mutable KW_MINUS_MINUS
    {
        fprintf(fout, "Rule 65 \t\t expression -> mutable KW_MINUS_MINUS\n");
    };
    | simpleExpression
    {
        fprintf(fout, "Rule 66 \t\t expression -> simpleExpression\n");
    };

simpleExpression : simpleExpression KW_COND_OR simpleExpression {
                 fprintf(fout, "Rule 67 \t\t simpleExpression -> simpleExpression KW_COND_OR simpleExpression\n");
        };|
        simpleExpression KW_COND_AND simpleExpression {
        fprintf(fout, "Rule 68 \t\t simpleExpression -> simpleExpression KW_COND_AND simpleExpression\n");
        };|
        simpleExpression KW_COND_OR KW_ELSE simpleExpression {
        fprintf(fout, "Rule 69 \t\t simpleExpression -> simpleExpression KW_COND_OR KW_ELSE simpleExpression\n");
        };|
        simpleExpression KW_COND_AND KW_COND_THEN simpleExpression{
        fprintf(fout, "Rule 70 \t\t simpleExpression -> simpleExpression KW_COND_AND KW_COND_THEN simpleExpression\n");
        };|
        KW_COND_NOT simpleExpression{
        fprintf(fout, "Rule 71 \t\t simpleExpression -> KW_COND_NOT simpleExpression\n");
        };|
        relExpression{
        fprintf(fout, "Rule 72 \t\t simpleExpression -> relExpression\n");
        };
relExpression : mathlogicExpression relop mathlogicExpression {
              fprintf(fout, "Rule 73 \t\t relExpression -> mathlogicExpression relop mathlogicExpression\n");
        };|
        mathlogicExpression {
        fprintf(fout, "Rule 74 \t\t relExpression -> mathlogicExpression\n");
        };
relop : KW_RELOP
    {
        fprintf(fout, "Rule 75-80 \t\t relop -> KW_RELOP\n");
    };

mathlogicExpression : mathlogicExpression KW_PLUS mathlogicExpression
    {
        fprintf(fout, "Rule 81 \t\t mathlogicExpression -> mathlogicExpression KW_PLUS mathlogicExpression\n");
        $$.place = new_temp($1.type);
        $$.type = $1.type;
        quadruple_push($1.place, $3.place, "+", $$.place);
    };
    | mathlogicExpression KW_MINUS mathlogicExpression
    {
        fprintf(fout, "Rule 82 \t\t mathlogicExpression -> mathlogicExpression KW_MINUS mathlogicExpression\n");
        $$.place = new_temp($1.type);
        $$.type = $1.type;
        quadruple_push($1.place, $3.place, "-", $$.place);
    };
    | mathlogicExpression KW_MULTIPLY mathlogicExpression
    {
        fprintf(fout, "Rule 83 \t\t mathlogicExpression -> mathlogicExpression KW_MULTIPLY mathlogicExpression\n");
        $$.place = new_temp($1.type);
        $$.type = $1.type;
        quadruple_push($1.place, $3.place, "*", $$.place);
    };
    | mathlogicExpression KW_DIVIDE mathlogicExpression
    {
        fprintf(fout, "Rule 84 \t\t mathlogicExpression -> mathlogicExpression KW_DIVIDE mathlogicExpression\n");
        $$.place = new_temp($1.type);
        $$.type = $1.type;
        quadruple_push($1.place, $3.place, "/", $$.place);
    };
    | mathlogicExpression KW_MODULU mathlogicExpression
    {
        fprintf(fout, "Rule 85 \t\t mathlogicExpression -> mathlogicExpression KW_MODULU mathlogicExpression\n");
        $$.place = new_temp($1.type);
        $$.type = $1.type;
        quadruple_push($1.place, $3.place, "%", $$.place);
    };
    | unaryExpression
    {
        fprintf(fout, "Rule 86 \t\t mathlogicExpression -> unaryExpression\n");
    };

unaryExpression : unaryop unaryExpression
    {
        fprintf(fout, "Rule 88 \t\t unaryExpression -> unaryop unaryExpression\n");
    };
    | factor
    {
        fprintf(fout, "Rule 89 \t\t unaryExpression -> factor\n");
    };

unaryop : KW_MINUS
    {
        fprintf(fout, "Rfule 90 \t\t unaryop -> KW_MINUS\n");
    };
    | KW_MULTIPLY
    {
        fprintf(fout, "Rule 91 \t\t unaryop -> KW_MULTIPLY\n");
    };
    | KW_QUESTION_MARK
    {
        fprintf(fout, "Rule 92 \t\t unaryop -> KW_QUESTION_MARK\n");
    };

factor : immutable
    {
        fprintf(fout, "Rule 93 \t\t factor -> immutable\n");
    };
    | mutable
    {
        fprintf(fout, "Rule 94 \t\t factor -> mutable\n");
    };

mutable : ID
    {
        fprintf(fout, "Rule 95 \t\t mutable -> ID\n");
    };
    | mutable BR_OP expression BR_CL
    {
        fprintf(fout, "Rule 96 \t\t mutable -> mutable BR_OP expression BR_CL\n");
    };
    | mutable PUNC_DOT ID
    {
        fprintf(fout, "Rule 97 \t\t mutable -> mutable PUNC_DOT ID\n");
    };

immutable : PAR_OP expression PAR_CL
    {
        fprintf(fout, "Rule 98 \t\t immutable -> PAR_OP expression PAR_CL\n");
    };
    | call
    {
        fprintf(fout, "Rule 99 \t\t immutable -> call\n");
    };
    | constant
    {
        fprintf(fout, "Rule 100 \t\t immutable -> constant\n");
    };

call : ID PAR_OP args PAR_CL
    {
        fprintf(fout, "Rule 101 \t\t call -> ID PAR_OP args PAR_CL\n");
    };

args : argList
    {
        fprintf(fout, "Rule 102 \t\t args -> argList\n");
    };
    |
    {
        fprintf(fout, "Rule 103 \t\t args -> empty\n");
    };

argList : argList PUNC_COMMA expression
    {
        fprintf(fout, "Rule 104 \t\t argList -> argList PUNC_COMMA expression\n");
    };
    | expression
    {
        fprintf(fout, "Rule 105 \t\t argList -> expression\n");
    };

constant : NUMCONST
    {
        fprintf(fout, "Rule 106 \t\t constant -> NUMCONST\n");
        $$.place = new_temp($1.type);
        $$.type = $1.type;
        $$.next_list = $1.next_list;
        quadruple_push($1.place, " ", ":=", $$.place);
    };
    | REAL
    {
        fprintf(fout, "Rule 107 \t\t constant -> REAL\n");
    };
    | CHARCONST
    {
        fprintf(fout, "Rule 108 \t\t constant -> CHARCONST\n");
    };
    | BOOLCONST
    {
        fprintf(fout, "Rule 109 \t\t constant -> BOOLCONST\n");
    };

%%
int main() {

    yyin = fopen("input.txt", "r");
    fout = fopen("output.txt", "w");
    fprintf(fout, "\n \t \t \t PARSER \n");
    fprintf(fout, "Rule No. --> Rule Description \n");
    if (fout == NULL) {
        printf("Error opening file!\n");
    } else if (!yyin) {
        printf("Error opening file!\n");
    } else
        yyparse();

    return 0;
}

void yyerror(const char *s) {
    fprintf(fout, "**Error: Line %d near token '%s' --> Message: %s **\n",
        yylineno, yytext, s);
    printf("**Error: Line %d near token '%s' --> Message: %s **\n", yylineno,
        yytext, s);
}
