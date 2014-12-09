module type multi-ensemble =
  sig
    type 't mset = ('t, int) list
    val unionmset : 't mset -> 't mset -> 't mset
    val appmset : 't -> 't mset -> bool
    val equalmset : 't mset -> 't mset -> bool
  end
