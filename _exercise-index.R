# Pre-render: index of exercise numbers, used by ems.lua to label back links
# ("back to exercise 3.2"). Quarto numbers exercises by chapter; chapters
# marked {.unnumbered} take no number.
yml <- readLines("_quarto.yml")
stop_at <- grep("^\\s*appendices:", yml)[1]
files <- sub("^\\s*-\\s*", "", grep("^\\s*-\\s*[^ ]+\\.qmd\\s*$", yml[seq_len(stop_at - 1)], value = TRUE))
files <- trimws(files)
out <- character()
chap <- 0
for (f in files) {
  lines <- readLines(f, warn = FALSE)
  h1 <- grep("^# ", lines, value = TRUE)[1]
  if (!is.na(h1) && grepl("\\.unnumbered|\\{-", h1)) next
  chap <- chap + 1
  ids <- sub("^::: \\{#(exr-[A-Za-z0-9_-]+).*$", "\\1", grep("^::: \\{#exr-", lines, value = TRUE))
  if (length(ids)) out <- c(out, paste(ids, sub("\\.qmd$", ".html", f), paste0(chap, ".", seq_along(ids)), sep = "\t"))
}
writeLines(out, "_exercise-index.tsv")
