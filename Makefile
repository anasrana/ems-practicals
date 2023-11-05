COMMIT ?= $(shell bash -c 'read -p "Commit Message: " commit; echo $$commit')

bs4:
	rm -rf docs/libs;\
	# sed -i 's/pdf/gh-pages/g' _bookdown.yml;\
	# sed -i 's/colorlinks: false/colorlinks: true/g' index.Rmd;\
	Rscript -e 'library(bookdown); render_book()';\
	# sed -i 's/Chalkduster/Comic Sans MS/g' gh-pages/related-tools.html

clean:
	Rscript -e 'bookdown::clean_book()';\
	rm -rf _bookdown_files
	rm tikz*log
	rm tikz*aux

publish:
	cd docs;\
	git add .;\
	git commit -m 'update';\
	git push