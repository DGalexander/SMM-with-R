## Lexicon db must be on C: drive
opinion.lexicon.pos = scan('C:/Users/David Alexander/Documents/R Projects/SMM/opinion-lexicon-English/positive-words.txt', what='character', comment.char=';')
opinion.lexicon.neg = scan('C:/Users/David Alexander/Documents/R Projects/SMM/opinion-lexicon-English/negative-words.txt', what='character', comment.char=';')

opinion.lexicon.pos = scan('opinion-lexicon-English/positive-words.txt', what='character', comment.char=';')
opinion.lexicon.neg = scan('opinion-lexicon-English/negative-words.txt', what='character', comment.char=';')

words.positive = c(opinion.lexicon.pos,'upgrade')
words.negative = c(opinion.lexicon.neg,'wait', 'waiting', 'wtf', 'cancellation')

getSentimentScore = function(sentences, words.positive, words.negative, .progress='none')
{
        require(plyr)
        require(stringr)
        
        scores = laply(sentences, function(sentence, words.positive, words.negative) {
                
                # Let first remove the Digit, Punctuation character and Control characters:
                sentence = gsub('[[:cntrl:]]', '', gsub('[[:punct:]]', '', gsub('\\d+', '', sentence)))
                
                # Then lets convert all to lower sentence case:
                sentence = tolower(sentence)
                
                # Now lets split each sentence by the space delimiter
                words = unlist(str_split(sentence, '\\s+'))
                
                # Get the boolean match of each words with the positive & negative opinion-lexicon
                pos.matches = !is.na(match(words, words.positive))
                neg.matches = !is.na(match(words, words.negative))
                
                # Now get the score as total positive sentiment minus the total negatives
                score = sum(pos.matches) - sum(neg.matches)
                
                return(score)
        }, words.positive, words.negative, .progress=.progress )
        
        # Return a data frame with respective sentence and the score
        return(data.frame(text=sentences, score=scores))
}

## Get Sentiment Score
PDNP_Tweets_Result = getSentimentScore(PDNP_TweetsCleaned, words.positive , words.negative)

## Create a histogram
hist(PDNP_Tweets_Result$score,
     main ="Histogram for #peakdistrict",
     xlab="Sentiment Score",
     breaks=c(-4, -3, -2, -1, 0, 1, 2, 3, 4))

## Mean
mean(PDNP_Tweets_Result$score, trim = 0, na.rm = TRUE)

## Standard Deviation
sd(PDNP_Tweets_Result$score, na.rm = FALSE)

