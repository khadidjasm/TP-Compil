%{
#include<stdio.h>
extern int ligne;
extern int col;
int yyparse();
int yylex();
int yyerror(char *s);

%}

%union {
int num;
char* str;
}   
%start S                
%token begin end aff pvg
%token <str>idf
%token <num>entier
%%

S: begin  corps end { printf ("programme syntaxiquement juste");YYACCEPT ;}
;

corps: corps inst | inst
;

inst : instaff pvg
;

instaff: idf aff idf 
       | idf aff entier 	   	   
	
;



%%
int yyerror(char* msg)
{printf("%s ligne %d et colonne %d",msg,ligne,col);
return 0;
}
int main()  {    
yyparse();  
return 0;  
} 

