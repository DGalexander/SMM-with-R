## Set the Working Directory
setwd("C:/Users/David Alexander/Documents/R Projects/SMM")

## Install and load packaged
source("InstallAndLoadAllPackages.R")

## Run the scripts to authenticate the twitter API
source("Authenticate.R")

## Search for Tweets (n=2000) based on #... and clean the data
source("Search&Clean_Tweets.R")

## Estimate Sentiment (A) Naive algorithm
source("Estimating_Sentiment_A.R")

## Estimate Sentiment (B) 
source("Estimating_Sentiment_B.R")