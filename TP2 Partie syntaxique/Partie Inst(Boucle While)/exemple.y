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
                 
%token mc_begin mc_end mc_program mc_integer mc_real mc_while mc_do subEgal infEgal doubleEgal notEgal  ';' ',' '=' '/' '(' ')' '<' '>' '"'
%token <str>idf
%token <num>cst
%%

S: entete declaration mc_begin corps mc_end { printf ("programme syntaxiquement juste");YYACCEPT ;}
;

entete: mc_program  idf
;

declaration: type listeparam ';' declaration | type listeparam ';'
;

listeparam: listeparam ',' idf | idf 

;

type: mc_integer | mc_real
;

corps: corps inst | inst
;

inst : instaff ';'| instwhile ';'
;
instwhile: mc_while '(' expression ')' mc_do mc_begin corps mc_end
;
instaff: idf '=' value 	   	   
	| idf '=' instdiv
;
expression: idf '>' value 
	     |idf '<' value 
	     |idf subEgal value 
	     |idf infEgal value 
	     |idf doubleEgal value 
	     |idf notEgal value 
;  
instdiv:  value '/' value 							
;
value: idf|cst
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

