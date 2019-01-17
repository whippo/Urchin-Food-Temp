###################################################################################
#                                                                                ##
# Algal Culture                                                                  ##
# Data are current as of 2019-01-15                                              ##
# Data source: Oregon Institute of Marine Biology                                ##
# R code prepared by Ross Whippo                                                 ##
# Last updated 2019-01-15                                                        ##
#                                                                                ##
###################################################################################

# SUMMARY:
# Code to visualize and analyse algal cultures grown to feed larval Strongylocentrotus
# purpuratus for Ross Whippo's winter 2019 lab rotation with Richard Emlet.

# Required Files (check that script is loading latest version):
# Algal-Culture-Log.csv

# Associated Scripts:
# None

# TO DO

###################################################################################
# TABLE OF CONTENTS                                                               #
#                                                                                 #
# RECENT CHANGES TO SCRIPT                                                        #
# LOAD PACKAGES                                                                   #
# READ IN AND PREPARE DATA                                                        #
# MANIPULATE DATA                                                                 #   
#                                                                                 #
###################################################################################

###################################################################################
# RECENT CHANGES TO SCRIPT                                                        #
###################################################################################

# 2019-01-15 Script created.

###################################################################################
# LOAD PACKAGES                                                                   #
###################################################################################

library(tidyverse)
library(ggplot2)
library(viridis)

###################################################################################
# READ IN AND PREPARE DATA                                                        #
###################################################################################

algal_culture <- read.csv("Algal-Culture-Log.csv")

str(algal_culture)

###################################################################################
# MANIPULATE DATA                                                                 #
###################################################################################

ggplot(data = algal_culture, aes(x = cultureDay, y = density)) +
  geom_hline(yintercept = 700000, color = "red") +
  geom_line(aes(color = species)) +
  geom_point() +
  facet_wrap(~cultureID) +
  #ylim(0,1700000) +
  scale_color_viridis(discrete = TRUE, option = "D", begin = 0.85, end = 0.5) +
  theme_minimal() 
  
ggplot(data = algal_culture, aes(x = cultureDay, y = density)) +
  geom_hline(yintercept = 700000, color = "red") +
  geom_smooth(aes(color = species), se = FALSE, method = "lm", formula = y ~ x + I(x^2)) +
  geom_point() +
  facet_grid(~species) +
  ylim(0,1700000) +
  scale_color_viridis(discrete = TRUE, option = "D", begin = 0.85, end = 0.5) +
  theme_minimal() 


############### SUBSECTION HERE

#####
#<<<<<<<<<<<<<<<<<<<<<<<<<<END OF SCRIPT>>>>>>>>>>>>>>>>>>>>>>>>#