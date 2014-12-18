open REGLE
(* open JEU *)

module TRami = 
sig
  val nbElement : 'a list -> int
  val lettreMain : main -> main -> combi
  val equalCombi : combi -> combi -> bool
  val appMot : combi -> combi list -> bool
  val longMot : combi list -> combi list -> combi list
  val calculPlusGrandMot : combi list -> int
end
