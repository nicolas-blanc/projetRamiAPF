    type dico = Noeud of dico array * bool | Feuille
    val dico_vide :unit -> dico
    val member : string -> dico -> bool
    val add : string -> dico -> dico
    val remove : string -> dico -> dico
    val to_list : dico -> string list
    val of_stream : char Stream.t -> dico
 
