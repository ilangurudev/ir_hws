pacman::p_load(tidyverse, rebus)


all_trains <- 
  map(1:5, function(x){
    read_delim(str_c("data_science/ir_hws/hw1/MQ2008/Fold",x,"/train.txt"), delim = " ", col_names = F)
  })

add_noise_column <- function(df, n_x, std = 0.1){
  col_name <- str_c("X", n_x)
  col_vals <- df[[col_name]]
  col_index <- col_vals %>% str_extract(START %R% one_or_more(DGT))
  col_vals <- col_vals %>% str_replace(START %R% col_index, "") %>% str_replace(":", "") %>% as.numeric()
  col_vals <- abs(col_vals + rnorm(length(col_vals), 0, std))
  col_vals <- str_c(col_index,":",col_vals)
  df[[col_name]] <- col_vals
  df
}

add_noise_cols <- function(df, n_xs){
  for(i in n_xs){
    df <- add_noise_column(df, i)
  }
  df
}

#change the seed to get a different noise level
set.seed(1)

n_xs <- sample(c(3:48,54,57), 10)

dfs_noise <- 
  map(all_trains, function(df){
    add_noise_cols(df, n_xs)
  })


dfs_noise[[1]] %>% write_delim("x.txt", col_names = F)
