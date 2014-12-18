open Regle

  type couleur = Bleu|Rouge|Jaune|Noir
  type t = Tuile of (int*couleur)|Joker
  type combi = t list
  type main = t MultiEnsemble.mset
  type etat = { noms: string array; scores: int array; mains: main array;
		table: combi list; pioche: main; pose: bool array; tour: int}

	val genere : main -> int -> main
	val monochrome : combi -> couleur -> int -> bool
	val different_color : combi -> couleur -> int -> bool
	val combi_valide : combi -> bool
	val points_listes : combi -> int
	val points_totaux : combi list -> int -> int
	val tout_valide : combi list -> bool
	val joker_to_monochrome : combi -> int -> couleur -> combi
	val points_differentscolors : combi -> int
	val points_monochrome : combi -> int -> int
	val premier_coup_valide : main -> combi list -> main -> bool
	val points_finaux : main -> int