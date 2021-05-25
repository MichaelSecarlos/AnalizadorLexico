%{
#include <string.h>
enum {INT=1, FLOAT, BOOL, STRING, IDENT, NEW_LINE, OPERADOR,KEYWORD, UNKNOWN, WHITE_SPACE, PACKAGE, INIT_BLOCK, END_BLOCK, INIT_ARGUMENT, END_ARGUMENT};
char globalValue[0x100];
%}

%option noyywrap
PACKAGE     "package"[ ]+[a-zA-Z_][0-9a-zA-Z_]*[\n]
KEYWORDS    "var"|"import"|"int"|"float"[32|64]|"if"

INT         [0-9]+
FLOAT       [0-9]+\.[0-9]*]\.[0-9]+
BOOL        "true"|"false"
STRING      "\""[a-zA-Z0-9_]*[\"]

IDENT       [a-zA-Z_][0-9a-zA-Z_]*
OPERADOR    "+"|"*"|"-"|"/"
WHITESPACE  [ |\t]
INIT_BLOCK  "{"
END_BLOCK   "}"
INIT_ARGUMENT "("
END_ARGUMENT ")"

%%

{KEYWORDS}              { strcpy(globalValue, yytext); return(KEYWORD); }
{PACKAGE}           {strcpy(globalValue, yytext); return(PACKAGE); }
{INT}                { strcpy(globalValue, yytext); return(INT); }
{FLOAT}                { strcpy(globalValue, yytext); return(FLOAT); }
{BOOL}                { strcpy(globalValue, yytext); return(BOOL); }
{STRING}                { strcpy(globalValue, yytext); return(STRING); }

{IDENT}                 { strcpy(globalValue, yytext); return(IDENT); }
{OPERADOR}           { strcpy(globalValue, yytext); return(OPERADOR); }
[\n]                    { strcpy(globalValue, yytext); return(NEW_LINE); }
{WHITESPACE}            { strcpy(globalValue, yytext); return(WHITE_SPACE); }

{INIT_BLOCK}            {strcpy(globalValue, yytext); return(INIT_BLOCK);}
{END_BLOCK}             {strcpy(globalValue, yytext); return(END_BLOCK);}
{INIT_ARGUMENT}         {strcpy(globalValue, yytext); return(INIT_ARGUMENT);}
{END_ARGUMENT}          {strcpy(globalValue, yytext); return(END_ARGUMENT);}
.                       { strcpy(globalValue, yytext); return(UNKNOWN); }

%%


int main(){
    int token;
    do{
        token=yylex();
        switch(token){
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
            case PACKAGE:       fprintf(stderr, "PACKAGE[%s]\n", globalValue);      break;
            case INIT_BLOCK:       fprintf(stderr, "INIT_BLOCK[%s]\n", globalValue);      break;
            case END_BLOCK:       fprintf(stderr, "END_BLOCK[%s]\n", globalValue);      break;
            case INIT_ARGUMENT:       fprintf(stderr, "INIT_ARGUMENT[%s]\n", globalValue);      break;
            case END_ARGUMENT:       fprintf(stderr, "END_ARGUMENT[%s]\n", globalValue);      break;
        }
    } while(token);
    return(0);
}