## FILLDTM ##

# Code chunk from R. Kyle Bocinsky "Drain your damned DEMs"
# https://rdrr.io/github/bocinsky/demdrainer/src/R/DEM_DRAIN_functions.R

fillDTM <- function(x,...) {
  gappedDEM.df <- data.frame(cbind(xyFromCell(x,1:ncell(x)),values(x)))
  names(gappedDEM.df) <- c("x", "y", "ELEVATION")
  gappedDEM.df.known <- gappedDEM.df[!is.na(gappedDEM.df$ELEVATION), ]
  gappedDEM.df.unknown <- gappedDEM.df[is.na(gappedDEM.df$ELEVATION), ]
  gappedDEM.idw.model <- gstat(id = "ELEVATION", formula = ELEVATION ~ 1, locations = ~ x + y, data = gappedDEM.df.known, nmax = 7, set = list(idp = 0.5))
  gappedDEM.df.new <- predict(gappedDEM.idw.model, newdata = gappedDEM.df.unknown)
  gappedDEM.df.new$CELL <- cellFromXY(x, as.matrix(gappedDEM.df.new[, 1:2]))
  gappedDEM.final <- x
  gappedDEM.final[gappedDEM.df.new$CELL] <- gappedDEM.df.new$ELEVATION.pred
}