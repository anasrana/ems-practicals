# ET Book

Self-hosted copy of ET Book (Dmitry Krasny, Bonnie Scranton, Edward Tufte), MIT licence (see `LICENSE`).

Source: <https://github.com/edwardtufte/et-book>, commit `24d3a3b` (2019-07-26), from the `et-book-ligatures-enabled/` folder, renamed:

| File | Original |
|---|---|
| `et-book-roman.woff2` | `et-book-roman-old-style-figures/etbookot-roman-webfont.woff2` |
| `et-book-italic.woff2` | `et-book-display-italic-old-style-figures/etbookot-italic-webfont.woff2` |
| `et-book-bold.woff2` | `et-book-bold-line-figures/etbookot-bold-webfont.woff2` |

These are the same three faces Tufte CSS uses.

## Desktop versions (for R plots and PDF)

R graphics devices and XeLaTeX cannot read `.woff2`, so the OpenType files from the same folder of the same commit are included for plots and PDF output. They are not used by the web pages.

| File | Original |
|---|---|
| `et-book-roman.otf` | `et-book-ligatures-enabled/et-book-roman-old-style-figures/ETBookOT-Roman.otf` |
| `et-book-italic.otf` | `et-book-ligatures-enabled/et-book-display-italic-old-style-figures/ETBookOT-Italic.otf` |
| `et-book-bold.otf` | `et-book-ligatures-enabled/et-book-bold-line-figures/ETBookOT-Bold.otf` |
