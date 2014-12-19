open Regle
open MultiEnsemble
(* open JEU *)

  type t

  (*Represente une liste de pièces, différe du mset par le fait qu'une pièce n'est présente qu'une fois par emplacement.*)
  type combi = t list

(*Représente un ensemble de pièces, comme la pioche ou une main de joeurs.*)
  type main = t MultiEnsemble.mset

  val nbElement : 'a list -> int
  val lettreMain : main -> main -> combi -> bool
  val equalCombi : combi -> combi -> bool
  val appMot : combi -> combi list -> bool
  val longMot : combi list -> combi list -> combi list
  val calculPlusGrandMot : combi list -> int
  val unionTmset : 't list -> 't mset -> 't mset