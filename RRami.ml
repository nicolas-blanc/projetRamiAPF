
module RRami : TRami = 
struct
  type t = Tuile of char | Joker
  type combi = t list
  type main = t MultiEnsemble.mset
  type etat = { noms: string array; scores: int array; mains: main array;
		table: combi list; pioche: main; pose: bool array; tour: int} 
  

  let rec nbElement = function
    | [] -> 0
    | (e::q) -> (nbElement q)

  let lettreMain mainJ newMain combi = MultiEnsemble.equalmset mainJ (MultiEnsemble.uniontmset combi newMain)

  let rec equalCombi c e = match c,e with
    | [],[] -> true
    | [],e::q | e::q,[] -> false
    | e::q, e2::q2 -> e == e2 && equalCombi q q2

  let rec appMot c = function
    | [] -> false
    | e::q -> equalCombi c e || appMot c q

  let rec longMot combiJeux = function
    | [] -> []
    | c::q -> if (appMot c combiJeux) then longMot combiJeux q else c::longMot combiJeux q

  let rec calculPlusGrandMot = function
    | [] -> 0
    | c::q -> let n = (calculPlusGrandMot q) in let n2 = (nbElement c) in if n > n2 then n else n2

  (* val paquet : t MultiEnsemble.mset *)
  let paquet = [(Joker,2); (Tuile('a'),8); (Tuile('b'),2); (Tuile('c'),3); (Tuile('d'),3); (Tuile('e'),16); (Tuile('f'),2); (Tuile('g'),2); (Tuile('h'),2); (Tuile('i'),9); (Tuile('j'),1); (Tuile('k'),1); (Tuile('l'),6); (Tuile('m'),4); (Tuile('n'),7); (Tuile('o'),7); (Tuile('p'),2); (Tuile('q'),1); (Tuile('r'),7); (Tuile('s'),7); (Tuile('t'),7); (Tuile('u'),7); (Tuile('v'),2); (Tuile('w'),1); (Tuile('x'),1); (Tuile('y'),1); (Tuile('z'),1)]

(* val combi_valide : combi -> bool *)
  let combi_valide (combi : combi) = (nbElement combi) > 2 (* Dictionnaire.member combi dico *)

(* val premier_coup_valide : main (* main du joueur *) -> combi list (* pose du joueur *) -> main (* nouvelle main du joueur *) -> bool *)
  let rec premier_coup_valide (mainJ : main) (combi : combi list) (newMain : main) = match combi with
    | [] -> false
    | (c::[]) -> (nbElement c) > 5 && (combi_valide c) && (lettreMain mainJ newMain c)
    | (c::q) -> ((nbElement c) > 5 && (combi_valide c) && (lettreMain mainJ newMain c)) || (premier_coup_valide mainJ q newMain)


(* val points : combi list (* jeu en cours *) -> main (* main du joueur *)
   -> combi list (* nouveau jeu *) -> main (* nouvelle main du joueur *) -> int *)
  let points combiJeux mainJ newCombi newMain = let pt1 = nbElement (MultiEnsemble.diff mainJ newMain) and pt2 = calculPlusGrandMot (longMot combiJeux newCombi) in if nbElement newMain = 0 then (pt1+ pt2) * 2 else pt1 + pt2

(* val points_finaux : main -> int *)
  let points_finaux main = 0

(* val main_min : int *)
  let main_min = 7

(* val main_initiale : int *)
  let main_initiale = 14

(* val fin_pioche_vide : bool *)
  let fin_pioche_vide = false
end
