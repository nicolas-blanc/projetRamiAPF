(*Type de base du multi ensemble, il représente un objet présent un certains nombres de fois*)
type 't mset = ('t*int) list

(*Cette fonction réalise la fusion de deux types mset, si un élément est présent dans les 2 listes, il ne sera présent qu'une fois 
dans la liste finale, mais dans un nombre égal à la somme des deux mset précedent.
Entrées : les deux mset à fusionner.
Sortie: le mset résultant de la fusion.*)
val unionmset : 't mset -> 't mset -> 't mset

(*Fonction ajoutant un élément de type t, en n exemplaires, à un mset. Si l'élément est déja présent son nombre d'exemplaire
 est augmenté de n, sinon il est ajouté en n exemplaire au mset.
Entrées: Element t * n exemplaires et le mset auquel l'ajouté.
Sortie: Un mset contenat un nouvel élement ou dans un nombre plus élevé. *)
val ajoute : ('t*int) -> 't mset -> 't mset

(*Fonction permettant de savoir si un élément appartient à un mset. On ne s'intéresse pas au nombre d'exemplaire.
Entrées: L'élément à chercher et le mset dans lequel chercher.
Sortie: Un booléen indiquant si l'on a trouvé ou non.*)
val appmset : 't -> 't mset -> bool

(*Permet de déterminer si 2 mset sont identiques. 2 mset sont identiques s'ils possédent les mêmes éléments en nombres identiques.
Entrées: les 2 mset à comparer.
Sortie: booléen indiquant la réponse.*)
val equalmset : 't mset -> 't mset -> bool

(*Supprime totalement un element d'un mset quelque soit son nombre d'exemplaire. 
Entrées: Element à supprimer et le mset dans lequel supprimé.
Sortie: Le nouveau mset*)
val suppr_totale : 't -> 't mset -> 't mset

(*Supprime n exemplaire d'un élement dans un mset.
Entrées: Element et mset dans lequel supprimer
Sortie: le mset après suppression.*)
val suppr : ('t*int)-> 't mset -> 't mset

(*Rend un msetvide.*)
val msetvide : 't mset

(*Fait la différence entre 2 msets.*)
val diff : 't mset -> 't mset -> 't mset
