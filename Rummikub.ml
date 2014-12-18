module MultiEnsemble =
struct
type 't mset = ('t*int) list;;

  let msetvide = [];;

  let rec ajoute (el : 't*int) (mset:'t mset) : 't mset = match mset with
    |[] -> [el]
    |e::q -> let (l,n) = el in let (l2,n2) = e in if (l=l2) then (l2,n+n2)::q else e::ajoute el q;;

  let rec suppr_totale e mset : 't mset = match mset with
    |[] -> failwith "liste vide"
    |ec::q -> let (el,i) = ec in if (el = e) then q else ec::(suppr_totale e q);;

  let rec suppr e mset: 't mset =  match mset with
    |[] -> failwith "liste vide"
    |ec::q -> let (el,i) = ec in if (el = e) then if i-1 > 0 then (el,i-1)::q else q
      else ec::(suppr e q);;

  let rec appmset t mset : bool = match mset with
    |[] -> false
    |e::q-> let (el,i) = e in if el = t then true else appmset t q;;

  let rec unionmset mset1 mset2 : 't mset = match mset2 with
    |[] -> mset1
    |e::q -> unionmset (ajoute e mset1) q ;;

  let rec equalmset mset1 mset2 : bool = match mset1,mset2 with
    |[],[]-> true
    |[],e::q | e::q,[]-> false
    |e::q, e2::q2 -> let (el,n) = e2 in if (appmset el mset1) then let res =(suppr el mset1) in equalmset res q2 else false;;

end;;

module type REGLE =
sig
  type t
  type combi = t list
  type main = t MultiEnsemble.mset
  type etat = { noms: string array; scores: int array; mains: main array;
		table: combi list; pioche: main; pose: bool array; tour: int}
  val paquet : t MultiEnsemble.mset
  val combi_valide : combi -> bool
  val premier_coup_valide : main (* main du joueur *) -> combi list (* pose du joueur *) -> main (* nouvelle main du joueur *) -> bool
  val points : combi list (* jeu en cours *) -> main (* main du joueur *)
    -> combi list (* nouveau jeu *) -> main (* nouvelle main du joueur *) -> int
  val points_finaux : main -> int
  val main_min : int
  val main_initiale : int
  (*val lit_valeur : token list -> t*)
  val ecrit_valeur : t -> string
  val fin_pioche_vide : bool
end;;

module Rummikub : REGLE =
struct
  type couleur = Bleu|Rouge|Jaune|Noir
  type t = Tuile of (int*couleur)|Joker
  type combi = t list
  type main = t MultiEnsemble.mset
  type etat = { noms: string array; scores: int array; mains: main array;
		table: combi list; pioche: main; pose: bool array; tour: int}
  let main_min = 0;
  let main_initiale = 14;
  let ecrit_valeur : t -> string
  let fin_pioche_vide = true;

(*Genere un paquet contenant les tuiles des 4 couleurs, de 1 a 13 en 2 exemplaires*)
let rec genere (l:main) (valeur:int) : main = if valeur > 0 then let l1 = [((Tuile(valeur,Bleu)),2);((Tuile(valeur,Rouge)),2);((Tuile(valeur,Jaune)),2);((Tuile(valeur,Noir)),2)] in genere (MultiEnsemble.unionmset l1 l) (valeur-1) else l;;
(* Test génération du paquet:
let paquet2 : main = genere [] 13;;*)

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
    |(Tuile(n,coul)::q) -> monochrome q coul n || different_color q coul n else false;;

(*Calcul les points d'une liste*)
let points_listes (c:combi) :int = match c with
  |(Tuile(n,coul)::q) -> if (monochrome q coul n) then points_monochrome (joker_to_monochrome c n coul) 0 else points_differentscolors c;;

(*Decompose la combi liste en listes afin de faire la somme de leurs valeurs respectives*)
let rec points_totaux (cl:combi list) (valeur:int) : int = match cl with
  |[] -> valeur
  |e::q -> let pt =points_listes e in points_totaux q pt;;

(*Vérifie que toutes les combinaisons d'une combi liste sont valides*)
let rec tout_valide (c:combi list) = match c with
    |[]->true
    |comb::q -> if combi_valide comb then tout_valide q else false;; 

(*Transforme une combinaison de type monochrome contenat des jokers en une combi ne contenant que des tuiles classiques*)
let rec joker_to_monochrome (c:combi) (valeur:int) (co:couleur) = match c with
|[] -> c
|Joker::q -> [(Tuile((valeur+1),co))]@joker_to_monochrome q (valeur+1) co
|(Tuile(n,coul)::q) -> [(Tuile(n,coul))]@joker_to_monochrome q n coul;;

(*Calcul les points d'une combi de type differentes coueleurs*)
let rec points_differentscolors (c:combi) : int = match c with
  |(Tuile(n,coul)::q) -> (List.length c) * n;;

(*Calcul les points d'une combi de type monochrome*)
let rec points_monochrome (c:combi) (valeur:int) : int= match c with
  |[]->valeur
  |(Tuile(n,coul)::q) -> let pts = (valeur + n) in points_monochrome q pts;;

(*Vérifie qu'un premier coup est valide*)
let premier_coup_valide (*(m:main) main du joueur*) (c:combi list) (* pose du joueur *): bool = 
  if (tout_valide c) then (if ((points_totaux c 0) >= 30) then true else false) else false;;

(*Calcul les points restants dans la main d'un joueur*)
let points_finaux (m:main) : int =
  let rec points_finaux_aux (m:main) (pts:int) = match m with 
  |[] -> pts 
  |((Joker,n)::q) -> points_finaux_aux q (pts+(n*30))
  |((Tuile(n,coul),i)::q) -> points_finaux_aux q (pts+(n*i))
  in points_finaux_aux m 0;;

end;;

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
