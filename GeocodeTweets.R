## Search for #peakdistrict tweets (n=2000)
PDNP_Tweets = searchTwitter("peakdistrict", n=2000, lang="en")

## Create a data frame
PDNP_Tweets_df = twListToDF(PDNP_Tweets)

## extract the tweet Id of the first tweet
sapply(PDNP_Tweets, function(x) x$getLongitude())

## Write table so JT can help :)
write.csv(PDNP_Tweets_df, file = "Tweets Data Frame.csv")