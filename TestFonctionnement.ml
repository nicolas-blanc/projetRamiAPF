open Dictionnaire
open MultiEnsemble

let dico1 = Dictionnaire.dico_vide();;

Dictionnaire.add "bonjour" dico1;;

Dictionnaire.add "salut" dico1;;

let ltest = Dictionnaire.to_list dico1;;

let rec affiche_dico (sl: string list) = match sl with
  |[]-> print_string ""
  |e::ls -> let () = print_string (e ^ "\n") in affiche_dico ls;;

print_string "Le dictionnaire initial cotient: \n";;

affiche_dico ltest;;

let repdico1 = ref "o";;

while (!repdico1 = "o") do 
begin
  print_string "\n Donnez un mot à ajouter au dictionnaire: \n";
  Dictionnaire.add (read_line()) dico1;
  print_string "\n Voulez vous ajouter un autre mot (o ou n) ?: \n";
  repdico1 := read_line();
end
done;

print_string "\n Le dico contient désormais: \n";;

let ltest = Dictionnaire.to_list dico1;;

affiche_dico ltest;;

let repdico2 = ref "o";;

while (!repdico2 = "o") do 
begin
  print_string "\n Rechercher un mot dans le dico: \n";
  if (member (read_line()) dico1) then print_string "\n Le mot est dans le dico. \n" else 
    print_string "\n Le mot n'est pas dans le dico. \n";
  print_string "\n Voulez vous rechercher un autre mot (o ou n) ?: \n";
  repdico2 := read_line();
end
done;;


print_string "On passe aux multi-ensemble: \n";;
let mtest = MultiEnsemble.msetvide;;
let mtest = MultiEnsemble.ajoute ("A",3) mtest;;
let mtest = MultiEnsemble.ajoute ("B",2) mtest;;

let rec affiche_mset (m: 't mset) = match m with
  |[]-> print_string ""
  |e::ms -> let (cha,v) = e in let () = print_int v in let () = print_string ("," ^ cha ^ "\n")  in affiche_mset ms;;

print_string ("Le mset initial cotient: \n");;
affiche_mset mtest;;

let repmset1 = ref "o";;
let refmset = ref mtest;;

while (!repmset1 = "o") do 
begin
  print_string "\n Ajouter un élement dans le mset: \n";
  refmset := MultiEnsemble.ajoute ((read_line()),(read_int())) !refmset;
  print_string "\n Voulez vous ajouter un autre élement (o ou n) ?: \n";
  repmset1 := read_line();
end
done;;

print_string ("Le mset contient désormais: \n");;
affiche_mset !refmset;;

