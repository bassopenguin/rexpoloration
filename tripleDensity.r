# Load the packages
library("config") # load the config library
library("ggplot2") # load the plot library

# load the configuration
config <- config::get()

# set the file
thefile <- config$file
thetitle <- paste(thefile, config$title, sep = " ")
current <- config$current # appears green
originalcb <- config$originalcb # appears blue
shares <- config$shares # can't be zero
costbasis <- (originalcb + current) / shares # appears red

# Read the data
data <- read.table(thefile, h = TRUE, sep = ",")

# Set periods for box plots
short <- config$short
medium <- config$medium
long <- config$long

# Set the fundamental data
dataset <- config$dataset

# Read data subsets 
slows <- head(dataset, short)
mlows <- head(dataset, medium)
llows <- head(dataset, long)

# Make data subsets frames
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

# Print the result box plots
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