%{

#include <string.h>
enum {INT=1, FLOAT, BOOL, STRING, IDENT, NEW_LINE, OPERADOR,KEYWORD, UNKNOWN, WHITE_SPACE};
char globalValue[0x100];

%}
%option noyywrap

KEYWORDS    "var"|"import"|"package"|"int"|"float"[32|64]|"string"

INT         [0-9]+
FLOAT       [0-9]+\.[0-9]*]\.[0-9]+
BOOL        "true"|"false"
STRING      \"[.]*\"

IDENT       [a-zA-Z_][0-9a-zA-Z_]*
OPERADOR    "+"|"*"|"-"|"/"
WHITESPACE  [ |\t]


%%

{KEYWORDS}              { strcpy(globalValue, yytext); return(KEYWORD); }

{INT}                { strcpy(globalValue, yytext); return(INT); }
{FLOAT}                { strcpy(globalValue, yytext); return(FLOAT); }
{BOOL}                { strcpy(globalValue, yytext); return(BOOL); }
{STRING}                { strcpy(globalValue, yytext); return(STRING); }

{IDENT}                 { strcpy(globalValue, yytext); return(IDENT); }
{OPERADOR}           { strcpy(globalValue, yytext); return(OPERADOR); }
[\n]                    { strcpy(globalValue, yytext); return(NEW_LINE); }
{WHITESPACE}            { strcpy(globalValue, yytext); return(WHITE_SPACE); }
.                       { strcpy(globalValue, yytext); return(UNKNOWN); }

%%


int main()
{
    int token;
    do
    {
        token=yylex();
        switch(token)
        {
            case 0:             fprintf(stderr, "END_OF_FILE\n");                    break;
            case INT:        fprintf(stderr, "Integer [%s]\n", globalValue);       break;
            case FLOAT:        fprintf(stderr, "Float [%s]\n", globalValue);      break;
            case BOOL:        fprintf(stderr, "Boolean [%s]\n", globalValue);      break;
            case STRING:        fprintf(stderr, "String [%s]\n", globalValue);      break;
            case IDENT:         fprintf(stderr, "IDENT [%s]\n", globalValue);        break;
            case NEW_LINE:      fprintf(stderr, "NEW_LINE [%s]\n", globalValue);     break;
            case OPERADOR:      fprintf(stderr, "Operador [%s]\n", globalValue);     break;
            case KEYWORD:       fprintf(stderr, "KEYWORD[%s]\n", globalValue);       break;
            case UNKNOWN:       fprintf(stderr, "UNKNOWN[%s]\n", globalValue);       break;
            case WHITE_SPACE:   fprintf(stderr, "WHITE_SPACE[%s]\n", globalValue);   break;
        }
    } while(token);
    return(0);
}