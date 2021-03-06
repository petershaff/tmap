% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/animation_tmap.R
\name{animation_tmap}
\alias{animation_tmap}
\title{Create animation}
\usage{
animation_tmap(tm, filename = "animation.gif", width = NA, height = NA,
  delay = 40)
}
\arguments{
\item{tm}{tmap object. In order to create a series of tmap plots, which will be the frames of the animation, it is important to set nrow and ncol in \code{\link{tm_facets}}, for otherwise a small multiples plot is generated. Commonly, where one map is shown at a time, both nrow and ncol are set to 1.}

\item{filename}{filename of the video (should be a .gif or .mpg file)}

\item{width}{width of the animation file (in pixels)}

\item{height}{height of the animation file (in pixels)}

\item{delay}{delay time between images (in 1/100th of a second)}
}
\description{
Create a gif or mpeg animation from a tmap plot. The free tool ImageMagick is required.
}
\note{
Not only tmap plots are supported, but any series of R plots.
}
\examples{
\dontrun{
data(World, metro, Europe)

m1 <- tm_shape(Europe) + 
	      tm_polygons("yellow") +
	  tm_facets(along = "name")

animation_tmap(m1, filename="European countries.gif", width=800, delay=40)

m2 <- tm_shape(World) +
          tm_polygons() +
      tm_shape(metro) + 
          tm_bubbles(paste0("pop", seq(1970, 2030, by=10)), 
              border.col = "black", border.alpha = .5) +
      tm_facets(free.scales.symbol.size = FALSE, nrow=1,ncol=1) + 
      tm_format_World(scale=.5)

animation_tmap(m2, filename="World population.gif", width=1200, delay=100)
}
}
\keyword{animation}
