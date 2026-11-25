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

# ---- Light and dark versions of ggplot figures ---------------------------
# Every ggplot that a chunk prints automatically is drawn twice: as it is
# (light theme) and with the dark palette; the page shows the one matching
# the reader's light/dark mode. Only colours change (paper, text, grid and
# the default ink of geoms), so any theme tweaks made in a chapter are kept.
# Students running the same code get the normal light plot.
ems_dark <- ggplot2::theme(
  text = ggplot2::element_text(colour = "#e6e6de"),
  plot.background = ggplot2::element_rect(fill = "#151513", colour = NA),
  panel.grid.major = ggplot2::element_line(colour = "#3a3a36"),
  panel.grid.major.y = ggplot2::element_line(colour = "#3a3a36"),
  axis.text = ggplot2::element_text(colour = "#a3a39b"),
  axis.title = ggplot2::element_text(colour = "#a3a39b"),
  legend.text = ggplot2::element_text(colour = "#a3a39b"),
  strip.text = ggplot2::element_text(colour = "#e6e6de"),
  geom = ggplot2::element_geom(ink = "#e6e6de", paper = "#151513")
)

# Only recolour theme elements the plot actually shows (a plot that hides
# its axes or grid, e.g. with theme_void(), keeps them hidden).
ems_dark_for <- function(p) {
  full <- ggplot2::complete_theme(ggplot2::theme_get() + p$theme)
  keep <- Filter(function(nm) is.null(full[[nm]]) || !inherits(full[[nm]], "element_blank"), names(ems_dark))
  do.call(ggplot2::theme, unclass(ems_dark)[keep])
}

local({
  counter <- new.env()
  knit_print_ggplot <- function(x, options, ...) {
    label <- options$label
    n <- (if (is.null(counter[[label]])) 0 else counter[[label]]) + 1
    counter[[label]] <- n
    stem <- knitr::fig_path("", options, number = n)
    dir.create(dirname(stem), recursive = TRUE, showWarnings = FALSE)
    res <- (if (is.null(options$dpi)) 96 else options$dpi) *
      (if (is.null(options$fig.retina)) 1 else options$fig.retina)
    w <- options$fig.width; h <- options$fig.height
    draw <- function(file, plot) {
      ragg::agg_png(file, width = w, height = h, units = "in", res = res, background = "transparent")
      print(plot)
      grDevices::dev.off()
    }
    dark <- if (inherits(x, "patchwork")) x & ems_dark else x + ems_dark_for(x)
    draw(paste0(stem, "-light.png"), x)
    draw(paste0(stem, "-dark.png"), dark)
    width <- if (is.null(options$out.width)) "" else paste0(' width="', options$out.width, '"')
    knitr::asis_output(paste0(
      "\n\n![](", stem, "-light.png){.light-content fig-align=\"center\"", width, "}\n\n",
      "![](", stem, "-dark.png){.dark-content fig-align=\"center\"", width, "}\n\n"))
  }
  registerS3method("knit_print", "ggplot", knit_print_ggplot, envir = asNamespace("knitr"))
})
