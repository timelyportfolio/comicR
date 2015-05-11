#' Add a comic effect to R plots and other outputs
#'
#' Sometimes less precision is better as proven by xkcd.  This function will convert
#' SVG plots from R to a comic version.
#'
#' @param selector \code{String} that represents a valid CSS selector.  If none
#'    provided then all \code{SVG} elements on the page will be cartoonized.
#' @param ff fuzz factor for line drawing: bigger -> fuzzier; 8 default
#' @param ffc fuzz factor for curve drawing: bigger -> fuzzier; 0.4 default
#' @param fsteps number of pixels per step: smaller -> fuzzier; 50 default
#' @param msteps min number of steps: bigger -> fuzzier; 4 default
#' @param width \code{integer} in px representing the width of the container.
#'   Since the container is only for convenience, this is very likely the default 0.
#' @param height \code{integer} in px representing the height of the container.
#'   Since the container is only for convenience, this is very likely the default 0.
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
