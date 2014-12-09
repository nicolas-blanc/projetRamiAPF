module type TmultiEnsemble =
  sig
    type 't mset = ('t*int) list
    val unionmset : 't mset -> 't mset -> 't mset
    val ajoute : ('t*int) -> 't mset -> 't mset
    val appmset : 't -> 't mset -> bool
    val equalmset : 't mset -> 't mset -> bool
    val suppr : 't -> 't mset -> 't mset
  end;;

module MultiEnsemble : TmultiEnsemble =
struct
  type 't mset = ('t*int) list;;

  let rec ajoute (el : 't*int) (mset:'t mset) : 't mset = match mset with
    |[] -> [el]
    |e::q -> let (l,n) = el in let (l2,n2) = e in if (l=l2) then (l2,n+n2)::q else e::ajoute el q;;

  let rec suppr e mset : 't mset = match mset with
    |[] -> failwith "liste vide"
    |ec::q -> let (el,i) = ec in if (el = e) then q else ec::(suppr e q);;

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
end ;;

let list1 =[(1,1);(2,2);(3,3);(4,4)];;
let list3 =[(1,3);(2,2);(3,3);(4,5)];;

#trace MultiEnsemble.suppr;;
MultiEnsemble.suppr 2 list1;;
MultiEnsemble.suppr 1 list1;;

MultiEnsemble.equalmset list1 list3;;

let list3 =[(1,2);(2,3);(3,4);(4,5)];;
let list2 =[(1,1);(2,2);(3,3);(5,4)];;

MultiEnsemble.unionmset list3 list2;;
MultiEnsemble.ajoute (1,1) list2;;

let listc =[('a',2);('b',2);('c',3);('d',4)];;
MultiEnsemble.appmset 'e' listc;;
let listc2 = MultiEnsemble.ajoute ('e',1) listc;;
let listc2 = MultiEnsemble.suppr 'e' listc2;;
MultiEnsemble.equalmset listc listc2;;

let rami = [((3,"rouge"),2);((4,"bleu"),2);((5,"noir"),3);((6,"vert"),4)];;
let rami3 = [((3,"rouge"),2);((4,"bleu"),2);((5,"noir"),3);((6,"vert"),4)];;
let rami2 = MultiEnsemble.ajoute ((8,"violet"),1) rami;;
MultiEnsemble.equalmset rami rami3;;
let rami4 = MultiEnsemble.suppr (8,"violet") rami2;;
MultiEnsemble.equalmset rami rami4;;
