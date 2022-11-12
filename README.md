# Scraping The Simpsons Transcripts

This repository contains the R scripts to scrape __The Simpsons Transcripts__, 
as well as the scraped data files, and the assemled output data file.


## Source

The source of the data is the [Forever Dreaming Transcripts](https://transcripts.foreverdreaming.org) website.

The source transcript (HTML) files for The Simpsons are available at:

<https://transcripts.foreverdreaming.org/viewforum.php?f=431&start=725>


## Description

[Scraping-The-Simpsons-Transcripts-with-R.pdf](Scraping-The-Simpsons-Transcripts-with-R.pdf)


## Data Table `simpsons-transcripts.txt`

The ultimate output of the R scripts is the file `simpsons-transcripts.txt`.
This is a field-separated file in which the field-separator is the caret 
`"^"` symbol. The content of `simpsons-transcripts.txt` is basically a data 
table with five columns:

1) `year`: number of year (in which first episode of that season's was aired)

2) `season`: number of season

3) `episode`: number of episode

4) `title`: title of episode

5) `text`: text of transcript

This data set can be used for text mining purposes.


## Filestructure

```
README.md
Scraping-The-Simpsons-Transcripts-with-R.pdf
code/
  script1-scrape-episode-ids.R
  script2-download-episode-html-files.R
  script3-extract-transcript-lines.R
  script4-assemble-output-table.R
data/
  episode-ids.txt
  simpsons-transcripts.txt
html_files/
	episode-21861.html
	episode-21862.html
	...
	episode-73358.html
transcript_files/
	season-01-episode-01.txt
	season-01-episode-02.txt
	...
	season-33-episode-22.txt
```


## Donation

As a Data Science and Statistics educator, I love to share the work I do.
Each month I spend dozens of hours curating learning materials like this resource.
If you find any value and usefulness in it, please consider making 
a <a href="https://www.paypal.com/donate?business=ZF6U7K5MW25W2&currency_code=USD" target="_blank">one-time donation---via paypal---in any amount</a> (e.g. the amount you would spend inviting me a cup of coffee or any other drink). Your support really matters.

<a href="https://www.paypal.com/donate?business=ZF6U7K5MW25W2&currency_code=USD" target="_blank"><img src="https://www.gastonsanchez.com/images/donate.png" width="140" height="60"/></a>
