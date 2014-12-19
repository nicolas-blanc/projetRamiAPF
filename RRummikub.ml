open MultiEnsemble
open Regle

(*module type RRummikub : REGLE =
struct*)
  type couleur = Bleu|Rouge|Jaune|Noir
  type t = Tuile of (int*couleur)|Joker
  type combi = t list
  type main = t MultiEnsemble.mset
  type etat = { noms: string array; scores: int array; mains: main array;
    table: combi list; pioche: main; pose: bool array; tour: int}

  let main_min = 0
  let main_initiale = 14
  (*let ecrit_valeur : t -> string*)
  let fin_pioche_vide = true

(*Genere un paquet contenant les tuiles des 4 couleurs, de 1 a 13 en 2 exemplaires*)
let rec genere (l:main) (valeur:int) : main = if (valeur > 0) then let l1 = [((Tuile(valeur,Bleu)),2);((Tuile(valeur,Rouge)),2);((Tuile(valeur,Jaune)),2);((Tuile(valeur,Noir)),2)] in genere (MultiEnsemble.unionmset l1 l) (valeur-1) else l

(* Test génération du paquet:*)
let paquet : main = genere [] 13

(*Vérifie qu'une combi est de type monochrome*)
let rec monochrome (c:combi)(co:couleur)(num:int) = match c with
  |[]->true
  |Joker::q -> monochrome q co (num+1)
  |(Tuile(n,coul))::q -> if coul=co && n=num+1 then monochrome q co n else false

(*Vérifie si une liste est de type différente couleurs*)
let rec different_color (c:combi)(co:couleur)(num:int) = match c with
  |[] -> true
  |Joker::q -> different_color q co num
  |(Tuile(n,coul))::q -> if n=num && coul != co then different_color q co num else false

(*Vérifie qu'une liste est valide*)
let rec combi_valide (c:combi) : bool =
  let longueur =  List.length c in
  if (longueur >= 3) then
    match c with
    |[] -> false
    |Joker::q -> combi_valide q
    |(Tuile(n,coul)::q) -> monochrome q coul n || different_color q coul n else false

(*Calcul les points d'une combi de type differentes coueleurs*)
let rec points_differentscolors (c:combi) : int = match c with
  |(Tuile(n,coul)::q) -> (List.length c) * n

(*Calcul les points d'une combi de type monochrome*)
let rec points_monochrome (c:combi) (valeur:int) : int= match c with
  |[]->valeur
  |(Tuile(n,coul)::q) -> let pts = (valeur + n) in points_monochrome q pts

(*Transforme une combinaison de type monochrome contenat des jokers en une combi ne contenant que des tuiles classiques*)
let rec joker_to_monochrome (c:combi) (valeur:int) (co:couleur) = match c with
|[] -> c
|Joker::q -> [(Tuile((valeur+1),co))]@joker_to_monochrome q (valeur+1) co
|(Tuile(n,coul)::q) -> [(Tuile(n,coul))]@joker_to_monochrome q n coul

(*Calcul les points d'une liste*)
let points_listes (c:combi) :int = match c with
  |(Tuile(n,coul)::q) -> if (monochrome q coul n) then points_monochrome (joker_to_monochrome c n coul) 0 else points_differentscolors c

(*Decompose la combi liste en listes afin de faire la somme de leurs valeurs respectives*)
let rec points_totaux (cl:combi list) (valeur:int) : int = match cl with
  |[] -> valeur
  |e::q -> let pt =points_listes e in points_totaux q pt

(*Vérifie que toutes les combinaisons d'une combi liste sont valides*)
let rec tout_valide (c:combi list):bool = match c with
    |[]->true
    |comb::q -> if combi_valide comb then tout_valide q else false

(*Vérifie qu'un premier coup est valide*)
let premier_coup_valide (m:main)(* main du joueur*) (c:combi list) (* pose du joueur *) (m2:main): bool = 
  if (tout_valide c) then (if ((points_totaux c 0) >= 30) then true else false) else false

(*Calcul les points restants dans la main d'un joueur*)
let points_finaux (m:main) : int =
  let rec points_finaux_aux (m:main) (pts:int) = match m with 
  |[] -> pts 
  |((Joker,n)::q) -> points_finaux_aux q (pts+(n*30))
  |((Tuile(n,coul),i)::q) -> points_finaux_aux q (pts+(n*i))
  in points_finaux_aux m 0

let points (cl1:combi list) (m1:main) (cl1:combi list) (m0:main) : int = 1

(*end*)
(*
(*Test premier_coup_vlide*)
let combijokerTest = [(Tuile(2,Bleu));(Tuile(3,Bleu));Joker;(Tuile(5,Bleu))];;
let combijokerTest2 = [(Tuile(2,Bleu));Joker;(Tuile(4,Bleu))];;
let combidifcolor =[(Tuile(13,Bleu));(Tuile(13,Rouge));Joker;(Tuile(13,Jaune))];;
let combili = [combijokerTest;combijokerTest2;combidifcolor];;
premier_coup_valide combili;;

let combijoker = is_monochrome combijokerTest;;
let combijoker2 = test_ismonochrome combijokerTest Bleu 1;;
let combijoker3 = test_ismonochrome combijokerTest2 Bleu 1;;

let ltest =[];;
let ltest5 = [((2,Bleu),1);((4,Rouge),2)];;
let combitest = [(2,Bleu);(1,Rouge)];;
combi_valide combitest;;

let value = points_finaux ltest5;;

let combi_test2 = [Joker;(Tuile(4,Bleu));(Tuile(5,Bleu));(Tuile(6,Bleu))];;
monochrome combi_test2 Bleu 2;;
let combi_test3 = [Joker;(Tuile(4,Bleu));(Tuile(4,Rouge));Joker;(Tuile(4,Jaune))];;
same_color combi_test3 Noir 4;;


combi_valide combi_test3;;

*)
