
build:
	@echo "\n==== COMPILING ====\n"
	ocamlbuild ftest.native

format:
	ocp-indent --inplace src/*

edit:
	code . -n

demo: build
	@echo "\n==== EXECUTING ====\n"
	./ftest.native graphs/graph1 1 2 outfile
	@echo "\n==== RESULT ==== (content of outfile) \n"
	@cat outfile

clean:
	-rm -rf _build/
	-rm ftest.native
	-rm outfile
	-rm outfile.png

view:
	@echo "\n==== EXPORTING ====\n"
	./ftest.native graphs/graph2 1 2 outfile
	@echo "\n==== CONVERTING ====\n"
	dot -Tpng outfile > outfile.png
	@echo "\n==== PRINTING ====\n"
	eom outfile.png