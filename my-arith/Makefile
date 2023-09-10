EXE_NAME = f
OBJS = support.cmo syntax.cmo parser.cmo core.cmo lexer.cmo main.cmo

# generated from other file
DEPEND += lexer.ml parser.ml

all: $(DEPEND) $(OBJS) executable

include .depend

executable: $(OBJS)
	@echo Linking $@
	ocamlc -o $(EXE_NAME) $(OBJS)

# Generate parser by using ocamlyacc
parser.ml parser.mli: parser.mly
	@rm -f parser.ml parser.mli
	ocamlyacc -v parser.mly
	@chmod -w parser.ml parser.mli

# Generate lexer by using ocamllex
lexer.ml: lexer.mll
	@rm -f lexer.ml
	ocamllex lexer.mll
	@chmod -w lexer.ml

# Compile interface
%.cmi : %.mli
	ocamlc -c $<

# Compile module
%.cmo : %.ml
	ocamlc -c $<

clean:
	rm -rf lexer.ml parser.ml parser.mli *.cmo *.cmi $(EXE_NAME)

depend:: $(DEPEND)
	ocamldep *.mli *ml > .depend