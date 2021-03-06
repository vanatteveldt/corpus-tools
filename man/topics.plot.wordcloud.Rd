% Generated by roxygen2 (4.0.0): do not edit by hand
\name{topics.plot.wordcloud}
\alias{topics.plot.wordcloud}
\title{Plot wordcloud for LDA topic}
\usage{
topics.plot.wordcloud(topics, topic_nr)
}
\arguments{
\item{topics}{a matrix in which rows are topics and columns are terms. values represent how prominent the word is in a topic. This matrix can for instance be obtained from the $topics object of the output of collapsed.gibbs.sampler, or when using the topicmodels package from posterior(m)$terms (where m is or stems from the LDA class)}

\item{topic_nr}{The index of the topic (1 to K)}
}
\value{
Nothing, just plots
}
\description{
Plots a wordcloud of the top words per topic
}

