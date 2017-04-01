library(tm)
clinical = read.csv("clinical_trial.csv", stringsAsFactors = FALSE,  fileEncoding="latin1")

#Convert the text attributes to corpus
corpusTitle = Corpus(VectorSource(clinical$title))
corpusAbstract = Corpus(VectorSource(clinical$abstract))

#Lower case
corpusTitle = tm_map(corpusTitle, tolower)
corpusAbstract = tm_map(corpusAbstract, tolower)

corpusTitle = tm_map(corpusTitle, PlainTextDocument)
corpusAbstract = tm_map(corpusAbstract, PlainTextDocument)

#Remove punctuation
corpusTitle = tm_map(corpusTitle, removePunctuation)
corpusAbstract = tm_map(corpusAbstract, removePunctuation)

#Remove stop words
corpusTitle = tm_map(corpusTitle, removeWords, stopwords("english"))
corpusAbstract = tm_map(corpusAbstract, removeWords, stopwords("english"))

#Stemming

corpusTitle = tm_map(corpusTitle, stemDocument)
corpusAbstract = tm_map(corpusAbstract, stemDocument)

#Building dtm
corpusTitle = Corpus(VectorSource(corpusTitle))
corpusAbstract = Corpus(VectorSource(corpusAbstract))
dtmTitle = DocumentTermMatrix(corpusTitle)
dtmAbstract = DocumentTermMatrix(corpusAbstract)

#remove sparse words
dtmTitle = removeSparseTerms(dtmTitle, 0.95)
dtmAbstract = removeSparseTerms(dtmAbstract, 0.95)
dtmTitle = as.data.frame(as.matrix(dtmTitle))
dtmAbstract = as.data.frame(as.matrix(dtmAbstract))

