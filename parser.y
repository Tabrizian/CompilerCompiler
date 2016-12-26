%{
#include <cstdio>
#include <cstdlib>
#include <vector>
#include <fstream>
#include <iostream>
#include <string>
#include <cstring>
#include <sstream>

#include "list.h"

using namespace std;

extern FILE *yyin;
extern int yylineno;
extern char* yytext;
void yyerror(const char *s);
extern int yylex(void);
FILE *fout;
bool direction = true;

struct symbol_table_entry {
    string id;
    string type;
    vector <symbol_table_entry> *forward = NULL;
    vector <symbol_table_entry> *backward = NULL;
};

int i = 0;
vector <symbol_table_entry> *start_symbol_table = new vector<symbol_table_entry>;
vector <symbol_table_entry> *current_symbol_table = start_symbol_table;
vector <string> quadruple[4];
vector <string> registers;
ofstream myfile;

int indent = 0;
void print_symbol_table(vector<symbol_table_entry> *start_symbol_table) {
    for(int i = 0; i < indent; i++, cout << "\t");
    cout << "========" << endl;
    for(int i = 0; i < start_symbol_table->size(); i++) {
        for(int i = 0; i < indent; i++, cout << "\t");
        cout << start_symbol_table->at(i).id << endl;
        for(int i = 0; i < indent; i++, cout << "\t");
        cout << start_symbol_table->at(i).type << endl;
        if(start_symbol_table->at(i).forward) {
            indent++;
            print_symbol_table(start_symbol_table->at(i).forward);
        }
    }
    for(int i = 0; i < indent; i++, cout << "\t");
    cout << "========" << endl;
    indent--;
}

void split(const string &s, char delim, vector<string> &elems) {
    stringstream ss;
    ss.str(s);
    string item;
    while (getline(ss, item, delim)) {
        elems.push_back(item);
    }
}


vector<string> split(const string &s, char delim) {
    vector<string> elems;
    split(s, delim, elems);
    return elems;
}

int num = 0;

int symbol_table_lookup(string token) {
}

vector<symbol_table_entry>* create_symbol_table() {
    vector<symbol_table_entry>* symbol_table = new vector<symbol_table_entry>();
    return symbol_table;
}

void symbol_table_insert(string token, char *type) {
    struct symbol_table_entry entry;
    if(token[0] == '#') {
        token = token.substr(1);
    }
    entry.id = token;
    entry.type = type;
    current_symbol_table->push_back(entry);
}

void symbol_table_insert(vector<string> tokens, char *type) {
    for(int i = 0; i < tokens.size(); i++) {
        symbol_table_insert(tokens[i], type);
    }
}

char* new_temp(char *c) {
    string name("t");
    name += to_string(num);
    num++;
    char *what = (char *) malloc(sizeof(char) * 100);
    strcpy(what, name.c_str());
    symbol_table_insert(what, c);
    return what;
}

void quadruple_print() {

    myfile.open("intermediatecode.c");
    myfile << "#include <stdio.h>\n\n";
    myfile << endl<<"int main(){\n\n";

    /* for print declaration of  variables*/
    for(int i = 0 ;i < current_symbol_table->size(); i++) {
        if(current_symbol_table->at(i).type == "integer")
            myfile << "int " << current_symbol_table->at(i).id << ";" << endl;
        else if(current_symbol_table->at(i).type == "real")
            myfile << "double " << current_symbol_table->at(i).id  << ";" << endl;
        else if(current_symbol_table->at(i).type == "char")
            myfile << "char " << current_symbol_table->at(i).id << ";" << endl;
    }

    for(int i = 0; i < quadruple[0].size(); i++) {
        myfile << "L" << i << " : ";
        if(quadruple[2][i] == ":=")
                myfile << quadruple[3][i] << " = " << quadruple[0][i] << ";"
                    << endl;
        else if(quadruple[2][i] == "+")
                myfile << quadruple[3][i] << " = " << quadruple[0][i] << " + "
                    << quadruple[1][i] << ";" << endl;
        else if(quadruple[2][i] == "-")
                myfile << quadruple[3][i] << " = " << quadruple[0][i] << " - "
                    << quadruple[1][i] << ";" << endl;
        else if(quadruple[2][i] == "*")
                myfile << quadruple[3][i] << " = " << quadruple[0][i] << " * "
                    << quadruple[1][i] << ";" << endl;
        else if(quadruple[2][i] == "/")
                myfile << quadruple[3][i] << " = " <<quadruple[0][i] << " / "
                    <<  quadruple[1][i] << ";" << endl;
        else if(quadruple[2][i] == "%")
                myfile << quadruple[3][i] << " = " <<quadruple[0][i] << " % "
                    <<  quadruple[1][i] << ";" << endl;
        else if(quadruple[2][i] == ".le")
                myfile << quadruple[3][i] << " = " <<quadruple[0][i] << " < "
                    <<  quadruple[1][i] << ";" << endl;
        else if(quadruple[2][i] == ".lt")
                myfile << quadruple[3][i] << " = " <<quadruple[0][i] << " <= "
                    <<  quadruple[1][i] << ";" << endl;
        else if(quadruple[2][i] == ".gt")
                myfile << quadruple[3][i] << " = " <<quadruple[0][i] << " > "
                    <<  quadruple[1][i] << ";" << endl;
         else if(quadruple[2][i] == ".ge")
                myfile << quadruple[3][i] << " = " <<quadruple[0][i] << " >= "
                    <<  quadruple[1][i] << ";" << endl;
         else if(quadruple[2][i] == ".eq")
                myfile << quadruple[3][i] << " = " <<quadruple[0][i] << " == "
                    <<  quadruple[1][i] << ";" << endl;
         else if(quadruple[2][i] == ".ne")
                myfile << quadruple[3][i] << " = " <<quadruple[0][i] << " != "
                    <<  quadruple[1][i] << ";" << endl;
         else if(quadruple[2][i] == "if")
                myfile << "if" << " ( " <<quadruple[0][i] << " ) "
                    <<  quadruple[1][i]  << endl;
         else if(quadruple[2][i] == "goto")
                myfile << "goto L" << quadruple[0][i] << ";"<<endl;
    }

    myfile << "L" << quadruple[0].size() << ":" << " return 0;" << endl;
    myfile << endl << "}" << endl;
}

void quadruple_push(string arg1, string arg2, string op, string result) {

    if(arg1[0] == '#') {
        arg1 = arg1.substr(1);
    }

    if(arg2[0] == '#') {
        arg2 = arg2.substr(1);
    }

    if(result[0] == '#') {
        result = result.substr(1);
    }

    quadruple[0].push_back(arg1);
    quadruple[1].push_back(arg2);
    quadruple[2].push_back(op);
    quadruple[3].push_back(result);
}

void quadruple_push(int row, string data) {
    quadruple[0][row] = data;
}

void backpatch(struct node *first, int data) {
    struct node *current;
    for(current = first; current != NULL; current = current->link) {
        quadruple_push(first->data, to_string(data));
    }
}

%}

