pacman::p_load(tidyverse, rebus)

average <- read_file("results/results_.01.txt") %>% str_split("\n") %>% .[[1]] %>% .[1:5]
  

average <-
c("Zero/one-error on test set: 60.90% (61 correct, 95 incorrect, 156 total)",
  "Zero/one-error on test set: 60.51% (62 correct, 95 incorrect, 157 total)",
  "Zero/one-error on test set: 62.42% (59 correct, 98 incorrect, 157 total)",
  "Zero/one-error on test set: 67.52% (51 correct, 106 incorrect, 157 total)",
  "Zero/one-error on test set: 66.88% (52 correct, 105 incorrect, 157 total)")


average %>% str_extract(one_or_more(DGT) %R% DOT %R% one_or_more(DGT)) %>% as.numeric() %>% mean()
