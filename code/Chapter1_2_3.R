# since the first three chapters are all not super deep,
# I decided to have them all in one file

# packages
library(tidyverse)
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

