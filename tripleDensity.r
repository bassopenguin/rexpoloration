# Load the packages
library("config") # load the config library
library("ggplot2") # load the plot library

# load the configuration
config <- config::get()

# set the file
thefile <- config$file
data <- read.table(thefile, h = TRUE, sep = ",") # Read the data
thetitle <- paste(thefile, config$dataset, sep = " ")
current <- config$current # appears green
currshares <- config$currshares # amount of shares purchased at current price
originalcb <- config$originalcb # appears blue
origshares <- config$origshares # amount of shares owned at originalcb (original cost basis)
costbasis <- (originalcb * origshares + current * currshares) / (origshares + currshares) # appears red


# Set periods for box plots
short <- config$short
medium <- config$medium
long <- config$long

# Set the fundamental data
dataset <- data[ ,config$dataset]

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
slabel <- paste(paste("Short", format(short, nsmall = 0), sep = "-"), format(smedian, digits = 2, nsmall = 2), sep = " $")
mlabel <- paste(paste("Medium", format(medium, nsmall = 0), sep = "-"), format(mmedian, digits = 2, nsmall = 2), sep = " $")
llabel <- paste(paste("Long", format(long, nsmall = 0), sep = "-"), format(lmedian, digits = 2, nsmall = 2), sep = " $")

# Print the result box plots
theplot <- ggplot() + 
        geom_boxplot(data = ldf, aes(x = llabel, y = llows, fill = 'Long')) +
        geom_boxplot(data = mdf, aes(x = mlabel, y = mlows, fill = 'Medium')) +
        geom_boxplot(data = sdf, aes(x = slabel, y = slows, fill = 'Short')) +
        theme(axis.title.x=element_blank(),
              axis.ticks.x=element_blank(),
              axis.title.y=element_blank()) +
        ggtitle(thetitle)
jitter <- config$jitter
if (jitter == TRUE) {
  theplot <- theplot + geom_jitter(data = ldf, aes(x = llabel, y = llows)) +
        geom_jitter(data = mdf, aes(x = mlabel, y = mlows)) +
        geom_jitter(data = sdf, aes(x = slabel, y = slows))
}
if (current > 0) {
  theplot <- theplot + geom_hline(yintercept = current, colour = 'green') +
        geom_text(aes(2,
                      current,
                      label = paste("Current", format(current, digits = 2, nsmall = 2), sep = " $"), 
                      vjust = -1))
}
if (origshares > 0) {
  theplot <- theplot +  geom_hline(yintercept = originalcb, colour = 'blue') +
    geom_text(aes(2,
                  originalcb,
                  label = paste("Original", format(originalcb, digits = 2, nsmall = 2), sep = " $"),
                  vjust = -1))
  if (currshares > 0) {
    theplot <- theplot + geom_hline(yintercept = costbasis, colour = 'red') +
      geom_text(aes(2,
                    costbasis,
                    label = paste("New", format(costbasis, digits = 2, nsmall = 2), sep = " $"),
                    vjust = -1))
  }
}
print(theplot)

# if desired, print High/Low medians for short and long periods
statslogging <- TRUE
if (statslogging == TRUE) {
  print("Short:")
  print(paste("  High", format(median(head(data$High, short)), digits = 2, nsmall = 2), sep = " $"))
  print(paste("  Low", format(median(head(data$Low, short)), digits = 2, nsmall = 2), sep = "  $"))
  print("Long:")
  print(paste("  High", format(median(head(data$High, long)), digits = 2, nsmall = 2), sep = " $"))
  print(paste("  Low", format(median(head(data$Low, long)), digits = 2, nsmall = 2), sep = "  $"))
}