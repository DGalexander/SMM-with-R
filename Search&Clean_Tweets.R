## Search for #peakdistrict tweets (n=2000)
PDNP_Tweets = searchTwitter("peakdistrict", n=2000, lang="en")

## Clean RT Data
PDNP_Tweets = sapply(PDNP_Tweets, function(x) x$getText())

## Apply function(x) gargvikram07/SMMR_Twitter/blob/master/cleanTweets.R
catch.error = function(x)
{
        # let us create a missing value for test purpose
        y = NA
        # try to catch that error (NA) we just created
        catch_error = tryCatch(tolower(x), error=function(e) e)
        # if not an error
        if (!inherits(catch_error, "error"))
                y = tolower(x)
        # check result if error exists, otherwise the function works fine.
        return(y)
}

cleanTweets <- function(tweet){
        # Clean the tweet for sentiment analysis
        #  remove html links, which are not required for sentiment analysis
        tweet = gsub("(f|ht)(tp)(s?)(://)(.*)[.|/](.*)", " ", tweet)
        # First we will remove retweet entities from the stored tweets (text)
        tweet = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", " ", tweet)
        # Then remove all "#Hashtag"
        tweet = gsub("#\\w+", " ", tweet)
        # Then remove all "@people"
        tweet = gsub("@\\w+", " ", tweet)
        # Then remove all the punctuation
        tweet = gsub("[[:punct:]]", " ", tweet)
        # Then remove numbers, we need only text for analytics
        tweet = gsub("[[:digit:]]", " ", tweet)
        # finally, we remove unnecessary spaces (white spaces, tabs etc)
        tweet = gsub("[ \t]{2,}", " ", tweet)
        tweet = gsub("^\\s+|\\s+$", "", tweet)
        # if anything else, you feel, should be removed, you can. For example "slang words" etc using the above function and methods.
        # Next we'll convert all the word in lowar case. This makes uniform pattern.
        tweet = catch.error(tweet)
        tweet
}

cleanTweetsAndRemoveNAs <- function (Tweets) {
        TweetsCleaned = sapply(Tweets, cleanTweets)
        TweetsCleaned = TweetsCleaned[!is.na(TweetsCleaned)]
        names(TweetsCleaned) = NULL
        TweetsCleaned = unique(TweetsCleaned)
        TweetsCleaned
}

PDNP_TweetsCleaned = cleanTweetsAndRemoveNAs(PDNP_Tweets)