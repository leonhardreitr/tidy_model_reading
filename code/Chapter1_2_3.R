# since the first three chapters are all not super deep,
# I decided to have them all in one file

# packages
library(tidyverse)
library(easystats)
library(tidymodels)
theme_set(theme_bw())

# models need to be easy to use and encourage good methodological practice

# type of models: predict, describe, infer

# I skipped most of Chapter 1 and 2 


# Chapter 3 ---------------------------------------------------------------

data(crickets, package = "modeldata")
names(crickets)

ggplot(
  data = crickets,
  mapping = aes(x = temp,
             y = rate,
             color = species,
             pch = species,
             lty = species)) + 
  geom_point(size = 2) +
  geom_smooth(method = "lm",
              se = F) +
  scale_color_manual(
    values = c("#5AA3DAFF",
               "#501802FF")
  ) +
  labs(x = "Temperature (C)", y = "Chirp Rate (per minute)")

inter_fit <- lm(rate ~ temp * species, data = crickets)
no_inter <- lm(rate ~ temp + species, data = crickets)

compare_performance(inter_fit,no_inter)


# okay reading further I suppose that the goal of tidymodels is to standardize R modelling approaches, which is nice

corr_res <- map(mtcars %>% select(-mpg), cor.test, y = mtcars$mpg)

corr_res %>% 
  # Convert each to a tidy format; `map_dfr()` stacks the data frames 
  map_dfr(tidy, .id = "predictor") %>% 
  ggplot(aes(x = fct_reorder(predictor, estimate))) + 
  geom_point(aes(y = estimate)) + 
  geom_errorbar(aes(ymin = conf.low, ymax = conf.high), width = .1) +
  labs(x = NULL, y = "Correlation with mpg")
