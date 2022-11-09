# Title: Scraping "The Simpsons" Episode Ids
# Description: Harvesting transcript episode ids
# Inputs: 
# The Simpsons Transcripts (from Forever Dreaming Transcripts website) 
# - https://transcripts.foreverdreaming.org/viewforum.php?f=431
# Output:
# - text file: episode_ids.txt
# this file contains all episode ids, i.e. the last 5 digits of the
# URLs having the following form:
# https://transcripts.foreverdreaming.org/viewtopic.php?f=431&t=21861
#
# Author: Gaston Sanchez


# packages
library(tidyverse)
library(rvest)


# --------------------------------------------------
# Pagination links (containing list of episode urls)
# (pages have the following URL form)
# --------------------------------------------------
# https://transcripts.foreverdreaming.org/viewforum.php?f=431&start=25
# https://transcripts.foreverdreaming.org/viewforum.php?f=431&start=50
# https://transcripts.foreverdreaming.org/viewforum.php?f=431&start=75
# ...
# https://transcripts.foreverdreaming.org/viewforum.php?f=431&start=725


# URL root of "The Simpsons Transcripts"
base_url = "https://transcripts.foreverdreaming.org/"

# paginator url (first page contains 25 episode links)
page_url = "viewforum.php?f=431"

# paginator sequence: 25, 50, 70, ..., 725
pages = seq(from = 25, to = 725, by = 25)


# we need to visit each page
# and then extract all episode links

# we start with the first page
page_link = paste0(base_url, page_url)
webpage = read_html(page_link)

episode_hrefs = webpage %>% 
  html_nodes(xpath = '//h3/a[@href]') %>%
  html_attr("href")

# episode id links
episode_id_hrefs = str_extract(episode_hrefs[-1], ".*(?=&sid)")


# after first page, continue with rest of pages
for (p in seq_along(pages)) {
  page_link = paste0(base_url, page_url, "&start=", pages[p])
  webpage = read_html(page_link)
  episode_hrefs = webpage %>% 
    html_nodes(xpath = '//h3/a[@href]') %>%
    html_attr("href")
  aux_hrefs = str_extract(episode_hrefs[-1], ".*(?=&sid)")
  episode_id_hrefs = c(episode_id_hrefs, aux_hrefs)
  
  # random sleep time before next html request
  # (for webscraping politeness) 
  Sys.sleep(runif(1, 2, 4))
}

# export list of episode id's to text file
epi_ids = str_extract(episode_id_hrefs, "\\d+$")
writeLines(epi_ids, "../data/episode_ids.txt")
