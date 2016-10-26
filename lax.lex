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
BOOLCONST ("true") | ("false")

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
{KW_BI_OPERATOR} {
    printf("%s\tKW_BI_OPERATOR\n", yytext);
}
{KW_UN_OPERATOR} {
    printf("%s\tKW_UN_OPERATOR\n", yytext);
}
{KW_COND_OPERATOR} {
    printf("%s\tKW_COND_OPERATOR\n", yytext);
}
{KW_COND_NOT} {
    printf("%s\tKW_COND_NOT\n", yytext);
}
{KW_RELOP} {
    printf("%s\tKW_RELOP\n", yytext);
}
{KW_UN_MATH_OPERATOR} {
    printf("%s\tKW_UN_MATH_OPERATOR\n", yytext);
}
{KW_BI_MATH_OPERATOR} {
    printf("%s\tKW_BI_MATH_OPERATOR\n", yytext);
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





. {
    printf("%s\tUnknown\n", yytext);
}

%%
int main() {
    yylex();
}
