%{
#include<stdio.h>
extern int ligne;
extern int col;
int yyparse();
int yylex();
int yyerror(char *s);
int typeidf;
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

listeparam: listeparam ',' idf { insert($1,typeidf,0);}
| idf { insert($1,typeidf,0);}

;

type: mc_integer {typeidf=0;}
| mc_real {typeidf=1;}
;

corps: corps inst | inst
;

inst : instaff ';'| instwhile ';'
;
instwhile: mc_while '(' expression ')' mc_do mc_begin corps mc_end
;
instaff: idf '=' value 	{//verification non declaration
                         //incompatibilité de type
						 //modification d'une constante
						 //sauvegarder le valeur de $$ pour la divizion par zéro
						 } 	   
	| idf '=' instdiv     {//verification non declaration
                         //incompatibilité de type
						 //modification d'une constante
						 //sauvegarder le valeur de $$ pour la divizion par zéro
						 } 
;
expression: idf '>' value {//verification non declaration
                         //incompatibilité de type
						 
						 } 
	     |idf '<' value {//verification non declaration
                         //incompatibilité de type
						 
						 } 
	     |idf subEgal value {//verification non declaration
                         //incompatibilité de type
						 
						 } 
	     |idf infEgal value {//verification non declaration
                         //incompatibilité de type
						 
						 } 
	     |idf doubleEgal value {//verification non declaration
                         //incompatibilité de type
						 
						 } 
	     |idf notEgal value {//verification non declaration
                         //incompatibilité de type
						 
						 } 
;  
instdiv:  value '/' value {//division par zéro
                          }							
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

