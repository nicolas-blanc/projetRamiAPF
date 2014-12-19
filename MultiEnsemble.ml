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
  |ec::q -> let (el,i) = ec in let (els,is) = e in if (el = els) then if i-is > 0 then (el,i-is)::q else q
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
  |e::q, e2::q2 -> let (el,n) = e2 in if (appmset el mset1) then let res =(suppr e2 mset1) in equalmset res q2 else false;;

let rec diff (mset1 : 't mset) (mset2 : 't mset) : 't mset  = match mset1,mset2 with
  | [],[] -> []
  | [],e::q -> failwith "Il y a plus de tuile dans la main du joueur après la pose des tuiles"
  | e::q,[] -> e::q
  | e::q,e2::q2 -> let (el,n) = e2 in if (appmset el mset1) then diff q q2 else e2::(diff q q2)

(*
Msets permettant de tester la suppression, l'insertion et l'égalité.
let ltest = [(1,2);(2,5);(3,6)];;
let ltest2 = [(1,2);(2,4);(3,5)];;
let res1= suppr (3,7) ltest;;
equalmset ltest ltest2;;
*)