%union {
    struct {
        struct node *true_list;
        struct node *false_list;
        struct node *next_list;
        int quad;
        int is_boolean;
        char *place;
        char *code;
        char *type;
    } eval;
}

%token THEN PUNC_COMMA PUNC_DOT FAKE_ID  FAKE_NUMCONST FAKE_REAL
CHARCONST_SINGLEQOUTE COMMENT KW_RECORD KW_STATIC KW_INT
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
%token <eval> CHARCONST
%token IF_WITHOUT_ELSE
%type <eval> program declarationList declaration recDeclaration varDeclaration
scopedVarDeclaration varDecList varDeclInitialize varDeclId scopedTypeSpecifier
typeSpecifier returnTypeSpecifier funDeclaration params paramList paramTypeList
paramIdList paramId statement compoundStmt localDeclarations statementList
expressionStmt selectionStmt caseElement defaultElement iterationStmt
returnStmt breakStmt expression simpleExpression relExpression relop
mathlogicExpression unaryExpression unaryop factor mutable immutable call
par_cl_var null_before_simple_expr
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
        if(i != 0) {
            current_symbol_table->back().forward = NULL;
        }
        print_symbol_table(start_symbol_table);

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
        $$.type = $1.type;
        string declaration_list($2.code);

        vector<string> tokens = split(declaration_list, ',');
        symbol_table_insert(tokens, $1.type);
    };
    | ID varDecList KW_SEMICOLON
    {
        fprintf(fout, "Rule 8.1 \t\t varDeclaration -> ID varDecList KW_SEMICOLON\n");
    };

