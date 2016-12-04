#' AfSIS country wholesale maize price time series with GAMM's
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
download("https://www.dropbox.com/s/pv68x94c9jfyo6z/AC_maize_prices.csv?dl=0", "AC_maize_prices.csv", mode="wb")
mprice <- read.table("AC_maize_prices.csv", header=T, sep=",")

# Generate mid-month pseudo-date
mprice$date <- as.Date(paste(mprice$year, mprice$month, "15", sep = "-"))

