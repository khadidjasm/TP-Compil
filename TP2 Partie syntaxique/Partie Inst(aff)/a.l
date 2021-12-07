%{
#include <stdio.h>
#include<string.h>
#include "a.tab.h" 
int ligne=1;
int col=0;
extern YYSTYPE yylval;
%}
chiffre	[0-9]
lettre [a-zA-Z]
IDF {lettre}({lettre}|{chiffre})*
Entier_nat 0|[1-9]{chiffre}*

%%
BEGIN {return begin;col=col+yyleng;}
END {return end;col=col+yyleng;}
{Entier_nat} {yylval.num=atoi(yytext);return entier;col=col+yyleng;}
{IDF} {if (yyleng<=10) {yylval.str=strdup(yytext);
                                          
                                           return idf;}
    else printf("erreur lexical à la ligne %d et colonne %d: IDF trop long ",ligne,col);col=col+yyleng;}
= {return aff;col++;}
; {return pvg;col++;}
[ \t] col++;
\n {ligne++;col=0;}
.	{printf("\nErreur lexicale à la ligne %d et colonne %d",ligne,col);}
%%

int yywrap(void)
{
return 0;
}
