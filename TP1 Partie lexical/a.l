%{
#include <stdio.h>
int ligne=1;
int col=0;
%}
chiffre	[0-9]
lettre [a-zA-Z]
IDF {lettre}({lettre}|{chiffre})*
Entier_nat	0|[1-9]{chiffre}*

%%
BEGIN {printf("le mot clé %s est reconnu \n", yytext);col=col+yyleng;}
END {printf("le mot clé %s est reconnu \n", yytext);col=col+yyleng;}
{Entier_nat} {printf("le mot %s est reconnu \n", yytext);col=col+yyleng;}
{IDF} {printf("le mot %s est reconnu \n", yytext);col=col+yyleng;}
= {printf("le mot %s est reconnu \n", yytext);col++;}
; {printf("le mot %s est reconnu \n", yytext);col++;}
[ \t] col++;
\n {ligne++;col=0;}
.	{printf("\nErreur lexical la ligne %d et colonne %d",ligne,col);}
%%
int main()
{
yylex(); return 0;
}
int yywrap(void)
{
return 0;
}