#' Add a comic effect to R plots and other outputs
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
comicR <- function(
  selector = NULL
  , ff = NULL    # fuzz factor for line drawing: bigger -> fuzzier; 8 default
  , ffc = NULL   # fuzz factor for curve drawing: bigger -> fuzzier; 0.4 default
  , fsteps = NULL # number of pixels per step: smaller -> fuzzier; 50 default
  , msteps = NULL  # min number of steps: bigger -> fuzzier; 4 default
  , width = 0
  , height = 0
) {

  # forward options using x
  x = list(
    selector = selector
    , options = Filter(Negate(is.null),list(
      ff = ff, ffc = ffc, fsteps = fsteps, msteps = msteps
    ))
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'comicR',
    x,
    width = width,
    height = height,
    package = 'comicR'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
comicROutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'comicR', width, height, package = 'comicR')
}

#' Widget render function for use in Shiny
#'
#' @export
renderComicR <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, comicROutput, env, quoted = TRUE)
}
