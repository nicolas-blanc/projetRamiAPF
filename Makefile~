# PROJECT
MLIS=regle
PCMIS=$(foreach lib, $(MLIS), $(addprefix $(lib),.cmi))

LIB=MultiEnsemble Rummikub
PCMAS=$(foreach lib, $(LIB), $(addprefix $(lib),.cma))

# ENVIRONMENT
OCAMLC=ocamlc
INCLUDES=-I +lablGL
OCAMLFLAGS=$(INCLUDES)
LABLGLCMAS=lablgl.cma lablglut.cma unix.cma

# BUILD RULES
all: $(PCMAS) $(PCMIS)

%: $(PCMAS) %.ml
	$(OCAMLC) $(OCAMLFLAGS) -o $@ $(LABLGLCMAS) $+

MultiEnsemble.cma: MultiEnsemble.ml MultiEnsemble.cmi
	$(OCAMLC) $(OCAMLFLAGS) -o $@ -a $<
MultiEnsemble.cmi: MultiEnsemble.mli
	$(OCAMLC) $(OCAMLFLAGS) -c $<
MultiEnsemble.cmo: MultiEnsemble.ml
	$(OCAMLC) $(OCAMLFLAGS) -c $<

regle.cmi: regle.mli MultiEnsemble.cmi
	$(OCAMLC) $(OCAMLFLAGS) -c $<

Rummikub.cma: Rummikub.ml regle.cmi
	$(OCAMLC) $(OCAMLFLAGS) -o $@ -a $<
Rummikub.cmo: Rummikub.ml
	$(OCAMLC) $(OCAMLFLAGS) -c $<

clean:
	rm -vf $(foreach lib, $(LIB), $(addprefix $(lib),.cma .cmi .cmo))
	rm -vf $(foreach lib, $(MLIS), $(addprefix $(lib),.cmi))
mrproper: clean
	rm -vf $(DEMOS)

.PHONY: all clean mrproper
