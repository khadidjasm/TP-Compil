%{
#include<stdio.h>
#include<string.h>
#include "exemple.tab.h" 
int nb_ligne=1;
int col=0;
extern YYSTYPE yylval;
%}
%option noyywrap
idf [a-z]([a-z]|[0-9])*
cst [1-9][0-9]*|0
%%
begin {return mc_begin;col=col+yyleng;}
end {return mc_end;col=col+yyleng;}
program {return mc_program;col=col+yyleng;}
integer {return mc_integer;col=col+yyleng;}
real {return mc_real;col=col+yyleng;}

[ \t] {col=col+yyleng;}
\n {nb_ligne++;col=col+yyleng;}
[{}()=,;<>/"] {return yytext[0];col=col+yyleng;}
{cst} {yylval.num=atoi(yytext);
          
         return cst;}	
{idf}  {if (yyleng<=10) {yylval.str=strdup(yytext);
                                          
                                           return idf;}
    else printf("erreur lexical %d ligne et colonne %d: IDF trop long ",ligne,col);

        }
. printf ("erreur lexical %d ligne et colonne %d",ligne,col);
%%

