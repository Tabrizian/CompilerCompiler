%option noyywrap

%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include "parser.tab.h"

int counter = 0;
char symbol_table[100][50];

int install_id(char *next) {
    int i = 0;

    for (i = 0; i < counter; i++) {
        if(strcmp(next, symbol_table[i]) == 0) {
            return i;
        }
    }

    strcpy(symbol_table[counter], next);
    counter++;

    return counter - 1;
}
%}

digit [0-9]
non_zero_digit [1-9]
letter [a-zA-Z]
letdig ({digit}|{letter})

PUNC_DOT "."
PUNC_COMMA ","

ID #{letter}{letter}{digit}{digit}
FAKE_ID ("#"{letdig}*)|({letter}{letdig}*)
REAL (("0")|({non_zero_digit}{digit}*))"."(({digit}*{non_zero_digit})|"0")

NUMCONST ("0")|({non_zero_digit}{digit}*)
FAKE_NUMCONST ("0")|({digit}*)
FAKE_REAL (("0")|(({digit}*))"."({digit}+)|((({digit}+))"."({digit}*)))
CHARCONST_SINGLEQOUTE ("'"{letdig}"'")
CHARCONST_SINGLEBACKSLASH ("\\"{letdig})
CHARCONST ({CHARCONST_SINGLEQOUTE}|{CHARCONST_SINGLEBACKSLASH})
BOOLCONST ("true"|"false")

WHITESPACE [ \t]+

COMMENT "//"(.)*

KW_RECORD "record"
KW_STATIC "static"
KW_INT "int"
KW_REAL "real"
KW_BOOL "bool"
KW_CHAR "char"
KW_IF "if"
KW_ELSE "else"
KW_SWITCH "switch"
KW_END "end"
KW_CASE "case"
KW_DEFAULT "default"
KW_WHILE "while"
KW_RETURN "return"
KW_SEMICOLON ";"
KW_BREAK "break"
KW_PLUS "+"
KW_MINUS "-"
KW_EQUAL "="
KW_DIVIDE "/"
KW_MULTIPLY "*"
KW_MODULU "%"
KW_COND_OR "or"
KW_COND_AND "and"
KW_COND_THEN "then"
KW_COND_NOT "not"
KW_RELOP (".le"|".lt"|".gt"|".ge"|".eq"|".ne")
KW_COLON ":"
KW_QUESTION_MARK "?"
KW_PLUS_PLUS "++"
KW_MINUS_MINUS "--"
KW_PLUS_EQUAL "+="
KW_MINUS_EQUAL "-="
KW_DIVIDE_EQUAL "/="
KW_MULTIPLY_EQUAL "*="

PAR_OP "("
PAR_CL ")"
BR_OP "["
BR_CL "]"
CR_OP [{]
CR_CL [}]

%%

{ID} {
    install_id(yytext);
    yylval.eval.place = new char[strlen(yytext)];
    yylval.eval.true_list = NULL;
    yylval.eval.false_list = NULL;
    yylval.eval.next_list = NULL;
    strcpy(yylval.eval.place, yytext);
    yylval.eval.code = "";
    return ID;
}

{NUMCONST} {
    yylval.eval.place = new char[strlen(yytext)];
    yylval.eval.true_list = NULL;
    yylval.eval.false_list = NULL;
    yylval.eval.next_list = NULL;
    strcpy(yylval.eval.place, yytext);
    yylval.eval.code = "";
    yylval.eval.type = "integer";
    return NUMCONST;
}

{CHARCONST} {
    yylval.eval.place = new char[strlen(yytext)];
    yylval.eval.true_list = NULL;
    yylval.eval.false_list = NULL;
    yylval.eval.next_list = NULL;
    strcpy(yylval.eval.place, yytext);
    yylval.eval.code = "";
    yylval.eval.type = "char";
    return CHARCONST;
}

