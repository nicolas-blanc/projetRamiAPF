
module Dictionnaire : TDictionnaire =
  struct
    type dico =
    | Noeud of dico array * bool
    | Feuille

    (*
     * pos : char -> int
     *
     * [pos c] Renvoie la position relation du caractère [c] dans l'alphabet.
     *)
    let pos c =
      Char.code c - Char.code 'a'

    (*
     * dico_vide : dico
     *
     * Le dictionnaire vide.
     *)
    let dico_vide () =
      Noeud ((Array.make 26 Feuille), false)

	       
    (*
     * member : string -> dico -> bool
     * 
     * [member s d] teste si [s] est dans le dictionnaire [d] ou pas.
     * [member] accepte les jokers ( * ).
     *)
    let rec member s = function
      | Feuille -> false
      | Noeud (d, b) ->
	if s = "" then
	  b
	else
	  begin
	    let s = String.lowercase s in
	    let pos_c = pos s.[0] in
	    let s2 = String.sub s 1 (String.length s - 1) in
	    if s.[0] == '*' then (* Cas du joker *)
	      Array.fold_left
		(fun b dico -> b || (member s2 dico))
		false
		d
	    else
	      member s2 d.(pos_c)
	  end

    
    (*
     * add : string -> dico -> dico
     *
     * [add s dico] ajoute la chaine de caractères [s] au dictionnaire [dico].
     *)
    let rec add s = function
      | Feuille -> assert false (* N'est pas censé arriver *)
      | Noeud (d, b) ->
	if s = "" then
	  Noeud (d, true)
	else
	  begin
	    let pos_c = pos s.[0] in
	    let s2 = String.sub s 1 (String.length s - 1) in
	    begin
	      if d.(pos_c) = Feuille then
		d.(pos_c) <- add s2 (dico_vide())
	      else
		d.(pos_c) <- (add s2 d.(pos_c))
	    end;
	    Noeud (d, b)
	  end

    (*
     * remove : string -> dico -> dico
     *
     * [remove s dico] met le neoud du mot à false -> enlève un mot au dictionnaire
    *)
    let rec remove s = function
      | Feuille -> assert false (* N'est pas censé arriver *)
      | Noeud (d, b) ->
	if s = "" then
	  Noeud (d, false)
	else
	  begin
	    let pos_c = pos s.[0] in
	    let s2 = String.sub s 1 (String.length s - 1) in
	    begin
	      if d.(pos_c) = Feuille then
		d.(pos_c) <- Feuille
	      else
		d.(pos_c) <- (remove s2 d.(pos_c))
	    end;
	    Noeud (d, b)
	  end

end


(* Test rapide *)
(*
let test = Dictionnaire.add "test" Dictionnaire.(dico_vide());;

let t = Dictionnaire.member "*oua" test

let test = Dictionnaire.add "moua" test

let t = Dictionnaire.member "moua" test

let test = Dictionnaire.remove "moua" test

let t = Dictionnaire.member "moua" test
*)
