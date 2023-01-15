
build:
	@echo "\n==== COMPILING ====\n"
	ocamlbuild ftest.native


format:
	ocp-indent --inplace src/*

edit:
	code . -n

demo: build
	@echo "\n==== EXECUTING ====\n"
	./ftest.native graphs/graph2 1 2 outfile
	@echo "\n==== RESULT ==== (content of outfile) \n"
	@cat outfile

probleme: build
	ocamlbuild hostHackers.native
	@echo "\n==== PROBLEM ====\n"
	./hostHackers.native

betterprobleme: build
	ocamlbuild betterHostHackers.native
	@echo "\n==== PROBLEM ====\n"
	./betterHostHackers.native
	
viewprobleme:
	@echo "\n==== CONVERTING ====\n"
	dot -Tpng flowGraph > flowGraph.png
	@echo "\n==== PRINTING ====\n"
	eom flowGraph.png

d: build
	@echo "\n==== EXECUTING ====\n"
	./ftest.native graphs/graph1 1 2 outfile
	@echo "\n==== RESULT ==== (content of outfile) \n"
	@cat outfile

clean:
	-rm -rf _build/
	-rm outfile
	-rm outfile_residual
	-rm GraphInit
	-rm graphFlowOut
	-rm flowGraph
	-rm *.native
	-rm *.png

view:
	@echo "\n==== EXPORTING ====\n"
	./ftest.native graphs/graph2 1 2 outfile
	@echo "\n==== CONVERTING ====\n"
	dot -Tpng outfile > outfile.png
	@echo "\n==== PRINTING ====\n"
	eom outfile.png