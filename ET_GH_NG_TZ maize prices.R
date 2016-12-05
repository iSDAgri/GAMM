#' AfSIS country wholesale maize price time series with GAMM's
#' example data assembled from FAO (2010-2016) http://www.fao.org/giews/pricetool
#' M. Walsh, December 2016

# Required packages
# install.packages(c("downloader","itsadug","dygraphs","xts")), dependencies=TRUE)
suppressPackageStartupMessages({
  require(downloader)
  require(itsadug)
  require(xts)
  require(dygraphs)
})

# Data setup --------------------------------------------------------------
# Create a data folder in your current working directory
dir.create("Price_data", showWarnings=F)
setwd("./Price_data")

# Download 
download("https://www.dropbox.com/?s/pv68x94c9jfyo6z/AC_maize_prices.csv?dl=0", "AC_maize_prices.csv", mode="wb")
mprice <- read.table("AC_maize_prices.csv", header=T, sep=",")

# GAMMs -------------------------------------------------------------------
# country-level series
m1 <- gam(price~ CC + s(rmonth, CC, bs="fs", m=1) + s(month, CC, bs="fs", m=1, k=12), data=mprice)
summary(m1)

# market-level series
m2 <- gam(price~ market + s(rmonth, market, bs="fs", m=1) + s(month, market, bs="fs", m=1, k=12), data=mprice)
summary(m2)


