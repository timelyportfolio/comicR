library(comicR)
library(htmltools)
library(SVGAnnotation)
library(XML)
library(extrafont)
library(pipeR)


browsable(
  tagList(
    tags$div(
      id = "comic_noconfig"
      ,tags$h3( "comicR with defaults" )
      ,HTML(
        saveXML(
          svgPlot({plot(1:10, type = "b", bty = "l", col="paleturquoise3")}, height=4, width = 6)
        )
      )
    )
    ,comicR( "#comic_noconfig" )
    ,tags$div(
      id = "comic_withconfig"
      ,tags$h3( "comicR with ff config = 3" )
      ,HTML(
        #  handle glyph id conflicts
        gsub(
          x = saveXML(
            svgPlot({plot(1:10, type = "b", bty = "l", col="plum3")}, height=4, width = 6)
          )
          , pattern = "glyph"
          , replacement = "svg2-glyph"
        )
      )
    )
    ,comicR( "#comic_withconfig", ff = 3 )
    ,tags$div(
      id = "justr"
      ,tags$h3( "straight from R" )
      ,HTML(
        #  handle glyph id conflicts
        gsub(
          x = saveXML(
            svgPlot(
              {
                plot(1:10, type = "b", bty = "l", col="violetred3"
                 , family = "Permanent Marker" # use Permanent Marker font from Google Fonts
                 , lty = 2, lwd = 2            # darker and dashed lines look more comic like to me
                )
              }
              , height=4, width = 6
            )
          )
          , pattern = "glyph"
          , replacement = "svg3-glyph"
        )
      )
    )
    ,tags$div(
      id = "justr-withcomic"
      ,tags$h3( "straight from R + comicR" )
      ,HTML(
        #  handle glyph id conflicts
        gsub(
          x = saveXML(
            svgPlot(
              {
                plot(1:10, type = "b", bty = "l", col="chocolate3"
                     , family = "Permanent Marker" # use Permanent Marker font from Google Fonts
                     , lty = 2, lwd = 2            # darker and dashed lines look more comic like to me
                )
              }
              , height=4, width = 6
            )
          )
          , pattern = "glyph"
          , replacement = "svg4-glyph"
        )
      )
    )
    ,comicR( "#justr-withcomic", ff = 5 )
  )
)

library(lattice)

dev.new( height = 10, width = 10, noRStudioGD = T )
dev.set(which = tail(dev.list(),1))
dotplot(variety ~ yield | year * site, data=barley)
dot_svg <- grid.export(name="")$svg
dev.off()

browsable(
  tagList(
    tags$div(
      id = "lattice-comic"
      tags$h3("lattice plot with comicR and Google font")
      ,HTML(saveXML(addCSS(
        dot_svg
        , I("text { font-family : Architects Daughter; }")
      )))
    )
    ,comicR( "#lattice-comic", ff = 5 )
  )
) %>>%
  attachDependencies(list(
    htmlDependency(
      name = "ArchitectsDaughter"
      ,version = "0.1"
      ,src = c(href='http://fonts.googleapis.com/css?family=Architects+Daughter')
      ,stylesheet = ""
    )
  ))


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

