# Practical Exercises

[![pages-build-deployment](https://github.com/anasrana/ems-practicals/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/anasrana/ems-practicals/actions/workflows/pages/pages-build-deployment)

This repository hosts the code for practical exercises for the module Essentials of Mathematics and Statistics module taught at the University of Birmingham. You can view the online version of the exercises [here](https://anasrana.github.io/ems-practicals/).

## Building the book

The practicals are a [Quarto](https://quarto.org) book with R code. The look comes from the shared brand extension [`anasrana/quarto-aar-brand`](https://github.com/anasrana/quarto-aar-brand), installed in `_extensions/`.

Requirements: Quarto 1.11 or later, R, and a LaTeX installation with `xelatex` for the PDF. R packages are recorded with [renv](https://rstudio.github.io/renv/); run `renv::restore()` once to install them into the project library.

| Command | What it does |
|---|---|
| `make preview` | live preview while editing |
| `make render` | website and PDF into `docs/` |
| `make refresh` | re-run every chapter (after changing `_common.R` or packages) |
| `make publish` | render, commit `docs/` and `_freeze/`, push; GitHub Pages serves `docs/` on `main` |

Chapters are only re-run when their own `.qmd` changes (`freeze: auto`); results are cached in `_freeze/`. After editing shared code in `_common.R`, use `make refresh`.

Book-specific files: `_quarto.yml` (structure and formats), `_common.R` (shared R set-up, plot theme, light/dark figures), `ems.scss` (styles), `ems.lua` (exercise titles and solution links), `ems-preamble.tex` (PDF), `_exercise-index.R` (exercise numbers for back links).

