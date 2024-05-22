# This files includes Chapter 4 to 9 from the Tidymodels book,
# so basicly the whole "Model Basics" Section

library(tidyverse)
library(tidymodels)
library(patchwork)

tidymodels_prefer()
theme_set(theme_bw() +
            theme(
              plot.title.position = "plot"
            ))
# Housing Data

# Lets go -----------------------------------------------------------------


data(ames, package = "modeldata")
glimpse(ames)

# no log vs. log

p1 <- 
ames |> 
  ggplot(
    aes(
      x = Sale_Price
    )
  ) +
  geom_histogram(bins = 50,
                 col = "grey50") +
  ggtitle("No log")

p2 <- 
ames |> 
  ggplot(
    aes(
      x = Sale_Price
    )
  ) +
  geom_histogram(bins = 50,
                 col = "grey50") +
  scale_x_log10() +
  ggtitle("Log")
p1 / p2

ames$Sale_Price <- log10(ames$Sale_Price)



# Set the random number stream using `set.seed()` so that the results can be 
# reproduced later. 
set.seed(502)
ames_split <- initial_split(ames, prop = 0.80, strata = Sale_Price)
ames_train <- training(ames_split)
ames_test  <-  testing(ames_split)

