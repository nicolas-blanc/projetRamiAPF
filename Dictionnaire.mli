type dico = Noeud of dico array * bool | Feuille

  (* Fonction qui creer un nouveau tableau vide
   * J'ai ajouté le type unit en entrée pour en faire une fonction qui renvoie un tableau vide, cela permet de faciliter l'ajout d'un tableau vide et est plus facile d'utilisation et de propreté que d'appeller à chaque fois Arraymake
   * Entrée : unit
   * Sortie : Un nouveau Noeud composé d'un tableau de Feuille et False
   *)
val dico_vide : unit -> dico

  (* Permet de tester si un mot est présent dans le dictionnaire en utilisant ou non des jokers pour le test du mot
   * Entrées : Le mot à chercher - Le dico dans lequel cherché le mot
   * Sortie : Retourne vrai si le mot est présent dans le dictionnaire, ou si un mot approchant avec un joker est possible dans le dictionnaire
   *)
val member : string -> dico -> bool

  (* Permet d'ajouter un nouveau mot dans le dictionnaire, il ne faut pas qu'il y ai de lettres spéciales, mais la casse est indifférente
   * Entrées : Le mot à ajouter - Le dico dans lequel l'ajouter
   * Sortie : Renvoie le dico avec le mot ajouté
   *)
val add : string -> dico -> dico

  (* Permet d'enlever un mot du dictionnaire, pas de lettres spéciales mais casse indifférente
   * Entrées : Le mot à enlever - Le dico dans lequel le mot est enlevé
   * Sortie : Renvoi le dico sans le mot
   *)
val remove : string -> dico -> dico

  (* Permet de transformer un dictionnaire en une liste ordonné selon un ordre lexicographique
   * Entrée : Le dictionnaire à transformer en liste
   * Sortie : Une liste de mot ordonné selon l'ordre lexicographique
   *)
val to_list : dico -> string list

  (* Permet de créer un dictionnaire à partir d'un flux de caractère où chaque ligne est un mot séparé par un retour à la ligne sans espace dans le flux
   * Entrée : Le flux de caractère
   * Sortie : Renvoie un dictionnaire contenant tous les mots du flux
   *)
val of_stream : char Stream.t -> dico
  
