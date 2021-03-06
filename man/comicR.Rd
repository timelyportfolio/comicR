% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/comicR.R
\name{comicR}
\alias{comicR}
\title{Add a comic effect to R plots and other outputs}
\usage{
comicR(selector = NULL, ff = NULL, ffc = NULL, fsteps = NULL,
  msteps = NULL, width = 0, height = 0)
}
\arguments{
\item{selector}{\code{String} that represents a valid CSS selector.  If none
provided then all \code{SVG} elements on the page will be cartoonized.}

\item{ff}{fuzz factor for line drawing: bigger -> fuzzier; 8 default}

\item{ffc}{fuzz factor for curve drawing: bigger -> fuzzier; 0.4 default}

\item{fsteps}{number of pixels per step: smaller -> fuzzier; 50 default}

\item{msteps}{min number of steps: bigger -> fuzzier; 4 default}

\item{width}{\code{integer} in px representing the width of the container.
Since the container is only for convenience, this is very likely the default 0.}

\item{height}{\code{integer} in px representing the height of the container.
  Since the container is only for convenience, this is very likely the default 0.}
}
\description{
Sometimes less precision is better as proven by xkcd.  This function will convert
SVG plots from R to a comic version.
}

