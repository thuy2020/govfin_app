library(shiny)
library(shinyBS)
library(echarts4r)
library(shinycssloaders)
library(shinyWidgets)
show_col_types = FALSE
options(scipen = 999)
pacman::p_load(tidyverse, plotly, janitor, rgeos, ggrepel, ggplot2, dplyr, DT, patchwork,
               readr, forcats, broom, geojsonio, RColorBrewer, wesanderson,networkD3, 
               cowplot, stringr, ggbump, hablar)

source("utilities/utilities.R")
options(spinner.color = "#ff6633", spinner.size = 1, spinner.type = 8)

acfrs <- readRDS("data/data_from_dbsite.RDS")
state_gov_ranking <- read_csv("data/state_gov_ranking.csv")
state_gov <- read_csv("data/state_gov.csv")

source("modules/mod_home.R")
source("modules/mod_government_types.R")
source("modules/mod_entities.R")
source("modules/mod_entities_download_data.R")
source("modules/mod_about.R")