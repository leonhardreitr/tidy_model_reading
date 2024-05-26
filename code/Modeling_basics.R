# This files includes Chapter 4 to 9 from the Tidymodels book,
# so basicly the whole "Model Basics" Section

library(tidyverse)
library(tidymodels)
library(patchwork)

tidymodels_prefer()
theme_set(theme_gray(base_size = 12) +
            theme(panel.grid = element_blank()))
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


# okay i now know how to create a training and test split
# yippie


  
# Fitting Models ----------------------------------------------------------
library(tidymodels)
data(ames)
ames <- mutate(ames, Sale_Price = log10(Sale_Price))

set.seed(502)
ames_split <- initial_split(ames, prop = 0.80, strata = Sale_Price)
ames_train <- training(ames_split)
ames_test  <-  testing(ames_split)

lm_model <- linear_reg() %>% set_engine("lm")


# 7. A Model Workflow -----------------------------------------------------

library(tidymodels)
data(ames)

ames <- mutate(ames, Sale_Price = log10(Sale_Price))

set.seed(502)
ames_split <- initial_split(ames, prop = 0.80, strata = Sale_Price)
ames_train <- training(ames_split)
ames_test  <-  testing(ames_split)

lm_model <- linear_reg() %>% set_engine("lm")

lm_wflow <- 
  workflow() %>% 
  add_model(lm_model) %>% 
  add_variables(outcome = Sale_Price, predictors = c(Longitude, Latitude))

lm_fit <- fit(lm_wflow, ames_train)

