# Title: Extract text of transcripts
# Description: Extract, from HTML files, the text of transcripts
# into their own text file.
# Inputs: 
# - HTML files (one file per episode)
# Outputs:
# - txt files with extracted text of transcript
# (one text file per episode)
#
# Author: Gaston Sanchez


# packages
library(tidyverse)
library(rvest)


# -------------------------------------
# helper functions
# -------------------------------------

extract_season = function(string) {
  str_extract(string, "^\\d+")
}

extract_episode = function(string) {
  str_extract(string, "(?<=\\dx)\\d+")
}

extract_title = function(string) {
  str_extract(string, "(?<=- ).*(?= - The)")
}

extract_raw_script = function(doc) {
  doc %>%
    html_nodes(xpath = '//div[@class="postbody"]/p') %>%
    html_text()
}

remove_initial_voice_name = function(string) {
  str_remove_all(string, "^\\w+(\\s?\\w+?)?:(\\s?)")
}

remove_text_in_parenthesis = function(string) {
  str_remove_all(string, "\\(.*\\)")
}

remove_text_in_brackets = function(string) {
  str_remove_all(string, "\\[.*\\]")
}

# remove any initial text before colon ":"
remove_any_colon = function(string) {
  str_remove_all(string, "^.*:(\\s?)")
}

remove_empty_lines = function(vec) {
  vec[vec != ""]
}


# -------------------------------------
# Extract text of transcripts
# -------------------------------------

html_files = dir("../html_files/")

# initialize vectors: season, episode, and title
num_files = length(html_files)
season_vec = rep("", num_files)
episode_vec = rep("", num_files)
title_vec = rep("", num_files)


# Export episode transcripts to their own txt files
for (i in seq_along(html_files)) {
  html_file = paste0("html_files/", html_files[i])
  print(html_file)
  html_doc = read_html(html_file)
  
  # extract <title> element
  title_tag = html_doc %>% 
    html_nodes(xpath = '//title') %>%
    html_text()
  
  # episode information
  season_num = extract_season(title_tag)
  episode_num = extract_episode(title_tag)
  episode_title = extract_title(title_tag)
  season_vec[i] = season_num
  episode_vec[i] = episode_num
  title_vec[i] = episode_title
  
  # cleaning raw script lines
  script_lines = extract_raw_script(html_doc)
  script_lines = remove_initial_voice_name(script_lines)
  script_lines = remove_text_in_parenthesis(script_lines)
  script_lines = remove_text_in_brackets(script_lines)
  script_lines = remove_any_colon(script_lines)
  script_lines = remove_empty_lines(script_lines)
  
  # adding back season, episode, and title
  script_lines = c(
    paste0("season: ", season_num), 
    paste0("episode: ", episode_num), 
    paste0("title: ", episode_title),
    "\n",
    script_lines)
  
  # export content to folder "transcript_files/"
  outfile = paste0(
    "../transcript_files/",
    paste0("season-", season_num, "-episode-", episode_num, ".txt")
  )
  writeLines(script_lines, outfile)
}



# ---------------------------------------------
# Export table of titles
# (we don't really need the following commands)
# ---------------------------------------------

# titles_dat = data.frame(
#   season = season_vec,
#   episode = episode_vec,
#   title = title_vec
# )
# 
# write.csv(titles_dat, file = "../episode-titles.csv", row.names = FALSE)
