# Title: Download "The Simpsons" Episode HTML pages
# Description: Downloading HTML files containing transcript of episodes
# Inputs: 
# The Simpsons Transcripts (from Forever Dreaming Transcripts website) 
# - https://transcripts.foreverdreaming.org/viewforum.php?f=431
# Output:
# - HTML files downloaded to directory "html_files/"
# - The name of these files have the form: 
# - "episode-21861.html"
# - "episode-21862.html"
# - "episode-21863.html"
# - etc
#
# Author: Gaston Sanchez
  

# packages
library(tidyverse)
library(rvest)



# URL root of "The Simpsons Transcripts"
base_url = "https://transcripts.foreverdreaming.org/"

# paginator url (first page contains 25 episode links)
page_url = "viewforum.php?f=431"

# list of episode id's
episode_ids = readLines("../data/episode_ids.txt")

# eiposide sub-url
epi_topic = "viewtopic.php?f=431&t="

# assemble page-url: for instance
# https://transcripts.foreverdreaming.org/viewtopic.php?f=431&t=88295


# download html files of episodes
for (epi in seq_along(episode_ids)) {
  epi_url = paste0(base_url, epi_topic, episode_ids[epi])
  epi_html = paste0("../html_files/episode-", episode_ids[epi], ".html")
  download.file(epi_url, destfile = epi_html)

    # random sleep time before next html request
  # (for webscraping politeness) 
  Sys.sleep(runif(1, 3, 7))
}