scopedVarDeclaration : scopedTypeSpecifier varDecList KW_SEMICOLON
    {
        fprintf(fout, "Rule 9 \t\t scopedVarDeclaration -> scopedTypeSpecifier varDecList KW_SEMICOLON\n");
        $$.type = $1.type;
        string declaration_list($2.code);

        vector<string> tokens = split(declaration_list, ',');
        for(int i = 0; i < tokens.size(); i++) {
            vector<string> inits = split(tokens[i], ' ');
            if(inits.size() == 1) {
                symbol_table_insert(tokens[i], $1.type);
            } else if(inits.size() == 2) {
                symbol_table_insert(inits[0], $1.type);
                quadruple_push(inits[1], "", ":=", inits[0]);
            }
        }
    };

varDecList : varDecList  PUNC_COMMA varDeclInitialize
    {
        fprintf(fout, "Rule 10 \t\t varDecList -> varDecList  PUNC_COMMA varDeclInitialize\n");
        char *temp = new char[100];
        strcpy(temp, $1.code);
        $$.code = strcat(strcat(temp, ","), $3.code);

    };
    | varDeclInitialize
    {
        fprintf(fout, "Rule 11 \t\t varDecList -> varDeclInitialize\n");
        $$.code = $1.code;
    };

varDeclInitialize : varDeclId
    {
        fprintf(fout, "Rule 12 \t\t varDeclInitialize -> varDeclId\n");
        $$.code = $1.code;
        $$.type = "unknown";
    };
    | varDeclId KW_COLON simpleExpression
    {
        fprintf(fout, "Rule 13 \t\t varDeclInitialize -> varDeclId KW_COLON simpleExpression\n");
        char *temp = new char[100];
        strcpy(temp, $1.code);
        $$.code = strcat(strcat(temp, " "), $3.place);
        $$.type = $3.type;
    };

varDeclId : ID
    {
        fprintf(fout, "Rule 14 \t\t varDeclId -> ID\n");
        $$.code = $1.place;
    };
    | ID BR_OP NUMCONST BR_CL
    {
        fprintf(fout, "Rule 15 \t\t varDeclId -> ID BR_OP NUMCONST BR_CL\n");
    };

scopedTypeSpecifier : KW_STATIC typeSpecifier
    {
        fprintf(fout, "Rule 16 \t\t scopedTypeSpecifier -> KW_STATIC typeSpecifier\n");
        $$.type = $2.type;
    };
    | typeSpecifier
    {
        fprintf(fout, "Rule 17 \t\t scopedTypeSpecifier -> typeSpecifier\n");
        $$.type = $1.type;
    };
    | KW_STATIC ID
    {
        fprintf(fout, "Rule 17.1 \t\t scopedTypeSpecifier -> KW_STATIC ID\n");
    };

typeSpecifier : returnTypeSpecifier
    {
        fprintf(fout, "Rule 18 \t\t typeSpecifier -> returnTypeSpecifier\n");
        $$.type = $1.type;
    };

returnTypeSpecifier : KW_INT
    {
        fprintf(fout, "Rule 20 \t\t returnTypeSpecifier -> KW_INT\n");
        $$.type = "integer";
    };
    | KW_REAL
    {
        fprintf(fout, "Rule 21 \t\t returnTypeSpecifier -> KW_REAL\n");
        $$.type = "real";
    };
    | KW_BOOL
    {
        fprintf(fout, "Rule 22 \t\t returnTypeSpecifier -> KW_BOOL\n");
        $$.type = "integer";
    };
    | KW_CHAR
    {
        fprintf(fout, "Rule 23 \t\t returnTypeSpecifier -> KW_CHAR\n");
        $$.type = "char";
    };

