# Shared set-up, run (hidden) at the top of every chapter.
options(width = 60)
stopifnot(requireNamespace("ragg", quietly = TRUE))  # figures use dev = "ragg_png"

knitr::opts_chunk$set(
  comment = "#>",
  collapse = FALSE,
  out.width = "95%",
  fig.asp = .75,
  fig.align = "center",
  dev = "ragg_png"
)

# Brand fonts for figures (desktop versions shipped with the brand extension).
local({
  f <- "_extensions/anasrana/tufte-brand/fonts/"
  systemfonts::register_font("ET Book",
    plain  = paste0(f, "et-book/et-book-roman.otf"),
    italic = paste0(f, "et-book/et-book-italic.otf"),
    bold   = paste0(f, "et-book/et-book-bold.otf"))
})

# ggplot theme matching the site: ET Book, paper background, muted axes,
# light horizontal grid only, italic axis titles. Base R plots keep R's
# defaults so they look exactly like what students get.
theme_ems <- function(mode = c("light", "dark"), base_size = 12) {
  mode <- match.arg(mode)
  pal <- if (mode == "light") {
    c(ink = "#111111", paper = "#fffff8", muted = "#5e5e5a", rule = "#d8d8cf")
  } else {
    c(ink = "#e6e6de", paper = "#151513", muted = "#a3a39b", rule = "#3a3a36")
  }
  ggplot2::theme_minimal(base_size = base_size, base_family = "ET Book") +
    ggplot2::theme(
      text = ggplot2::element_text(colour = pal[["ink"]]),
      plot.background = ggplot2::element_rect(fill = pal[["paper"]], colour = NA),
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_line(colour = pal[["rule"]], linewidth = 0.3),
      axis.text = ggplot2::element_text(colour = pal[["muted"]]),
      axis.title = ggplot2::element_text(colour = pal[["muted"]], face = "italic"),
      plot.title = ggplot2::element_text(face = "italic", hjust = 0),
      plot.title.position = "plot"
    )
}
ggplot2::theme_set(theme_ems())
