COMMIT ?= $(shell bash -c 'read -p "Commit Message: " commit; echo $$commit')

backup:
	# rm -rf docs/libs;\
	# sed -i 's/pdf/gh-pages/g' _bookdown.yml;\
	# sed -i 's/colorlinks: false/colorlinks: true/g' index.Rmd;\
	Rscript -e 'library(bookdown); render_book()'
	# sed -i 's/Chalkduster/Comic Sans MS/g' gh-pages/related-tools.html

bs4:
	Rscript -e 'library(bookdown); render_book()'
	rm tikz*log

clean:
	Rscript -e 'bookdown::clean_book()';\
	rm -rf _bookdown_files
	 rm -f tikz*log
	 rm -f tikz*aux

publish:
	cd docs;\
	git add .;\
	git commit -m '$(COMMIT)';\
	git push
	make clean
