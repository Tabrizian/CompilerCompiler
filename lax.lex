%option noyywrap
%{
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
letdig ({digit}%s\t\t\t|{letter})

ID #{letter}{letter}{digit}{digit}
FAKE_ID ("#"{letdig}*)%s\t\t\t|({letter}{letdig}*)
REAL (("0")%s\t\t\t|({non_zero_digit}{digit}*))"."(({digit}*{non_zero_digit})%s\t\t\t|"0")

NUMCONST ("0")%s\t\t\t|({non_zero_digit}{digit}*)
FAKE_NUMCONST ("0")%s\t\t\t|({digit}*)
FAKE_REAL (("0")%s\t\t\t|({digit}*))"."({digit}*)
CHARCONST_SINGLEQOUTE ("'"{letdig}"'")
CHARCONST_SINGLEBACKSLASH ("\\"{letdig})
CHARCONST ({CHARCONST_SINGLEQOUTE}%s\t\t\t|{CHARCONST_SINGLEBACKSLASH})
BOOLCONST ("true"%s\t\t\t|"false")

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
KW_RELOP (".le"%s\t\t\t|".lt"%s\t\t\t|".gt"%s\t\t\t|".ge"%s\t\t\t|".eq"%s\t\t\t|".ne")

PAR_OP "("
PAR_CL ")"
BR_OP "["
BR_CL "]"
CR_OP [{]
CR_CL [}]
PUNC_KW ","

%%
{ID} {
    struct record new_record;
    new_record.token = "ID";
    new_record.id = no_of_id;
    new_record.value = yytext;
    symbol_table[no_of_id].id = new_record.id;
    printf("%s\t\t\tID\t\t%d\n", yytext, new_record.id);
    no_of_id++;
}
{NUMCONST} {
    printf("%s\t\t\tNUMCONST\t\t-\n", yytext);
}
{CHARCONST} {
    printf("%s\t\t\tCHARCONST\t\t-\n", yytext);
}
{BOOLCONST} {
    printf("%s\t\t\tBOOLCONST\t\t-\n", yytext);
}
{WHITESPACE} {
    printf("%s\t\t\tWHITESPACE\t\t-\n", "white");
}
{COMMENT} {
    printf("%.4s\t\t\tCOMMENT\t\t-\n", yytext);
}



{KW_RECORD} {
    printf("%s\t\t\tKW_RECORD\t\t-\n", yytext);
}
{KW_STATIC} {
    printf("%s\t\t\tKW_STATIC\t\t-\n", yytext);
}
{KW_INT} {
    printf("%s\t\t\tKW_INT\t\t-\n", yytext);
}
{KW_REAL} {
    printf("%s\t\t\tKW_REAL\t\t-\n", yytext);
}
{KW_BOOL} {
    printf("%s\t\t\tKW_BOOL\t\t-\n", yytext);
}
{KW_CHAR} {
    printf("%s\t\t\tKW_CHAR\t\t-\n", yytext);
}
{KW_IF} {
    printf("%s\t\t\tKW_IF\t\t-\n", yytext);
}
{KW_ELSE} {
    printf("%s\t\t\tKW_ELSE\t\t-\n", yytext);
}
{KW_SWITCH} {
    printf("%s\t\t\tKW_SWITCH\t\t-\n", yytext);
}
{KW_END} {
    printf("%s\t\t\tKW_END\t\t-\n", yytext);
}
{KW_CASE} {
    printf("%s\t\t\tKW_CASE\t\t-\n", yytext);
}
{KW_DEFAULT} {
    printf("%s\t\t\tKW_DEFAULT\t\t-\n", yytext);
}
{KW_WHILE} {
    printf("%s\t\t\tKW_WHILE\t\t-\n", yytext);
}
{KW_RETURN} {
    printf("%s\t\t\tKW_RETURN\t\t-\n", yytext);
}
{KW_SEMICOLON} {
    printf("%s\t\t\tKW_SEMICOLON\t\t-\n", yytext);
}
{KW_BREAK} {
    printf("%s\t\t\tKW_BREAK\t\t-\n", yytext);
}

{KW_PLUS} {
    printf("%s\t\t\tKW_PLUS\t\t-\n", yytext);
}
{KW_MINUS} {
    printf("%s\t\t\tKW_MINUS\t\t-\n", yytext);
}
{KW_EQUAL} {
    printf("%s\t\t\tKW_EQUAL\t\t-\n", yytext);
}
{KW_DIVIDE} {
    printf("%s\t\t\tKW_DIVIDE\t\t-\n", yytext);
}
{KW_MULTIPLY} {
    printf("%s\t\t\tKW_MULTIPLY\t\t-\n", yytext);
}
{KW_MODULU} {
    printf("%s\t\t\tKW_MODULU\t\t-\n", yytext);
}

{KW_COND_NOT} {
    printf("%s\t\t\tKW_COND_NOT\t\t-\n", yytext);
}
{KW_COND_OR} {
    printf("%s\t\t\tKW_COND_OR\t\t-\n", yytext);
}
{KW_COND_AND} {
    printf("%s\t\t\tKW_COND_AND\t\t-\n", yytext);
}
{KW_COND_THEN} {
    printf("%s\t\t\tKW_COND_THEN\t\t-\n", yytext);
}

{KW_RELOP} {
    printf("%s\t\t\tKW_RELOP\t\t-\n", yytext);
}


{PAR_OP} {
    printf("%s\t\t\tPAR_OP\t\t-\n", yytext);
}
{PAR_CL} {
    printf("%s\t\t\tPAR_CL\t\t-\n", yytext);
}
{BR_OP} {
    printf("%s\t\t\tBR_OP\t\t-\n", yytext);
}
{BR_CL} {
    printf("%s\t\t\tBR_CL\t\t-\n", yytext);
}
{CR_OP} {
    printf("%s\t\t\tCR_OP\t\t-\n", yytext);
}
{CR_CL} {
    printf("%s\t\t\tCR_CL\t\t-\n", yytext);
}


{REAL} {
    printf("%s\t\t\tREAL\t\t-\n", yytext);
}

{FAKE_REAL} {
    printf("%s\t\t\tFAKE_REAL\t\t-\n", yytext);
}
{FAKE_NUMCONST} {
    printf("%s\t\t\tFAKE_NUMCONST\t\t-\n", yytext);
}
{FAKE_ID} {
    printf("%s\t\t\tFAKE_ID\t\t-\n", yytext);
}

{PUNC_KW} {
    printf("%s\t\t\tPUNC_KW\t\t-\n", yytext);
}
. {
    printf("%s\t\t\tUnknown\t\t-\n", yytext);
}

%%
int main() {
    printf("Text\t\t\tToken\t\tRefrence To symbol table\n");
    yylex();
}
