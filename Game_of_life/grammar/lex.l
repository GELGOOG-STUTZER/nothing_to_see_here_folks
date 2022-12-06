%{
#define YYSTYPE void*
#include "grammar.tab.h"
extern "C" int yylex();
%}

%option yylineno
%option noyywrap

%%

[/][/].*\n              ; // comment
[0-9]+                  {
                        printf("TINTEGER %s\n", yytext);
                        yylval = strdup(yytext);
                        return TINTEGER;
                        }

"="                     { printf("TEQUAL\n");  return TEQUAL;}
"=="                    { printf("TCEQ\n");    return TCEQ;}
"!="                    { printf("TCNE\n");    return TCNE;}
"<"                     { printf("TCLT\n");    return TCLT;}
"<="                    { printf("TCLE\n");    return TCLE;}
">"                     { printf("TCGT\n");    return TCGT;}
">="                    { printf("TCGE\n");    return TCGE;}
"("                     { printf("TLPAREN\n"); return TLPAREN;}
")"                     { printf("TRPAREN\n"); return TRPAREN;}
"{"                     { printf("TLBRACE\n"); return TLBRACE;}
"}"                     { printf("TRBRACE\n"); return TRBRACE;}
"."                     { printf("TDOT\n");    return TDOT;}
","                     { printf("TCOMMA\n");  return TCOMMA;}


"return"                { printf("TRETURN\n");        return TRETURN;}
"if"                    { printf("TIF\n");            return TIF; }
"while"                 { printf("TWHILE\n");         return TWHILE; }
"for"                   { printf("TFOR\n");           return TFOR; }
"int"                   { printf("TTYPE INT\n");      return TTYPE;}
"void"                  { printf("TTYPE VOID\n");     return TTYPE;}
"start"                 { printf("TSTART\n");         return TSTART;}
"finish"                { printf("TFINISH\n");        return TFINISH;}
"goto"                  { printf("TGOTO\n");          return TGOTO;}
"_Z12window_clearv"     { printf("WINDOW_CLEAR\n");   return WINDOW_CLEAR;}
"_Z11check_eventv"      { printf("CHECK_EVENT\n");    return CHECK_EVENT;}
"_Z5flushv"             { printf("FLUSH\n");          return FLUSH;}
"_Z11init_windowjj"     { printf("INIT_WINDOW\n");    return INIT_WINDOW;}
"put_pixel"             { printf("PUT_PIXEL\n");      return PUT_PIXEL;}
"print"                 { printf("PRINT\n");          return PRINT;}

[a-zA-Z_][a-zA-Z0-9_]*  { // identifier or array
                        printf("TIDENTIFIER %s\n", yytext);
                        yylval = strdup(yytext);
                        return TIDENTIFIER;
                        }



[ \t\r\n]               ; // whitespace
.                       { return *yytext; }

%%