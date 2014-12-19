# Makefile
EXECUTABLES=TestFonctionnement

MODULES=regle
CMIS=$(foreach lib, $(MODULES), $(addprefix $(lib),.cmi))
MLIS=$(foreach lib, $(MODULES), $(addprefix $(lib),.mli))

LIBS=MultiEnsemble RRummikub Dictionnaire
CMOS=$(foreach lib, $(LIBS), $(addprefix $(lib),.cmo))

# ENVIRONMENT
OCAMLC=ocamlc
OCAMLP=ocamlc -pp "camlp4o.opt -unsafe"
# BUILD RULES
all: $(EXECUTABLES)

%: $(CMOS) %.cmo $(MLIS)
	$(OCAMLC) -o $@ $^


# Dependencies
MultiEnsemble.cmo: MultiEnsemble.ml MultiEnsemble.cmi
	$(OCAMLC) -c $<
MultiEnsemble.cmi: MultiEnsemble.mli
	$(OCAMLC) -c $<

Dictionnaire.cmo: Dictionnaire.ml Dictionnaire.cmi
	$(OCAMLC) -pp camlp4o.opt -unsafe -c $<
Dictionnaire.cmi: Dictionnaire.mli
	$(OCAMLC) -c $<

RRummikub.cmo: RRummikub.ml RRummikub.cmi
	$(OCAMLC) -c $<
RRummikub.cmi: RRummikub.mli MultiEnsemble.cmi regle.cmi
	$(OCAMLC) -c $<

rami.cmo: rami.ml rami.cmi
	$(OCAMLC) -c $<
rami.cmi: rami.mli MultiEnsemble.cmi regle.cmi
	$(OCAMLC) -c $<

regle.cmi: regle.mli
	$(OCAMLC) -c $<

TestFonctionnement.cmo: TestFonctionnement.ml Dictionnaire.cmi
	$(OCAMLC) -c $<

# CLEANING RULES
clean:
	rm -f $(foreach lib, $(MODULES), $(addprefix $(lib),.cmi))
	rm -f $(foreach lib, $(LIBS), $(addprefix $(lib),.cma .cmi .cmo))
	rm -f $(foreach lib, $(EXECUTABLES), $(addprefix $(lib),.cma .cmi .cmo))

mrproper: clean
	rm -f $(EXECUTABLES)

.PHONY: all clean mrproper

