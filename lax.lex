%option noyywrap
%{
    #include <stdio.h>
    #include <stdlib.h>

    #include "parser.tab.h"

    int counter = 0;
    int no_of_id = 0;
    struct record {
        int id;
        char *token;
        char *value;
    };

    struct record symbol_table[100];
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
KW_COND_ELSE "else"
KW_COND_THEN "then"
KW_COND_NOT "not"
KW_RELOP (".le"|".lt"|".gt"|".ge"|".eq"|".ne")
KW_COLON ":"
KW_QUESTION_MARK "?"

PAR_OP "("
PAR_CL ")"
BR_OP "["
BR_CL "]"
CR_OP [{]
CR_CL [}]

%%
{ID} {
    struct record new_record;
    new_record.token = "ID";
    new_record.id = no_of_id;
    new_record.value = yytext;
    symbol_table[no_of_id].id = new_record.id;
    no_of_id++;
    return ID;
}
{NUMCONST} {
    return NUMCONST;
}
{CHARCONST} {
    return CHARCONST;
}
{BOOLCONST} {
    return BOOLCONST;
}
{WHITESPACE} {
    return WHITESPACE;
}
{COMMENT} {
    return COMMENT;
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
    return REAL;
}

{FAKE_REAL} {
    return FAKE_REAL;
}
{FAKE_NUMCONST} {
    return FAKE_NUMCONST;
}
{FAKE_ID} {
    return FAKE_ID;
}

{PUNC_DOT} {
    return PUNC_DOT;
}

{PUNC_COMMA} {
    return PUNC_COMMA;
}

. {
    return Unknown;
}

%%
