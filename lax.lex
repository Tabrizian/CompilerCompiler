%option noyywrap
%{
    int counter = 0;
%}

digit [0-9]
non_zero_digit [1-9]
letter [a-zA-Z]
letdig ({digit}|{letter})

ID #{letter}{letter}{digit}{digit}
FAKE_ID ("#"{letdig}*)|({letter}{letdig}*)
REAL (("0")|({non_zero_digit}{digit}*))"."(({digit}*{non_zero_digit})|"0")

NUMCONST ("0")|({non_zero_digit}{digit}*)
FAKE_NUMCONST ("0")|({digit}*)
FAKE_REAL (("0")|({digit}*))"."({digit}*)
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

PAR_OP "("
PAR_CL ")"
BR_OP "["
BR_CL "]"
CR_OP [{]
CR_CL [}]
PUNC_KW "[,]"

%%
{ID} {
    printf("%s\tID\n", yytext);
}
{NUMCONST} {
    printf("%s\tNUMCONST\n", yytext);
}
{CHARCONST} {
    printf("%s\tCHARCONST\n", yytext);
}
{BOOLCONST} {
    printf("%s\tBOOLCONST\n", yytext);
}
{WHITESPACE} {
    printf("%s\tWHITESPACE\n", yytext);
}
{COMMENT} {
    printf("%s\tCOMMENT\n", yytext);
}



{KW_RECORD} {
    printf("%s\tKW_RECORD\n", yytext);
}
{KW_STATIC} {
    printf("%s\tKW_STATIC\n", yytext);
}
{KW_INT} {
    printf("%s\tKW_INT\n", yytext);
}
{KW_REAL} {
    printf("%s\tKW_REAL\n", yytext);
}
{KW_BOOL} {
    printf("%s\tKW_BOOL\n", yytext);
}
{KW_CHAR} {
    printf("%s\tKW_CHAR\n", yytext);
}
{KW_IF} {
    printf("%s\tKW_IF\n", yytext);
}
{KW_ELSE} {
    printf("%s\tKW_ELSE\n", yytext);
}
{KW_SWITCH} {
    printf("%s\tKW_SWITCH\n", yytext);
}
{KW_END} {
    printf("%s\tKW_END\n", yytext);
}
{KW_CASE} {
    printf("%s\tKW_CASE\n", yytext);
}
{KW_DEFAULT} {
    printf("%s\tKW_DEFAULT\n", yytext);
}
{KW_WHILE} {
    printf("%s\tKW_WHILE\n", yytext);
}
{KW_RETURN} {
    printf("%s\tKW_RETURN\n", yytext);
}
{KW_SEMICOLON} {
    printf("%s\tKW_SEMICOLON\n", yytext);
}
{KW_BREAK} {
    printf("%s\tKW_BREAK\n", yytext);
}

{KW_PLUS} {
    printf("%s\tKW_PLUS\n", yytext);
}
{KW_MINUS} {
    printf("%s\tKW_MINUS\n", yytext);
}
{KW_EQUAL} {
    printf("%s\tKW_EQUAL\n", yytext);
}
{KW_DIVIDE} {
    printf("%s\tKW_DIVIDE\n", yytext);
}
{KW_MULTIPLY} {
    printf("%s\tKW_MULTIPLY\n", yytext);
}
{KW_MODULU} {
    printf("%s\tKW_MODULU\n", yytext);
}

{KW_COND_NOT} {
    printf("%s\tKW_COND_NOT\n", yytext);
}
{KW_COND_OR} {
    printf("%s\tKW_COND_OR\n", yytext);
}
{KW_COND_AND} {
    printf("%s\tKW_COND_AND\n", yytext);
}
{KW_COND_THEN} {
    printf("%s\tKW_COND_THEN\n", yytext);
}

{KW_RELOP} {
    printf("%s\tKW_RELOP\n", yytext);
}


{PAR_OP} {
    printf("%s\tPAR_OP\n", yytext);
}
{PAR_CL} {
    printf("%s\tPAR_CL\n", yytext);
}
{BR_OP} {
    printf("%s\tBR_OP\n", yytext);
}
{BR_CL} {
    printf("%s\tBR_CL\n", yytext);
}
{CR_OP} {
    printf("%s\tCR_OP\n", yytext);
}
{CR_CL} {
    printf("%s\tCR_CL\n", yytext);
}


{REAL} {
    printf("%s\tREAL\n", yytext);
}

{FAKE_REAL} {
    printf("%s\tFAKE_REAL\n", yytext);
}
{FAKE_NUMCONST} {
    printf("%s\tFAKE_NUMCONST\n", yytext);
}
{FAKE_ID} {
    printf("%s\tFAKE_ID\n", yytext);
}

. {
    printf("%s\tUnknown\n", yytext);
}

%%
int main() {
    yylex();
}
