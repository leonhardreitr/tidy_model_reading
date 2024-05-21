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
