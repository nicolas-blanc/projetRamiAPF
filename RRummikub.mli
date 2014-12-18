open Regle

module type RRummikub : REGLE =
sig
	val genere : main -> int -> main
	val monochrome : combi -> couleur -> int
	val different_color : combi -> couleur -> int
	val combi_valide : combi -> bool
	val points_listes : combi -> int
	val points_totaux : combi list -> int -> int
	val tout_valide : combi list -> bool
	val joker_to_monochrome : combi -> int -> couleur
	val points_differentscolors : combi -> int
	val points_monochrome : combi -> int -> int
	val premier_coup_valide : combi list -> bool
	val points_finaux : main -> int
end
