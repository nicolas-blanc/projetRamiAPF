open Regle
open MultiEnsemble

(*module RRummikub : REGLE*)

(*Type couleur permettant de définir les couleurs possibles pour une tuile de rummikub*)
  type couleur = Bleu|Rouge|Jaune|Noir

  (*Type définissant les pieces possibles au rummikub: Une tuile possédant un numéro et une couleur ou un Joker.*)
  type t = Tuile of (int*couleur)|Joker

(*Represente une liste de pièces, différe du mset par le fait qu'une pièce n'est présente qu'une fois par emplacement.*)
  type combi = t list

(*Représente un ensemble de pièces, comme la pioche ou une main de joeurs.*)
  type main = t MultiEnsemble.mset

  (*Représente l'etat d'une partie.
  Noms cotient les noms des joeurs, scores leurs scores respectifs, mains leurs mains, table contient l'ensemble des combinaisons posées
sur la table, pioche représente les pieces de la pioche, pose contient des booléens indiquant qui a pose ce tour si et enfin tour contient
le numéro du tour en cours.*)
  type etat = { noms: string array; scores: int array; mains: main array;
		table: combi list; pioche: main; pose: bool array; tour: int}

(*Fonction génerant un paquet de pièces contenant toutes les pièces possibles pour le jeu.
Entrées: main = paquet de piece à remplir et un entier pour incrémenter le numéro des pieces
Sortie: main remplie*)
	val genere : main -> int -> main

	(*Teste si une combinaison de piece respecte la regle d'une combinaison monochrome, c'est à dire des pieces de la même couleur
	 formant une suite de nombres.
	Entrées: La combinaison à tester, la couleur de la dernière tuile testée et sa valeur(recursion)
	Sortie: Si la combinaison est monochrome ou pas. *)
	val monochrome : combi -> couleur -> int -> bool

	(*Teste si une combinaison respecte la regle d'une combinaison de couleur différentes mais de même numéro.
	Entrées: combinaison à tester, la couleur de la dernière tuile testée et sa valeur (recursion)
	Sortie: Si la combinaison est valide ou non*)
	val different_color : combi -> couleur -> int -> bool

	(*Calcul la valeur en points de la combinaison passée en paramètre.*)
	val points_listes : combi -> int

	(*Calcul les points totaux rapportées par un ensemble de combinaisons.
	Entrées: une liste des combinaisons jouées, la valeur de points actuelle (recursion)
	Sortie: valeur totale des combinaisons*)
	val points_totaux : combi list -> int -> int

	(*Teste si l'ensemble des combinaisons proposées sont valides*)
	val tout_valide : combi list -> bool

	(*Permet de transformer une combinaison valide respectant la regle "monochrome" composée de joker en une combinaison de même valeur
	simplement pour faciliter les calculs de points.
	Entrées: combinaison à transformer, valeur de la première piece de la combinaison et sa couleur
	Sortie: même combinaison mais sans joker
	/!\ ATTENTION: Ne fonctionne que sur des combinaisons ne commenceant pas par un joker.*)
	val joker_to_monochrome : combi -> int -> couleur -> combi

	(*Calcul les points d'une combinaison respectant la regle du "même nombre, differentes couleurs"
	Entrées: la combinaison dont on veut calculer les points.
	Sortie: Le nombre de points*)
	val points_differentscolors : combi -> int

	(*Calcul du nombre de points d'une combinaison respectant la regle "suite de piece de même couleur"
	Entrées: combinaison à calculer, valeur de la premère piece
	Sortie: valeur de la combinaison*)
	val points_monochrome : combi -> int -> int

	(*Vérifie que le premier coup d'un joueur respecte toutes les conditions imposéés à une première pose.
	Entrées: La main du joueur , l'ensemble des combinaisons qu'il veut poser, *)
	val premier_coup_valide : main -> combi list -> main -> bool

	(*Calcul les points présents dans la mains d'un joueur à la fin d'une partie.
	Entrée: main du joueur
	Sortie: Valeur de la main.*)
	val points_finaux : main -> int