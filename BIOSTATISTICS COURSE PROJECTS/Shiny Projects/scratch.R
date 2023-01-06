# Import libraries
library(shiny)
library(shinythemes)
library(data.table)
library(RCurl)
library(randomForest)

# Read data
dna <- read.csv(text = getURL("https://raw.githubusercontent.com/fabzy4L/RStudioDataAnalysis/Main/DNA/AlvarezPrimo_MyHeritage_Raw_DNA.csv") )
