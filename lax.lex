%option noyywrap
%{
    int counter = 0;
%}

digit [0-9]
letter [a-zA-Z]
letdig ({digit}|{letter})

ID #{letter}{letter}{digit}{digit}
NUMCONST {digit}+

CHARCONST_SINGLEQOUTE ("'"[^"'"]"'")
CHARCONST_SINGLEBACKSLASH ("\\"[^n0])
CHARCONST ({CHARCONST_SINGLEQOUTE}|{CHARCONST_SINGLEBACKSLASH})
BOOLCONST "true" | "false"

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
KW_BI_OPERATOR ("+="|"+"|"-"|"-="|"="|"/="|"*=")
KW_UN_OPERATOR ("++"|"--")
KW_COND_OPERATOR ("or"|"and"|"and then"|"or else")
KW_COND_NOT "not"
KW_RELOP (".le"|".lt"|".gt"|".ge"|".eq"|".ne")
KW_UN_MATH_OPERATOR ({WHITESPACE}([-*?])|(^[-*?])
KW_BI_MATH_OPERATOR [+-*/%]

PAR_OP "("
PAR_CL ")"
BR_OP "["
BR_CL "]"

%%
{ID} {
    printf("ID");
}
{CHARCONST} {
    printf("CHARCONST");
}
{WHITESPACE} {
    printf("WHITESPACE");
}
{COMMENT} {
    printf("COMMENT");
}

. {
    printf("Unknown");
}

"program" {
}
%%
int main() {
    yylex();
}
