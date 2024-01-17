load_wgsn_fonts <- function(){

  # LOAD WGSN FONTS ----
  #
  #   * DESCRIPTION *
  #   Imports the standard WGSN fonts that can then be used in ggplots.
  #
  #   * ARGUMENTS *
  #   None.
  #
  #   * DETAILS *
  #   Checks if the 'showtext' package is installed and loaded, installs and loads if not,
  #   then downloads the WGSN fonts from Google Fonts and loads them into the project.
  #   The user can then use these in ggplots by setting the default WGSN ggplot theme.
  #
  #   * DEPENDENCIES *
  #   None.
  #
  #   * VERSION *
  #   1.0
  #   Last modified on 2024/01/15 by Joseph Earle
  # ----
  
  # Check if showtext package is installed and loaded.
  if (!require("showtext", character.only = TRUE, quietly = TRUE)) {
    
    # Installs and loads it if not.
    install.packages("showtext")
    library("showtext", character.only = TRUE)
    
  }
  
  # Sets showtext as font rendered for ggplots.
  showtext_auto() 
  
  # Loads WGSN fonts from Google Fonts.
  font_add_google("DM Sans", family = "dm")
  font_add_google("Source Serif Pro", family = "source")
  font_add_google("Noto Sans", family = "noto")
  
  message("The fonts 'DM Sans', 'Source Serif Pro', and 'Noto Sans' have been successfully imported and can be used in ggplots by referencing their family names 'dm', 'source', or 'noto'.")
  
}
