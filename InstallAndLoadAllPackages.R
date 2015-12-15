## Install Packages 
install.packages(c("devtools", "rjson", "bit64", "httr"))
install.packages('base64enc')
install.packages('wordcloud')
install.packages('plyr')
install.packages('ggplot2')

## Install Sentiment
install.packages("tm")
download.file("http://cran.cnr.berkeley.edu/src/contrib/Archive/Rstem/Rstem_0.4-1.tar.gz", "Rstem_0.4-1.tar.gz") 
install.packages("Rstem_0.4-1.tar.gz", repos=NULL, type="source")

download.file("http://cran.r-project.org/src/contrib/Archive/sentiment/sentiment_0.2.tar.gz", "sentiment.tar.gz")
install.packages("sentiment.tar.gz", repos=NULL, type="source")



