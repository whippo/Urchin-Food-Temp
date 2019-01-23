###################################################################################
#                                                                                ##
# Urchin Development                                                             ##
# Data are current as of 2019-01-18                                              ##
# Data source: Oregon Institute of Marine Biology                                ##
# R code prepared by Ross Whippo                                                 ##
# Last updated 2019-01-18                                                        ##
#                                                                                ##
###################################################################################

# SUMMARY:
# Code to visualize and analyse growth patterns of larval Strongylocentrotus
# purpuratus for Ross Whippo's winter 2019 lab rotation with Richard Emlet.

# Required Files (check that script is loading latest version):
# Urchin-Temp-Food-Development.csv

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

# 2019-01-18 Script created.

###################################################################################
# LOAD PACKAGES                                                                   #
###################################################################################

library(tidyverse)
library(ggplot2)
library(viridis)

###################################################################################
# READ IN AND PREPARE DATA                                                        #
###################################################################################

devel <- read.csv("Urchin-Temp-Food-Development.csv")

str(devel)

###################################################################################
# MANIPULATE DATA                                                                 #
###################################################################################

ggplot(data = filter(devel, date != "2019-01-11"), aes(x = date, y = totalLength, fill = temperatureTreatment)) +
  geom_boxplot() +
  facet_wrap(~ foodTreatment) +
  scale_fill_viridis(discrete = TRUE, begin = 0.25, end = 0.95, option = "D")

ggplot(data = filter(devel, date != "2019-01-11"), aes(x = temperatureTreatment, y = totalLength, fill = foodTreatment)) +
  geom_boxplot() +
  scale_fill_viridis(discrete = TRUE, begin = 0.4, end = 0.7, option = "A")
  

############### SUBSECTION HERE

#####
#<<<<<<<<<<<<<<<<<<<<<<<<<<END OF SCRIPT>>>>>>>>>>>>>>>>>>>>>>>>#