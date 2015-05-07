library(comicR)
library(htmltools)
library(SVGAnnotation)
library(XML)

tf <- tempfile()
png( file = tf, height = 400, width = 600 )
  plot(1:50)
dev.off()

browsable(
  tagList(
    HTML(base64::img(tf))
    , comicR( selector = "img" )
  )
)


browsable(
  tagList(
    HTML(saveXML(svgPlot({plot(1:50)})))
    , comicR(  )
  )
)




library(SVGAnnotation)
library(XML)
library(htmltools)

library(pipeR)

library(extrafont)

#  xkcd font install instructions from R package xkcd
install_xkcd <- function(){
  download.file("http://simonsoftware.se/other/xkcd.ttf",
                dest="c://windows/fonts/xkcd.ttf", mode="wb")
  font_import(pattern = "[X/x]kcd", prompt=FALSE)
  fonts()
  fonttable()
  if(.Platform$OS.type != "unix") {
   ## Register fonts for Windows bitmap output
   loadfonts(device="win")
  } else {
   loadfonts()
  }
}
# install_xkcd()

svgPlot(
  # xkcd font does not seem to apply to text labels
  # {plot( 1:10, type = "b", pch = 5, bty = "L", lty = 3, lwd = 2, family = "xkcd")}
  {plot( 1:10, type = "b", pch = 2, bty = "L", lty = 3, lwd = 2, family = "Permanent Marker")}
  # {plot( 1:10, type = "b", pch = 2, bty = "L", lty = 3, lwd = 2, family = "Reenie Beanie", cex.axis=2, cex.lab = 2)}
  # {plot( 1:10, type = "b", pch = 5, bty = "L", lty = 3, lwd = 2, family = "Architects Daughter", font=2)}
  , height = 4
  , width = 7
) %>>%
  saveXML %>>%
  HTML %>>%
  tagList(
    tags$script("
      // forEach for array not available in RStudio Viewer
      //   could easily attach dependency to polyfill
      [].forEach.call(document.getElementsByTagName('svg'),function(s){COMIC.magic(s)})
    ")
  ) %>>%
  attachDependencies(
    htmlDependency(
      name="comic"
      ,version = "0.1"
      ,src = c(href="http://balint42.github.io/comic.js")
      ,script = "comic.min.js"
    )
  ) %>>%
  html_print


svgPlot(
  # xkcd font does not seem to apply to text labels
  # {contour( volcano, bty = "L", lty = 3, lwd = 2, family = "xkcd")}
   {contour( volcano, bty = "L", lty = 3, lwd = 2, family = "Permanent Marker")}
  # {contour( volcano, bty = "L", lty = 3, lwd = 2, family = "Architects Daughter", font=2)}
  , height = 4
  , width = 7
) %>>%
  saveXML %>>%
  HTML %>>%
  browsable




# found this R logo in SVG

#readLines("http://www.alice-dsl.net/~towolf/rlogo/Rlogo-novo.svg") %>>%
readLines("http://www.alice-dsl.net/~towolf/rlogo/Rlogo-simple.svg") %>>%
  HTML %>>%
  tagList(
    tags$script(
      "[].forEach.call(document.getElementsByTagName('svg'),function(s){
           new Vivus(s,{type: 'delayed',start:'autostart',delay:0,duration:500})
      })"
    )
  ) %>>%
  attachDependencies(
    htmlDependency(
      name="vivus"
      ,version="0.1"
      ,src=c("href"=
               "http://maxwellito.github.io/vivus/dist"
      )
      ,script = "vivus.min.js"
    )
  ) %>>%
  html_print
