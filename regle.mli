module type REGLE =
sig
  type t

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
  
  (*Genere le paquet initiale de pieces*)
  val paquet :t MultiEnsemble.mset

  (*Verifie si une combinaison respecte l'une des 2 regles que les combinaisons de piece doivent respecter.
  Entrée: la combi à tester.
  Sortie: combi valide ou non*)
  val combi_valide : combi -> bool

(*Vérifie que le premier coup d'un joueur respecte toutes les conditions imposéés à une première pose.
  Entrées: La main du joueur , l'ensemble des combinaisons qu'il veut poser, *)
  val premier_coup_valide : main -> combi list -> main -> bool

  val points : combi list (* jeu en cours *) -> main (* main du joueur *)
    -> combi list (* nouveau jeu *) -> main (* nouvelle main du joueur *) -> int

  (*Calcul les points présents dans la mains d'un joueur à la fin d'une partie.
  Entrée: main du joueur
  Sortie: Valeur de la main.*)
  val points_finaux : main -> int

  val main_min : int

  val main_initiale : int
  (*val lit_valeur : token list -> t*)
  (*val ecrit_valeur : t -> string*)
  val fin_pioche_vide : bool
end
