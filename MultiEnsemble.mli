    type 't mset = ('t*int) list
    val unionmset : 't mset -> 't mset -> 't mset
    val ajoute : ('t*int) -> 't mset -> 't mset
    val appmset : 't -> 't mset -> bool
    val equalmset : 't mset -> 't mset -> bool
    val suppr : 't -> 't mset -> 't mset
    val msetvide : 't mset