funDeclaration : typeSpecifier ID PAR_OP params par_cl_var statement
    {
        fprintf(fout, "Rule 24 \t\t funDeclaration -> typeSpecifier ID PAR_OP params par_cl_var statement\n");
    };
    | ID PAR_OP params par_cl_var statement
    {
        fprintf(fout, "Rule 25 \t\t funDeclaration -> ID PAR_OP params par_cl_var statement\n");
    };
    | ID ID PAR_OP params par_cl_var statement
    {
        fprintf(fout, "Rule 25.1 \t\t funDeclaration -> ID PAR_OP params par_cl_var statement\n");
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

paramId : ID
    {
        fprintf(fout, "Rule 33 \t\t paramId -> ID\n");
    };
    | ID BR_OP BR_CL
    {
        fprintf(fout, "Rule 34 \t\t paramId -> ID BR_OP BR_CL\n");
    };

statement : expressionStmt
    {
          fprintf(fout, "Rule 35 \t\t statement -> expressionStmt\n");
    };
    | compoundStmt
    {
        fprintf(fout, "Rule 36 \t\t statement -> compoundStmt\n");
    };
    | selectionStmt
    {
        fprintf(fout, "Rule 37 \t\t statement -> selectionStmt\n");
    };
    | iterationStmt
    {
        fprintf(fout, "Rule 38 \t\t statement -> iterationStmt\n");
    };
    | returnStmt
    {
        fprintf(fout, "Rule 39 \t\t statement -> returnStmt\n");
    };
    | breakStmt
    {
        fprintf(fout, "Rule 40 \t\t statement -> breakStmt\n");
    };

compoundStmt :	CR_OP localDeclarations statementList CR_CL
    {
        fprintf(fout, "Rule 41 \t\t compoundStmt -> CR_OP localDeclarations statementList CR_CL\n");
        i--;
        direction = false;
    };

localDeclarations :	localDeclarations scopedVarDeclaration
    {
        fprintf(fout, "Rule 42 \t\t localDeclarations -> localDeclarations scopedVarDeclaration\n");
    };
    |
    {
        fprintf(fout, "Rule 43 \t\t localDeclarations -> empty\n");
            if(direction) {
                struct symbol_table_entry entry;
                entry.id = "new_scope!!!";
                entry.type = "link";
                entry.forward = create_symbol_table();
                current_symbol_table->push_back(entry);

                entry.forward = NULL;
                entry.id = "link";
                entry.type = "link";
                entry.backward = current_symbol_table;
                current_symbol_table = current_symbol_table->back().forward;
                current_symbol_table->push_back(entry);
            } else {
                current_symbol_table = current_symbol_table->at(0).backward;
            }
        direction = true;
    };

statementList :	statementList statement
    {
        fprintf(fout, "Rule 44 \t\t statementList -> statementList statement\n");
    };
    |
    {
        fprintf(fout, "Rule 45 \t\t statementList -> empty\n");
    };

expressionStmt : expression KW_SEMICOLON
    {
        fprintf(fout, "Rule 46 \t\t expressionStmt -> expression KW_SEMICOLON\n");
    };
    | KW_SEMICOLON
    {
        fprintf(fout, "Rule 47 \t\t expressionStmt -> empty\n");
    };

selectionStmt : KW_IF PAR_OP simpleExpression par_cl_var statement  %prec IF_WITHOUT_ELSE
    {
        fprintf(fout, "Rule 48 \t\t selectionStmt -> KW_IF PAR_OP simpleExpression par_cl_var statement\n");
        backpatch($3.false_list,quadruple[0].size());
        backpatch($3.true_list,$4.quad);
    };
    | KW_IF PAR_OP simpleExpression par_cl_var statement KW_ELSE statement
    {
        fprintf(fout, "Rule 49 \t\t selectionStmt -> KW_IF PAR_OP simpleExpression par_cl_var statement KW_ELSE statement\n");
    };
    | KW_SWITCH PAR_OP simpleExpression par_cl_var caseElement defaultElement KW_END
    {
        fprintf(fout, "Rule 50 \t\t selectionStmt -> KW_SWITCH PAR_OP simpleExpression par_cl_var caseElement defaultElement KW_END declaration\n");
    };


caseElement : KW_CASE NUMCONST KW_COLON statement KW_SEMICOLON
    {
        fprintf(fout, "Rule 51 \t\t caseElement -> KW_CASE NUMCONST KW_COLON statement KW_SEMICOLON\n");
    };
    | caseElement KW_CASE NUMCONST KW_COLON statement KW_SEMICOLON
    {
        fprintf(fout, "Rule 52 \t\t caseElement -> KW_CASE NUMCONST KW_COLON statement KW_SEMICOLON\n");
    };

defaultElement : KW_DEFAULT KW_COLON statement KW_SEMICOLON
    {
        fprintf(fout, "Rule 53 \t\t defaultElement -> KW_DEFAULT KW_COLON statement KW_SEMICOLON\n");
    };
    |
    {
        fprintf(fout, "Rule 54 \t\t defaultElement -> empty\n");
    };

iterationStmt : KW_WHILE PAR_OP simpleExpression par_cl_var statement
    {
        fprintf(fout, "Rule 55 \t\t iterationStmt -> KW_WHILE PAR_OP simpleExpression par_cl_var statement\n");
    };

returnStmt : KW_RETURN KW_SEMICOLON
    {
        fprintf(fout, "Rule 56 \t\t returnStmt -> KW_RETURN KW_SEMICOLON\n");
    };
    | KW_RETURN expression KW_SEMICOLON
    {
        fprintf(fout, "Rule 57 \t\t returnStmt -> KW_RETURN expression KW_SEMICOLON\n");
    };

breakStmt : KW_BREAK KW_SEMICOLON
    {
          fprintf(fout, "Rule 58 \t\t breakStmt -> KW_BREAK KW_SEMICOLON\n");
    };

expression : mutable KW_EQUAL expression
    {
        fprintf(fout, "Rule 59 \t\t expression -> mutable KW_EQUAL expression\n");
        $$.type = $1.type;
        quadruple_push($3.place, "", ":=", $1.place);
    };
    | mutable KW_PLUS_EQUAL expression
    {
        fprintf(fout, "Rule 60 \t\t expression -> mutable KW_PLUS_EQUAL expression\n");
        $$.type = $1.type;
        $$.place = new_temp($1.type);
        quadruple_push($1.place, $3.place, "+", $1.place);
        quadruple_push($1.place, "", ":=", $$.place);
    };
    | mutable KW_MINUS_EQUAL expression
    {
        fprintf(fout, "Rule 61 \t\t expression -> mutable KW_MINUS_EQUAL expression\n");
        $$.type = $1.type;
        $$.place = new_temp($1.type);
        quadruple_push($1.place, $3.place, "-", $1.place);
        quadruple_push($1.place, "", ":=", $$.place);
    };
    | mutable KW_MULTIPLY_EQUAL expression
    {
        fprintf(fout, "Rule 62 \t\t expression -> mutable KW_MULTIPLY_EQUAL expression\n");
        $$.type = $1.type;
        $$.place = new_temp($1.type);
        quadruple_push($1.place, $3.place, "*", $1.place);
        quadruple_push($1.place, "", ":=", $$.place);
    };
    | mutable KW_DIVIDE_EQUAL expression
    {
        fprintf(fout, "Rule 63 \t\t expression -> mutable KW_DIVIDE_EQUAL expression\n");
        $$.type = $1.type;
        $$.place = new_temp($1.type);
        quadruple_push($1.place, $3.place, "/", $1.place);
        quadruple_push($1.place, "", ":=", $$.place);
    };
    | mutable KW_PLUS_PLUS
    {
        fprintf(fout, "Rule 64 \t\t expression -> mutable KW_PLUS_PLUS\n");
        $$.place = new_temp($1.type);
        $$.type = $1.type;
        quadruple_push($1.place, "1", "+", $1.place);
        quadruple_push($1.place, "", ":=", $$.place);
    };
    | mutable KW_MINUS_MINUS
    {
        fprintf(fout, "Rule 65 \t\t expression -> mutable KW_MINUS_MINUS\n");
        $$.place = new_temp($1.type);
        $$.type = $1.type;
        quadruple_push($1.place, "1", "-", $1.place);
        quadruple_push($1.place, "", ":=", $$.place);

    };
    | simpleExpression
    {
        fprintf(fout, "Rule 66 \t\t expression -> simpleExpression\n");
    };

simpleExpression : simpleExpression KW_COND_OR null_before_simple_expr simpleExpression
    {
        fprintf(fout, "Rule 67 \t\t simpleExpression -> simpleExpression KW_COND_OR simpleExpression\n");
        backpatch($1.false_list,$3.quad);
        $$.true_list = merge_lists($1.true_list,$4.true_list);
        $$.false_list = $4.false_list;
    };
    | simpleExpression KW_COND_AND simpleExpression
    {
        fprintf(fout, "Rule 68 \t\t simpleExpression -> simpleExpression KW_COND_AND simpleExpression\n");
    };
    | simpleExpression KW_COND_OR KW_ELSE simpleExpression
    {
        fprintf(fout, "Rule 69 \t\t simpleExpression -> simpleExpression KW_COND_OR KW_ELSE simpleExpression\n");
    };
    | simpleExpression KW_COND_AND KW_COND_THEN simpleExpression
    {
        fprintf(fout, "Rule 70 \t\t simpleExpression -> simpleExpression KW_COND_AND KW_COND_THEN simpleExpression\n");
    };
    | KW_COND_NOT simpleExpression
    {
        fprintf(fout, "Rule 71 \t\t simpleExpression -> KW_COND_NOT simpleExpression\n");
    };
    | relExpression
    {
        fprintf(fout, "Rule 72 \t\t simpleExpression -> relExpression\n");
    };

null_before_simple_expr : {
        fprintf(fout, "Rule 67.1 \t\t simpleExpression -> empty\n");
        $$.quad = quadruple[0].size();
    }

relExpression : mathlogicExpression relop mathlogicExpression
    {
        fprintf(fout, "Rule 73 \t\t relExpression -> mathlogicExpression relop mathlogicExpression\n");
        //$$.place = $1.place;
        $$.place = new_temp("integer");
        quadruple_push($1.place, $3.place, $2.place, $$.place);
        $$.true_list = create_node(quadruple[0].size() + 1);
        $$.false_list = create_node(quadruple[0].size() + 2);
        $$.type = "integer";
        quadruple_push($$.place, "", "if", "");
        quadruple_push("", "", "goto", "");
        quadruple_push("", "", "goto", "");
    };
    | mathlogicExpression
    {
        fprintf(fout, "Rule 74 \t\t relExpression -> mathlogicExpression\n");

        $$.place = new_temp("integer");
        $$.place = $1.place;
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
        fprintf(fout, "Rule 90 \t\t unaryop -> KW_MINUS\n");
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

immutable : PAR_OP expression par_cl_var
    {
        fprintf(fout, "Rule 98 \t\t immutable -> PAR_OP expression par_cl_var\n");
    };
    | call
    {
        fprintf(fout, "Rule 99 \t\t immutable -> call\n");
    };
    | constant
    {
        fprintf(fout, "Rule 100 \t\t immutable -> constant\n");
    };

call : ID PAR_OP args par_cl_var
    {
        fprintf(fout, "Rule 101 \t\t call -> ID PAR_OP args par_cl_var\n");
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
        $$.place = new_temp($1.type);
        $$.type = $1.type;
        $$.next_list = $1.next_list;
        quadruple_push($1.place, " ", ":=", $$.place);

    };
    | CHARCONST
    {
        fprintf(fout, "Rule 108 \t\t constant -> CHARCONST\n");
        $$.place = new_temp($1.type);
        $$.type = $1.type;
        $$.next_list = $1.next_list;
        quadruple_push($1.place, " ", ":=",$$.place);
    };
    | BOOLCONST
    {
        fprintf(fout, "Rule 109 \t\t constant -> BOOLCONST\n");
        $$.place = new_temp($1.type);
        $$.type = $1.type;
        $$.true_list = create_node(quadruple[0].size() + 1);
        $$.false_list = create_node(quadruple[0].size() + 2);
        $$.next_list = $1.next_list;
        quadruple_push($1.place, " ", ":=", $$.place);
    };

par_cl_var : PAR_CL
    {
        fprintf(fout, "110 \t\t par_cl_var_VAR -> par_cl_var \n");
        $$.quad = quadruple[0].size();
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
