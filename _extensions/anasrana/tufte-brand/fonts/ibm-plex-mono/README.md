# IBM Plex Mono

Self-hosted copy of IBM Plex Mono (IBM Corp.), SIL Open Font License 1.1 (see `LICENSE`). Used for code.

Source: the `@fontsource/ibm-plex-mono` package, version 5.2.7 (<https://github.com/fontsource/font-files>), Latin subset, renamed:

| File | Original |
|---|---|
| `ibm-plex-mono-400-normal.woff2` | `files/ibm-plex-mono-latin-400-normal.woff2` |
| `ibm-plex-mono-400-italic.woff2` | `files/ibm-plex-mono-latin-400-italic.woff2` |

The Latin subset covers ASCII and Western European characters, which is enough for code. Upstream project: <https://github.com/IBM/plex>.

## Desktop versions (for R plots and PDF)

R graphics devices and XeLaTeX cannot read `.woff2`, so IBM's official TrueType files are included, unmodified, for code in plots and PDF output. They are not used by the web pages.

| File | Original |
|---|---|
| `IBMPlexMono-Regular.ttf` | <https://github.com/IBM/plex>, commit `ba3013d`, `packages/plex-mono/fonts/complete/ttf/IBMPlexMono-Regular.ttf` |
| `IBMPlexMono-Italic.ttf` | same commit, `packages/plex-mono/fonts/complete/ttf/IBMPlexMono-Italic.ttf` |
