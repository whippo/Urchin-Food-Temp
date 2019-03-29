###################################################################################
#                                                                                ##
# Urchin Development                                                             ##
# Data are current as of 2019-03-13                                            ##
# Data source: Oregon Institute of Marine Biology                                ##
# R code prepared by Ross Whippo                                                 ##
# Last updated 2019-03-13                                                      ##
#                                                                                ##
###################################################################################

# SUMMARY:
# Code to visualize and analyse growth patterns of larval Strongylocentrotus
# purpuratus for Ross Whippo's winter 2019 lab rotation with Richard Emlet.

# Required Files (check that script is loading latest version):
# Urchin-Temp-Food-Development.csv
# Development_Qual.csv

# Associated Scripts:
# None

# TO DO

# 2019-03-13 Need to make regressions for each jar on qual figure. Calc density
#             roughly from '5mls' taken per photo op. 

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
# 2019-03-13 Added visualization of qualitative development of urchin larvae

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

qual <- read.csv("Urchin-Development/Development_Qual.csv")
str(qual)
# change values of particular observations in column
qual$Life.Stage %>%
  recode("Early Pluetus" = "Early Pluteus")
# reorder factor levels
qual$Life.Stage <- factor(qual$Life.Stage, levels = c("Extinct", "Mesenchyme Blastula", "Gastrula", "Early Pluteus", "4-Arm Pluteus", "6-Arm Pluteus", "8-Arm Pluteus", "8-Arm Pluteus – early rudiment", "8-Arm Pluteus – rudiment ", "8-Arm Pluteus – competent", "Competent Larva – with arms", "Juvenile", "Malformed Pluteus"))
levels(qual$Life.Stage)

###################################################################################
# MANIPULATE DATA                                                                 #
###################################################################################

# devel:

ggplot(data = filter(devel, date != "2019-01-11"), aes(x = date, y = totalLength, fill = temperatureTreatment)) +
  geom_boxplot() +
  facet_wrap(~ foodTreatment) +
  scale_fill_viridis(discrete = TRUE, begin = 0.25, end = 0.95, option = "D")

ggplot(data = filter(devel, date != "2019-01-11"), aes(x = temperatureTreatment, y = totalLength, fill = foodTreatment)) +
  geom_boxplot() +
  scale_fill_viridis(discrete = TRUE, begin = 0.8, end = 0.5, option = "C")
  
# qual: 
qual_devel <- qual %>%
  filter(Life.Stage != "Malformed Pluteus")
qual_devel$Num.Stage <- qual_devel$Life.Stage %>%
  recode("Extinct" = "0", "Mesenchyme Blastula" = "1", "Gastrula" = "2", "Early Pluteus" = "3", "4-Arm Pluteus" = "4", "6-Arm Pluteus" = "5", "8-Arm Pluteus" = "6", "8-Arm Pluteus – early rudiment" = "7", "8-Arm Pluteus – rudiment " = "8", "8-Arm Pluteus – competent" = "9", "Competent Larva – with arms" = "10", "Juvenile" = "11")
qual_devel$Num.Stage <- as.numeric(qual_devel$Num.Stage)
ggplot(data = qual_devel, aes(x = Culture.Day, y = Life.Stage, color = Food, fill = Food, group = Treatment)) +
  theme_classic() +
  geom_point(position = "jitter", size = 4, aes(shape = Temp)) +
  scale_shape_manual(values = c(2, 6)) +
  scale_colour_viridis(discrete = TRUE, begin = 0.8, end = 0.5, option = "C") +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 8)) +
  geom_hline(yintercept=1.5, linetype="dashed", color = "black", size=1) +
  stat_smooth(aes(Culture.Day, Num.Stage), method = loess, se = FALSE)

# geom_line(aes(group = Treatment))


############### SUBSECTION HERE

#####
#<<<<<<<<<<<<<<<<<<<<<<<<<<END OF SCRIPT>>>>>>>>>>>>>>>>>>>>>>>>#