# EMS practicals: Quarto book. The site is served by GitHub Pages from docs/
# on main, so publishing = render, commit docs/ (and _freeze/), push.

COMMIT ?= $(shell bash -c 'read -p "Commit message: " commit; echo $$commit')

.PHONY: render html pdf refresh preview publish clean

# website and PDF into docs/ (chapters re-run only if their .qmd changed)
render:
	quarto render

html:
	quarto render --to html

pdf:
	quarto render --to pdf

# re-run every chapter, e.g. after changing _common.R or the R packages
refresh:
	rm -rf _freeze
	quarto render

# live preview while editing
preview:
	quarto preview

# render, then commit and push the built site
publish: render
	git add docs _freeze
	git commit -m '$(COMMIT)'
	git push

clean:
	rm -rf .quarto
