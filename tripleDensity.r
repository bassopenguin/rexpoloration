# load the config library
library("config")

# load the configuration
config <- config::get()

# set the file
thefile <- config$file
thetitle <- paste(thefile, "Highs", sep = " ") # TODO make "Highs" configurable
current <- 0.00 # appears green TODO make configurable
originalcb <- 0.00 # appears blue TODO make configurable 
shares <- 2 # can't be zero TODO make configurable
costbasis <- (originalcb + current) / shares # appears red

# Read the data
data <- read.table(thefile, h = TRUE, sep = ",")

# Set the working directory back
setwd(oldwd)

# Load the packages
library("ggplot2")

#current <- data$Close[1]
short <- config$short
medium <- config$medium
long <- config$long

lows <- data$High
slows <- head(lows, short)
mlows <- head(lows, medium)
llows <- head(lows, long)

sdf <- data.frame(slows, vec = '1')
mdf <- data.frame(mlows, vec = '2')
ldf <- data.frame(llows, vec = '3')

# make the medians
smedian <- median(slows)
mmedian <- median(mlows)
lmedian <- median(llows)

# make the x-axis labels
slabel <- paste("Short", format(smedian, digits = 2, nsmall = 2), sep = " $")
mlabel <- paste("Medium", format(mmedian, digits = 2, nsmall = 2), sep = " $")
llabel <- paste("Long", format(lmedian, digits = 2, nsmall = 2), sep = " $")

print(ggplot() + 
        geom_boxplot(data = ldf, aes(x = llabel, y = llows, fill = 'Long')) +
        geom_boxplot(data = mdf, aes(x = mlabel, y = mlows, fill = 'Medium')) +
        geom_boxplot(data = sdf, aes(x = slabel, y = slows, fill = 'Short')) +
        geom_hline(yintercept = current, colour = 'green') +
        geom_hline(yintercept = originalcb, colour = 'blue') +
        geom_hline(yintercept = costbasis, colour = 'red') +
        theme(axis.title.x=element_blank(),
              axis.ticks.x=element_blank(),
              axis.title.y=element_blank()) +
        ggtitle(thetitle)
      )