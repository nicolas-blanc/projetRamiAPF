# Makefile
EXECUTABLES=

MODULES=regle
CMIS=$(foreach lib, $(MODULES), $(addprefix $(lib),.cmi))
MLIS=$(foreach lib, $(MODULES), $(addprefix $(lib),.mli))

LIBS=MultiEnsemble RRummikub
CMOS=$(foreach lib, $(LIBS), $(addprefix $(lib),.cmo))

# ENVIRONMENT
OCAMLC=ocamlc

# BUILD RULES
all: $(LIBS)

%: $(CMOS) %.cmo $(MLIS)
	$(OCAMLC) -o $@ $^


# Dependencies
MultiEnsemble.cmo: MultiEnsemble.ml MultiEnsemble.cmi
	$(OCAMLC) -c $<
MultiEnsemble.cmi: MultiEnsemble.mli
	$(OCAMLC) -c $<

dictionnaire.cmo: dictionnaire.ml dictionnaire.cmi
	$(OCAMLC) -pp camlp4o.opt -c $<
dictionnaire.cmi: dictionnaire.mli
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


# CLEANING RULES
clean:
	rm -f $(foreach lib, $(MODULES), $(addprefix $(lib),.cmi))
	rm -f $(foreach lib, $(LIBS), $(addprefix $(lib),.cma .cmi .cmo))
	rm -f $(foreach lib, $(EXECUTABLES), $(addprefix $(lib),.cma .cmi .cmo))

mrproper: clean
	rm -f $(EXECUTABLES)

.PHONY: all clean mrproper

