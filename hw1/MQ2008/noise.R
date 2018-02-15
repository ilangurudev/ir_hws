pacman::p_load(tidyverse, rebus)

setwd("./data_science/ir_hws/hw1/MQ2008/")
std <- 10
# n_rows_frac <- .5
n_labs_frac <- .01
#change the seed to get a different rdg
set.seed(1)

all_trains <- 
  map(1:5, function(x){
    read_delim(str_c("./Fold",x,"/train.txt"), delim = " ", col_names = F)
  })

add_noise_column <- function(df, n_x, std){
  # message(str_c("Generating noise in column ", n_x))
  col_name <- str_c("X", n_x)
  col_vals <- df[[col_name]]
  col_index <- col_vals %>% str_extract(START %R% one_or_more(DGT))
  col_vals <- col_vals %>% str_replace(START %R% col_index, "") %>% str_replace(":", "") %>% as.numeric()
  col_vals <- abs(col_vals + rnorm(length(col_vals), 0, std))
  col_vals <- str_c(col_index,":",col_vals)
  df[[col_name]] <- col_vals
  df
}

add_noise_cols <- function(df, n_xs, sd){
  message(str_c("Generating noise in columns"))
  for(i in n_xs){
    df <- add_noise_column(df, i, sd)
  }
  df
}

change_labels <- function(df){
  message(str_c("Generating noise in labels"))
  ids <- sample(1:nrow(df), size = as.integer(n_labs_frac*nrow(df)))
  x1 <- df[["X1"]]
  x1[ids] <- abs(x1[ids] - sample(c(1,2), length(ids), replace = T))
  df[["X1"]] <- x1
  df
}

# change_rows <- function(df){
#   message(str_c("Generating noise in rows"))
#   ids <- sample(1:nrow(df), size = as.integer(n_rows_frac*nrow(df)))
#   df[ids, ] <- df[ids, ] %>% add_noise_cols(3:48, sd)
#   df
# }




n_xs <- sample(c(3:48,54,57), 40)

dfs_noise <- 
  map2(all_trains, 1:5, function(df,n){
    message(str_c("df no ", n))
    add_noise_cols(df, n_xs, std) %>% 
      change_labels() 
  })


walk2(dfs_noise, 1:5, function(x,y){
  filename = str_c("./Noise/Fold",y,"/train.txt")
  write_delim(x,filename, col_names = F)
})

