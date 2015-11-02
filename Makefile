exercise.pdf:
	latexmk -pdf exercise.tex

example.pdf:
	latexmk -pdf example.tex

clean:
	latexmk -pdf -c exercise.tex
	latexmk -pdf -c example.tex

# The branch develop does not contain any generated PDF files.
# The deploy task creates a new branch master and adds the
# the generated PDF files to it. This way the PDF files are
# contained in the git for an easy access but not versioned.
deploy: exercise.pdf example.pdf
	git checkout -b master
	git add -f exercise.pdf
	git add -f example.pdf
	git commit -m "Add generated PDFs"

.PHONY: clean deploy
