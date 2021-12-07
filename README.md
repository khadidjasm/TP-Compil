# TP-Compil

1. Introduction : Nous allons commencer par présenter ce qu’est un compilateur : Un compilateur est un programme informatique qui traduit un langage (appelé le langage source) en un autre (le langage cible), généralement dans le but de créer un exécutable. 
Un compilateur sert le plus souvent à traduire un code source écrit dans un langage de programmation en un autre langage, habituellement un langage d'assemblage ou un langage machine. 
Le programme en langage machine produit par un compilateur est appelé code objet. 

2. Présentation des outils utilisés : 

Flex : est un outil pour générer des analyseurs, programmes qui reconnaissent des motifs lexicaux dans du texte. 
Il lit les fichiers d'entrée donnés, ou bien son entrée standard si aucun fichier n'est donné, pour obtenir la description de l'analyseur à générer. 
La description est une liste de paires d'expressions rationnelles et de code C, appelées règles. En sortie, flex génère un fichier source en langage C, appelé `lex.yy.c', qui définit une routine `yylex()'. 
Ce fichier est compilé et lié avec l'option `-lfl' (correspondant à la bibliothèque flex) afin de produire un programme exécutable. 
Quand l'exécutable est lancé, il analyse son entrée afin d'y trouver des occurrences correspondant aux précédentes expressions régulières.
À chaque expression trouvée, il exécute le code C correspondant.

Bison : est l'implémentation de l'analyseur syntaxique yacc par le projet GNU. 
Scénarios d'utilisation : L'utilisation d'un analyseur syntaxique s'impose sur du code écrit par exemple en C ou C++ lorsqu'on a besoin de remplacer des classes ou autres références par des adaptateurs, ou des appels de fonctions, ou à partir d'autres classes et/ou fonctions. 
Dans ce schéma, GNU Bison peut analyser le code source et remplacer toutes les instances de classes et les fonctions, y compris ses arguments. On peut par ailleurs associer Bison à l'analyseur lexical Flex, version libre de Lex. 
Langages de programmation supportés : GNU Bison peut générer du code C, C++ ou Java, lequel pourra par la suite être compilé.

3. Utilisation conjointe de flex et bison:

La source yacc utilise l'analyseur lexical yylex()qui peut être construit avec flex. L'option -d de la commande bison  génére  un fichier entête(syntaxe.tab.h)qui doit être inclus dans la source de votre programme flex pour pouvoir utiliser les symboles definis par bison er qui contient toutes les entitées définits dans flex. 
Ainsi, pour compiler l'analyseur syntaxique lysa décrit par  syntaxe.y utilisant la definition d'un analyseur lexical lexique.l on procède :
 
Exemple des fichiers: lexique.l syntaxe.y

                     1- flex   lexique.l
                     2- bison  -d syntaxe.y        
                     3- gcc  lex.yy.c syntaxe.tab.c -o exe
                     4- exe ou ./exe (pour executer votre compilateur)

