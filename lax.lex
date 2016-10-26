%option noyywrap
%{
    int counter = 0;
%}

digit [0-9]
letter [a-zA-Z]
letdig ({digit}|{letter})

%%
{letdig} {
    printf("Victory!");
}
%%
int main() {
    yylex();
}
