The Document-Term Matrix (dtm)
========================================================

For many methods of text analysis, specifically the so-called bag-of-word approaches, the common data structure for the corpus is a document-term matrix (dtm). This is a matrix in which the rows represent documents and the columns represent terms (e.g., words, lemmata). The values represent how often each word occured in each document. 

For example, in this dtm we can see how often the words 'spam', 'bacon', and 'egg', occured in each of the 4 documents:

```r
m = matrix(sample(0:2, replace = T, 12), ncol = 3, dimnames = list(documents = c("doc1", 
    "doc2", "doc3", "doc4"), terms = c("spam", "bacon", "egg")))
m
```

```
##          terms
## documents spam bacon egg
##      doc1    1     1   2
##      doc2    0     0   0
##      doc3    2     1   1
##      doc4    1     0   2
```


Commonly, this matrix is very sparse. That is, a large majority of the values will be zero, since documents generally only use a small portion of the words used in the entire corpus. For efficient computing and data storage, it is therefore worthwhile to not simply use a matrix, but a type of sparse matrix. We suggest the use of the `DocumentTermMatrix` class that is available in the `tm` (text mining) package. This is a type of sparse matrix dedicated to text analysis.


```r
library(tm)
dtm = as.DocumentTermMatrix(m, weight = weightTf)
dtm
```

```
## A document-term matrix (4 documents, 3 terms)
## 
## Non-/sparse entries: 8/4
## Sparsity           : 33%
## Maximal term length: 5 
## Weighting          : term frequency (tf)
```


Since the `tm` package is quite popular, this dtm class is compatible with various packages for text analysis. For many of the functions offered in the `corpustools` package we also use this dtm class as a starting point. In the next steps of this howto we provide some pointers for importing your data and transforming it into a dtm.

Creating the Document-Term Matrix from full-text
========================================================

If your data is in common, unprocessed textual form (such as this document) then a good approach is to use the `tm` package. `tm` offers various ways to import texts to the `tm` corpus structure. Additionally, it offers various functions to pre-process the data. For instance, removing stop-words, making everything lowercase and reducing words to their stem. From the `corpus` format the texts can then easily be tokenized (i.e. cut up into terms) and made into a dtm. If this is your weapon of choice, we gladly refer to the [tm package vignette](http://cran.r-project.org/web/packages/tm/vignettes/tm.pdf).

Creating the Document-Term Matrix from tokens
========================================================

It could also be that you prefer to pre-process your data outside of R; possibly using more advanced methods such as lemmatizing and part-of-speech tagging, that (to our knowledge) are not supported well within R. For reference, an open-source software package to accommodate this process that we are affiliated with is [AmCAT](https://github.com/amcat/). 

If this is the case, then an easy and efficient way to import this data into R is as a data.frame (e.g., using csv), in which each row represents one token within a document, possibly including a value for how often the token occured in this document. This can look like this (example based on AmCAT output):


```r
load("demo_tokens_amcat.rdata")
head(tokens)
```

```
##      word pos lemma      aid pos1 freq
## 208    no  DT    no 91000046    D    1
## 160    it PRP    it 91000046    O    1
## 283 there  EX there 91000046    ?    2
## 174  like  IN  like 91000046    P    1
## 176 lived VBD  live 91000046    V    1
## 322 where WRB where 91000046    B    2
```


To our knowledge, `tm` has no functions to directly transform this data format into a `DocumentTermMatrix`, but it can quite easily be casted into a sparse matrix, and then transformed into a dtm. The `dtm.create` function, offered in the `corpustools` package, can do this for you. For our example, we use the [lemma](http://en.wikipedia.org/wiki/Lemma_(morphology)) of the words. In the `dtm.create` function we simply give the vector for the lemma, together with a vector indicating in which documents the lemma occured (aid) and how often (freq).


```r
library(corpustools)
dtm = dtm.create(documents = tokens$aid, terms = tokens$lemma, freqs = tokens$freq)
dtm
```

```
## A document-term matrix (100 documents, 358 terms)
## 
## Non-/sparse entries: 1183/34617
## Sparsity           : 97%
## Maximal term length: 13 
## Weighting          : term frequency (tf)
```


