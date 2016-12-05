#' AfSIS country wholesale maize price time series with GAMMs
#' example data assembled from FAO (2010-2016) http://www.fao.org/giews/pricetool
#' M. Walsh, December 2016

# Required packages
# install.packages(c("downloader","itsadug")), dependencies=TRUE)
suppressPackageStartupMessages({
  require(downloader)
  require(itsadug)
})

# Data setup --------------------------------------------------------------
# Create a data folder in your current working directory
dir.create("Price_data", showWarnings=F)
setwd("./Price_data")

# Download 
download("https://www.dropbox.com/?s/pv68x94c9jfyo6z/AC_maize_prices.csv?dl=0", "AC_maize_prices.csv", mode="wb")
mprice <- read.table("AC_maize_prices.csv", header=T, sep=",")

# GAMMs -------------------------------------------------------------------
# country-level model
m1 <- gam(price~ CC + s(rmonth, CC, bs="fs", m=12) + s(month, CC, bs="fs", m=1), data=mprice)
summary(m1)

# market-level model
m2 <- gam(price~ market + s(rmonth, market, bs="fs", m=12) + s(month, market, bs="fs", m=1), data=mprice)
summary(m2)

# country-level model adjusted for temporal correlation
mprice <- start_event(mprice, column="rmonth", event="market")
(valRho <- acf(resid(m1), plot=FALSE)$acf[2])
m3 <- gam(price~ CC + s(rmonth, CC, bs="fs", m=12) + s(month, CC, bs="fs", m=1), data=mprice,
          AR.start = mprice$start.event, rho=valRho)
summary(m3)
