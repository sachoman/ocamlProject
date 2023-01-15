Base project for Ocaml project on Ford-Fulkerson. This project contains some simple configuration files to facilitate editing Ocaml in VSCode.

To use, you should install the *OCaml* extension in VSCode. Other extensions might work as well but make sure there is only one installed.
Then open VSCode in the root directory of this repository (command line: `code path/to/ocaml-maxflow-project`).

Features :
 - full compilation as VSCode build task (Ctrl+Shift+b)
 - highlights of compilation errors as you type
 - code completion
 - automatic indentation on file save


A makefile provides some useful commands:
 - `make build` to compile. This creates an ftest.native executable
 - `make demo` to run the `ftest` program with some arguments
 - `make format` to indent the entire project
 - `make edit` to open the project in VSCode
 - `make clean` to remove build artifacts

In case of trouble with the VSCode extension (e.g. the project does not build, there are strange mistakes), a common workaround is to (1) close vscode, (2) `make clean`, (3) `make build` and (4) reopen vscode (`make edit`).

========================================
================ PROJET ================
========================================

# Contexte :
Le problème consiste en l'attribution de lits pour des "hackers" chez des "hosts".
Les hosts renseignent le nombre de lits disponibles dans un premier fichier .csv
(cf. fichier SheetsOCAMLappariement.csv)
Dans un second fichier on renseigne les affinités entre les hosts et les hackers.
Des exemples de fichiers sont présents dans le dossier "datas".
/!\ Le premier string de la première ligne (cellule A1 dans un tableur) dénombre les hosts dans le premier fichier,
le nombre de hackers à héberger dans le second fichier.

# Medium project

   ### Données 

Les données sont des tableaux excel dans le dossier `datas`:
    - Un fichier `SheetsOCAMLcapacites.csv` qui contient les différentes capacités de chaque hôte
    - Un fichier `SheetsOCAMLappariement.csv` qui contient la correspondance entre chez quels hôtes les hackers peuvent dormir (0 : non, 1 : oui).
Bien respecter la nomenclature des fichiers et leur structure si ils viennet à être modifiés.

   ### Makefile 

On exécute le programme avec `make probleme`.
Le programme donne l'organisation des logements dans la console.
Via la commande `make viewprobleme` on peut voir le graphe de flow ainsi obtenu (apres avoir éxécuté `make probleme`).

   ### Les Fichiers 

Le fichier `parser.ml` traite les données de l'excel et les renvoie sous forme de listes. 
Ces données sont ensuite utilisées par `createCustomGraph.ml` pour générer le graphe correspondant à la situation.
Enfin le fichier `hostHackers.ml`assemble nos différentes fonction et FordFulkerson pour produire la solution.

   ### Principe du programme

Afin de modéliser la situation, chaque hacker et chaque host est modélisé par un noeud.
On ajout 2 noeuds, un "source" (id -1) et un "puit" (id -2).
Les hackers sont reliés à la source avec des arcs d'une capacité de 1 (un hacker a besoin d'un lit).
Les hosts sont reliés au puit avec des arcs ayant pour capacité la capacité d'accueil du host.
Enfin, les hackers sont reliés aux hosts en fonction de leur affinité (arc de capacité 1 si affinité, par d'arc sinon).

Les id des noeuds sont donnés de la façon suivante : pour n hosts et m hackers on a
de 0 à (n-1) les hosts puis de n à (n+m-1) les hackers.

Il suffit enfin d'exécuter l'algorithme de FordFulkerson entre la source et le puit pour obtenir le résultat souhaité.
La solution s'interprète de la façon suivante : si le flux entre un hacker et un host est à 1 alors le second héberge le premier.
Le programme indentifie les hackers sans logement si le cas se présente.

# Better project

   ### Données 

Les données sont des tableaux excel dans le dossier `datas`:
    - Un fichier `SheetsOCAMLcapacites.csv` qui contient les différentes capacités de chaque hôte
    - Un fichier `SheetsOCAMLbetterappariement.csv` qui contient le score d'affinité (compris entre 0 et 100) entre chez chaque hôte et hacker.
Bien respecter la nomenclature des fichiers et leur structure si ils viennet à être modifiés.

   ### Makefile 

On exécute le programme avec la commande `make betterprobleme`.
Via la commande `make viewprobleme` on peut voir le graphe de flow ainsi obtenu (apres avoir éxécuté `make betterprobleme`).

   ### Fichiers

Le fichier `betterparser.ml` traite les données de l'excel et les renvoie sous forme de listes. 
Ces données sont ensuite utilisées par `cbetterCreateCustomGraph.ml` pour générer le graphe correspondant à la situation.
Le fichier `betterFordFulkerson.ml` reprend l'algorithme de FordFulkerson mais implémente une fonction différente pour trouver le chemin aémliorant. Nous utilisons aussi le fichier `priorityQueue.ml` pour implémenter la strcture de file de priorité (lègèrement adaptée à notre situation).
Enfin le fichier `betterHostHackers.ml`assemble nos différentes fonction et FordFulkerson pour produire la solution.

   ### Principe du programme

Ici, on prend en compte les affinités de façon graduée (pourcentage).
Le fichier de capacité des hosts ne change pas. Pour celui des affinités on remplace les 0 et 1 par une valeur entre 0 et 100
(cf. fichier SheetsOCAMLbetterappariement.csv)

Le programme cherche ici à trouver la correspondance entre host et hackers qui permet de loger le maximum de hackers et qui, parmis toutes celles qui le permettent, maximise la somme des scores d'affinités.
On utilise une combinaison des algorithmes de Dijkstra et FordFulkerson ;
Dijkstra permet de trouver le chemin améliorant de poids minimal à partir du graphe résiduel et d'une liste de coûts des arrêtes.
Grâce à la configuration particulière de notre graphe l'algorithme de dijkstra est bien pertinent ici même si nous avons dans notre graphe résiduel des arrêtes de poids négatif.
En effet dans le graphe résiduel, quand on parcourt une arrête négative, cela revient à changer un matching "optimal" pour matching "moins optimal" pour un hacker, et donc produit au final un ensemble d'arrêtes parcourues pour arriver au sommet destination qui est de poids positif. D'où le fait que dijkstra fonctionne bien pour le problème.
les chemins améliorants de FordFulkerson sont donnés par Diskstra.

L'interprétation est la même que pour le medium project.

(pour des raisons de simplifications, la source a l'id (n+m) et le puit a l'id (n+m+1))

Pour plus de précisions, rendez-vous lundi à 9h45 ;-)
