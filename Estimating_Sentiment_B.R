require(sentiment)
require(devtools)

library(sentiment)
## the classify_emotion function returns an object of class data.frame with 
## seven columns (anger, disgust, fear, joy, sadness, surprise, best_fit) and 
## one row for each document:
PDNP_TweetsClassEmo = classify_emotion(PDNP_TweetsCleaned, algorithm="bayes", prior=1.0)


## we will fetch emotion category best_fit for our analysis purposes
PDNPEmotion = PDNP_TweetsClassEmo[,7]

## Replace NA's by word "unknown"
PDNPEmotion[is.na(PDNPEmotion)] = "unknown"

## Similar to above, we will classify polarity 
PDNP_TweetsClassPol = classify_polarity(PDNP_TweetsCleaned, algorithm="bayes")

## we will fetch polarity category best_fit for our analysis purposes
PDNPPol = PDNP_TweetsClassPol[,4]

## Let us now create a data frame with the above results
PDNPSentimentDataFrame = data.frame(text=PDNP_TweetsCleaned, emotion=PDNPEmotion, polarity=PDNPPol, stringsAsFactors=FALSE)

## rearrange data inside the frame by sorting it
PDNPSentimentDataFrame = within(PDNPSentimentDataFrame, emotion <- factor(emotion, levels=names(sort(table(emotion), decreasing=TRUE))))

## Plot sentiment analysis
plotSentiments1 <- function (sentiment_dataframe,title) {
        require(ggplot2)
        ggplot(sentiment_dataframe, aes(x=emotion)) + geom_bar(aes(y=..count.., fill=emotion)) +
                scale_fill_brewer(palette="Dark2") +
                ggtitle(title) +
                theme(legend.position='right') + ylab('Number of Tweets') + xlab('Emotion Categories')
}

plotSentiments1(PDNPSentimentDataFrame, 'Sentiment Analysis of Tweets on Twitter about #peakdistrict')

## Similary we will plot distribution of polarity in the tweets
library(ggplot2)
plotSentiments2 <- function (sentiment_dataframe,title) {
        require(ggplot2)
        ggplot(sentiment_dataframe, aes(x=polarity)) +
                geom_bar(aes(y=..count.., fill=polarity)) +
                scale_fill_brewer(palette="RdGy") +
                ggtitle(title) +
                theme(legend.position='right') + ylab('Number of Tweets') + xlab('Polarity Categories')
}

plotSentiments2(PDNPSentimentDataFrame, 'Polarity Analysis of Tweets on Twitter about #peakdistrict')

## Wordcloud
removeCustomeWords <- function (TweetsCleaned) {
        for(i in 1:length(TweetsCleaned)){
                TweetsCleaned[i] <- tryCatch({
                        TweetsCleaned[i] =  removeWords(TweetsCleaned[i], c(stopwords("english"), "care", "guys", "can", "dis", "didn", "guy" ,"booked", "plz"))
                        TweetsCleaned[i]
                }, error=function(cond) {
                        TweetsCleaned[i]
                }, warning=function(cond) {
                        TweetsCleaned[i]
                })  
        }
        return(TweetsCleaned)
}

getWordCloud <- function (sentiment_dataframe, TweetsCleaned, Emotion) {
        emos = levels(factor(sentiment_dataframe$emotion))
        n_emos = length(emos)
        emo.docs = rep("", n_emos)
        TweetsCleaned = removeCustomeWords(TweetsCleaned)
        
        for (i in 1:n_emos){
                emo.docs[i] = paste(TweetsCleaned[Emotion == emos[i]], collapse=" ")
        }
        corpus = Corpus(VectorSource(emo.docs))
        tdm = TermDocumentMatrix(corpus)
        tdm = as.matrix(tdm)
        colnames(tdm) = emos
        require(wordcloud)
        suppressWarnings(comparison.cloud(tdm, colors = brewer.pal(n_emos, "Dark2"),  scale = c(3,.5), random.order = FALSE, title.size = 1.5))
}

getWordCloud(PDNPSentimentDataFrame, PDNP_TweetsCleaned, PDNPEmotion)

