open MultiEnsemble

let () = print_string "On passe aux multi-ensemble: \n";;
let mtest1 = MultiEnsemble.msetvide;;
let mtest1 = MultiEnsemble.ajoute ("A",3) mtest1;;
let mtest1 = MultiEnsemble.ajoute ("B",2) mtest1;;

let mtest2 = MultiEnsemble.msetvide;;
let mtest2 = MultiEnsemble.ajoute ("A",3) mtest2;;
let mtest2 = MultiEnsemble.ajoute ("B",2) mtest2;;

let rec affiche_mset (m: 't mset) = match m with
  |[]-> print_string ""
  |e::ms -> let (cha,v) = e in let () = print_int v in let () = print_string ("," ^ cha ^ "\n")  in affiche_mset ms;;

print_string ("Les msets initiaux cotiennent: \n");;
print_string ("Mset1 : \n");;
affiche_mset mtest1;;
print_string ("Mset2 : \n");;
affiche_mset mtest2;;

let repmset1 = ref "o";;
let repchoix = ref 1;;
let refmset1 = ref mtest1;;
let refmset2 = ref mtest2;;

while (!repmset1 = "o") do 
begin
  print_string "\n Dans quel mset souhaitez vous ajouter un element (1 ou 2 / 3 pour arreter): \n";
  repchoix := read_int();
if (!repchoix = 1) then (
  print_string "Ajouter un élement dans le mset (Nb exemplaire puis valeur(chaine)): \n";
  refmset1 := MultiEnsemble.ajoute ((read_line()),(read_int())) !refmset1;
  if (equalmset !refmset1 !refmset2) then (print_string " Les deux msets sont égaux.") else (print_string " Les deux msets ne sont pas égaux.");
  print_string "\n Voulez vous ajouter un autre élement (o ou n) ?: \n";
  repmset1 := read_line();)
else if(!repchoix = 2) then (
  print_string "Ajouter un élement dans le mset (Nb exemplaire puis valeur(chaine)): \n";
  refmset2 := MultiEnsemble.ajoute ((read_line()),(read_int())) !refmset2;
  if (equalmset !refmset1 !refmset2) then (print_string " Les deux msets sont égaux.") else (print_string " Les deux msets ne sont pas égaux.");
  print_string "\n Voulez vous ajouter un autre élement (o ou n) ?: \n";
  repmset1 := read_line();)
else (repmset1 := "n")
end
done;;

print_string ("Les msets contiennent désormais: \n");;
print_string ("Mtest1: \n");;
affiche_mset !refmset1;;
print_string ("Mtest2: \n");;
affiche_mset !refmset2;;

let repmset2 = ref "o";;

while (!repmset2 = "o") do 
begin
  print_string "\n Dans quel mset souhaitez vous rechercher un element (1 ou 2 / 3 pour arreter): \n";
  repchoix := read_int();
  if (!repchoix = 1) then (
  print_string "\n Rechercher un element dans le mset: \n";
  if (MultiEnsemble.appmset (read_line()) !refmset1) then print_string "\n L'element est dans le mset. \n" else 
    print_string "\n L'element n'est pas dans le mset. \n";
  print_string "\n Voulez vous rechercher un autre element (o ou n) ?: \n";
  repmset2 := read_line();)
else if(!repchoix = 2) then (
  print_string "\n Rechercher un element dans le mset: \n";
  if (MultiEnsemble.appmset (read_line()) !refmset2) then print_string "\n L'element est dans le mset. \n" else 
    print_string "\n L'element n'est pas dans le mset. \n";
    print_string "\n Voulez vous rechercher un autre element (o ou n) ?: \n";
    repmset2 := read_line();
)
else (repmset2 := "n")
end
done;;
