load_standard_libraries <- function(additional_libraries = NULL){
  
  # LOAD STANDARD LIBRARIES ----
  #
  #   * DESCRIPTION *
  #   Runs standard procedures required to start typical analysis projects.
  #
  #   * ARGUMENTS *
  #   - additional_libraries: default = NULL
  #     Allows the user to enter any non-standard libraries they would like to be loaded in the
  #     project along with the standard ones. Must be entered as a c("list", "like", "this").
  #
  #   * DETAILS *
  #   Loads commonly used libraries, first checking if they are installed and installing if not.
  #   Also allows the user to add any of their own project specific packages to be loaded each
  #   time the function runs.
  #   A list of the standard libraries and their purposes can be found below.
  #
  #   * DEPENDENCIES *
  #   None
  #
  #   * VERSION *
  #   1.0
  #   Last modified on 2024/01/15 by Joseph Earle
  # ----
  
  # STANDARD LIBRARIES AND PURPOSES ----
  #
  # - GT
  # To created nice looking data tables in markdown files.
  #
  # - TIDYVERSE
  # A suite of the most commonly used analysis functions, dplyr and ggplot2 for example.
  #
  # - DBPLYR
  # To work with external databases.
  #
  # - LUBRIDATE
  # For working with dates and times.
  #
  # - GGALLY
  # An extension of other tools to use with the ggplot2 package.
  #
  # - GGALT
  # An extension of other tools to use with the ggplot2 package.
  #
  # - BEEPR
  # Makes a ding noise when run, useful for putting at end of long scripts to 
  # be notified when finished running.
  #
  # - GGPUBR
  # An extension of other tools to use with the ggplot2 package.
  #
  # - GGTEXT
  # ggplot2 extension for manipulation of text within charts.
  #
  # - TIDYTEXT
  # To work with text based data.
  #
  # - GGREPEL
  # Makes ggplot2 labels more flexible and legible when charts are cluttered.
  #
  # - GGFITTEXT
  # Makes ggplot2 text labels grow or shrink dynamically to fit within certain boundaries.
  #
  # - GGRIDGES
  # Plots ridge line ggplot2 charts.
  #
  # - DATA.TABLE
  # Functions for working with data frames.
  #
  # - SCALES
  # Manipulates axis text and scales in ggplot2 charts.
  #
  # - VROOM
  # Imports CSV files over 10x faster than base R functions.
  #
  # - TM
  # For working with text, helps when creating wordclouds.
  #
  # - GGWORDCLOUD
  # Creates wordclouds but in ggplots.
  #
  # - TREEMAPIFY
  # Creates treemaps.
  #
  # - CLIPR
  # Allows to copy dataframes to clipboard.
  #
  # - READXL
  # Allows to importand write Excel files
  #
  # - GOOGLESHEETS4
  # Allows to import and write Google Sheet files
  #
  # - SHOWTEXT
  # Allows for custom fonts in ggplot2 charts.
  #
  # - GTRENDSR
  # Loads Google Trends data.
  #
  # - GGH4X
  # ggplot add-ons for additional facet and axis modifications.
  #
  # - GGRAPH & IGRAPH
  # Creates network and node charts.
  #
  # - TIDYLOG
  # Shows a log of exactly what happened whenever a code chunk is run.
  # (does not work with all functions)
  #
  # - TOKENIZERS
  # Picks out most common n length word combinations
  # ----
  
  # Sets list of standard libraries.
  standard_libraries <- c("gt", "tidyverse", "dbplyr", "lubridate", "GGally", "ggalt", 
                          "ggpubr", "ggtext", "tidytext", "ggrepel", "ggfittext", 
                          "ggridges", "data.table", "scales", "vroom", "tm", "ggwordcloud", 
                          "beepr", "treemapify", "clipr", "readxl", "googlesheets4", "showtext", 
                          "gtrendsR", "ggh4x", "ggraph", "igraph", "tidylog", "tokenizers")
  
  # Creates a full list of libraries to load by combining the standard ones
  # and the additional ones, if any.
  library_list <- c(standard_libraries, additional_libraries)
  
  # Loops through each package. Checks if the package is installed and installs
  # it if not. Then loads it to the project session.
  for (package in library_list) {
    
    if (!require(package, character.only = TRUE, quietly = TRUE)) {
      
      install.packages(package)
      library(package, character.only = TRUE)
      
    }
    
  }
  
  message(paste0("The following libraries have been loaded: ", paste0("'", library_list, "'", collapse = ", "), "."))

}
