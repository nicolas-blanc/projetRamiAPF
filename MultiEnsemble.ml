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

let rec diff (mset1 : 't mset) (mset2 : 't mset) : 't mset  = match mset1,mset2 with
  | [],[] -> []
  | [],e::q -> failwith "Il y a plus de tuile dans la main du joueur après la pose des tuiles"
  | e::q,[] -> e::q
  | e::q,e2::q2 -> let (el,n) = e2 in if (appmset el mset1) then diff q q2 else e2::(diff q q2)

let rec unionTmset list mset = match list with
  | [] -> mset
  | e::q -> unionTmset q (ajoute (e,1) mset)
