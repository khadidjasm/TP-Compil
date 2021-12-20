%{
#include<stdio.h>
#include<string.h>
#include "exemple.tab.h" 
int ligne=1;
int col=0;
extern YYSTYPE yylval;
%}
%option noyywrap
idf [a-z]([a-z]|[0-9])*
comparison_expression >|<|==|>=|<=|!=
cst [1-9][0-9]*|0
%%
begin {return mc_begin;col=col+yyleng;}
end {return mc_end;col=col+yyleng;}
program {return mc_program;col=col+yyleng;}
integer {return mc_integer;col=col+yyleng;}
real {return mc_real;col=col+yyleng;}
while {return mc_while; col=col+yyleng;}
do {return mc_do; col=col+yyleng;}
[ \t] {col=col+yyleng;}
\n {ligne++;col=0;}
[()=,;/"] {return yytext[0];col=col+yyleng;}
{cst} {yylval.num=atoi(yytext);         
         return cst;}	
{idf}  {if (yyleng<=10) {yylval.str=strdup(yytext);
                            return idf;}
    else printf("erreur lexical %d ligne et colonne %d: IDF trop long ",ligne,col);
        }
{comparison_expression} {
	col = col + yyleng;
	if(strcmp(yytext,">")==0)
		return '>';
	else if(strcmp(yytext,"<")==0)
			return '<';
		else if(strcmp(yytext,"<=")==0)
				return infEgal;
			else if(strcmp(yytext,">=")==0)
					return subEgal;
				else if(strcmp(yytext,"==")==0)
						return doubleEgal;
					else if(strcmp(yytext,"!=")==0)
							return notEgal;
}
. printf ("erreur lexical %d ligne et colonne %d",ligne,col);
%%

