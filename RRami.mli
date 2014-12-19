open REGLE
(* open JEU *)

module TRami = 
sig
  (* Permet de compter le nombre d'éléments dans une liste - Equivalent à List.Length
   * Entrée : Liste d'élément
   * Sortie :   
   *)
  val nbElement : 'a list -> int

  (* Permet de verifier si la combinaison appartient appartenait a la main du joueur -> Ancienne Main = Combi + Nouvelle main
   * Entrées : Main du joueur - Nouvelle Main du joueur - Combinaison de lettres à mettre sur le jeux
   * Sortie : renvoie vrai si la combinaison appartient seulement à la main du joueur
   *)
  val lettreMain : main -> main -> combi -> bool

  (* Permet de tester si deux combinaisons sont égales
   * Entrée : une combinaison de lettres - Une autre combinaison de lettres
   * Sortie : Renvoie vrai si les deux combinaison sont les même
   *)
  val equalCombi : combi -> combi -> bool

  (* Permet de tester si une combinaison appartient à une liste de combinaison
   * Entrées : Une combinaison de lettres - une liste de combinaison
   * Sortie : Renvoie vrai si combi appartient à la liste de combi
   *)
  val appMot : combi -> combi list -> bool

  (* Renvoie une liste de combinaison contenant toutes les combinaisons de la deuxième liste de combinaison qui ne sont pas dansla première combinaison
   * Entrées : Une combinaison de liste - Une autre combinaison de liste
   * Sortie : Renvoie une liste de combinaison contenant tout les mots de la seconde liste sans les mots de la première liste
   *)
  val longMot : combi list -> combi list -> combi list

  (* Calcul du nombre d'élément de la plus grande combinaison dans la liste de combinaison
   * Entrée : Une combinaison de liste
   * Sortie : Nombre d'élément de la plus grande combinaison de la liste de combinaison
   *)
  val calculPlusGrandMot : combi list -> int
end