{BOOLCONST} {
    yylval.eval.place = new char[1];
    yylval.eval.true_list = NULL;
    yylval.eval.false_list = NULL;
    yylval.eval.next_list = NULL;

    if(strcmp(yytext, "false") == 0) {
        yylval.eval.place[0] = '0';
    } else if(strcmp(yytext, "true") == 0) {
        yylval.eval.place[0] = '1';
    }

    yylval.eval.code = "";
    yylval.eval.type = "integer";
    return BOOLCONST;
}

{COMMENT} {
	//nothing
}

{KW_RECORD} {
    return KW_RECORD;
}

{KW_STATIC} {
    return KW_STATIC;
}
{KW_INT} {
    return KW_INT;
}

{KW_REAL} {
    return KW_REAL;
}

{KW_BOOL} {
    return KW_BOOL;
 }

{KW_CHAR} {
    return KW_CHAR;
}

{KW_IF} {
    return KW_IF;
}

{KW_ELSE} {
    return KW_ELSE;
}

{KW_SWITCH} {
    return KW_SWITCH;
}

{KW_END} {
    return KW_END;
}

{KW_CASE} {
    return KW_CASE;
}

{KW_DEFAULT} {
    return KW_DEFAULT;
}

{KW_WHILE} {
    return KW_WHILE;
}

{KW_RETURN} {
    return KW_RETURN;
}

{KW_SEMICOLON} {
    return KW_SEMICOLON;
}

{KW_BREAK} {
    return KW_BREAK;
}

{KW_PLUS} {
    return KW_PLUS;
}

{KW_MINUS} {
    return KW_MINUS;
}

{KW_EQUAL} {
    return KW_EQUAL;
}

{KW_DIVIDE} {
    return KW_DIVIDE;
}

{KW_MULTIPLY} {
    return KW_MULTIPLY;
}

{KW_MODULU} {
    return KW_MODULU;
}

{KW_COND_NOT} {
    return KW_COND_NOT;
}

{KW_COND_OR} {
    return KW_COND_OR;
}

{KW_COND_AND} {
    return KW_COND_AND;
}

{KW_COND_THEN} {
    return KW_COND_THEN;
}

{KW_RELOP} {
    yylval.eval.place = new char[strlen(yytext)];
    yylval.eval.true_list = NULL;
    yylval.eval.false_list = NULL;
    yylval.eval.next_list = NULL;
    strcpy(yylval.eval.place, yytext);
    yylval.eval.code = "";
    yylval.eval.type = "relop";
    return KW_RELOP;
}

{KW_COLON} {
    return KW_COLON;
}

{KW_QUESTION_MARK} {
    return KW_QUESTION_MARK;
}

{PAR_OP} {
    return PAR_OP;
}
{PAR_CL} {
    return PAR_CL;
}

{BR_OP} {
    return BR_OP;
}
{BR_CL} {
    return BR_CL;
}

{CR_OP} {
    return CR_OP;
}
{CR_CL} {
    return CR_CL;
}

{REAL} {
    yylval.eval.place = new char[strlen(yytext)];
    yylval.eval.true_list = NULL;
    yylval.eval.false_list = NULL;
    yylval.eval.next_list = NULL;
    strcpy(yylval.eval.place, yytext);
    yylval.eval.code = "";
    yylval.eval.type = "real";
    return REAL;
}

{FAKE_REAL} {
    //nothing
}
{FAKE_NUMCONST} {
    //nothing
}
{FAKE_ID} {
    //nothing
}

{PUNC_DOT} {
    return PUNC_DOT;
}

{PUNC_COMMA} {
    return PUNC_COMMA;
}

{KW_PLUS_PLUS} {
    return KW_PLUS_PLUS;
}

{KW_MINUS_MINUS} {
    return KW_MINUS_MINUS;
}

{KW_MINUS_EQUAL} {
    return KW_MINUS_EQUAL;
}

{KW_PLUS_EQUAL} {
    return KW_PLUS_EQUAL;
}

{KW_MULTIPLY_EQUAL} {
    return KW_MULTIPLY_EQUAL;
}

{KW_DIVIDE_EQUAL} {
    return KW_DIVIDE_EQUAL;
}

[\n] {++yylineno;}
. {}
