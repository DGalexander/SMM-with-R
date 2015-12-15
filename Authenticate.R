## Call library
library(devtools)

## Install twitteR
install_github("geoffjentry/twitteR")

## Call library
library(twitteR)

## Twitter APP
require(twitteR)
api_key <- "InsertXXXX"
api_secret <- "InsertXXXX"
access_token <- "InsertXXXX"
access_token_secret <- "InsertXXXX"

## Setup Twitter APP
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
