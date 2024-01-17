project_setup <- function(load_libraries = TRUE,
                          additional_libraries = NULL,
                          load_wgsn_fonts = TRUE,
                          remove_old_snowflake = TRUE,
                          set_number_format = TRUE,
                          set_wgsn_theme = TRUE){
  
  # PROJECT SETUP ----
  #
  #   * DESCRIPTION *
  #   Runs standard procedures required to start typical analysis projects.
  #
  #   * ARGUMENTS *
  #   - load_libraries: default = TRUE
  #     Set TRUE if commonly used libraries should be loaded.
  #
  #   - additional_libraries: default = NULL
  #     Allows the user to enter any non-standard libraries they would like to be loaded in the
  #     project along with the standard ones. Must be entered as a c("list", "like", "this").
  #
  #   - load_wgsn_fonts: default = TRUE
  #     Set TRUE if WGSN fonts should be imported and used.
  #
  #   - remove_old_snowflake: default = TRUE
  #     When reopening a project and data, an old and invalid Snowflake connection file may
  #     still remain causing issues. Set TRUE if file should be removed.
  #
  #   - set_number_format: default = TRUE
  #     Set TRUE if the number format that RStudio displays should be set to a more
  #     readable format rather than the default scientific notation.
  #
  #   - set_wgsn_theme: default = TRUE
  #     Set TRUE if the default ggplot theme should be set to a WGSN style one.
  #
  #   * DETAILS *
  #   Loads commonly used libraries, first checking if they are installed and installing if not.
  #   Imports WGSN branded fonts from Google, removes any Snowflake connection files that would
  #   be invalid, and sets the number format to not show in scientific notation.
  #
  #   * DEPENDENCIES *
  #   load_standard_libraries()
  #   load_wgsn_fonts()
  #   'ggplot2' library
  #
  #   * VERSION *
  #   1.0
  #   Last modified on 2024/01/15 by Joseph Earle
  # ----
  
  # Loads commonly used libraries.
  if (load_libraries == TRUE) {
    load_standard_libraries(additional_libraries = additional_libraries)
  }
  
  # Removes the old (and invalid) Snowflake connection file if still present.
  if (remove_old_snowflake == TRUE) {
    if (exists("sf_connection")) {  
      rm(sf_connection,
         envir = .GlobalEnv)
    }
  }
  
  # Loads WGSN brand fonts from Google.
  if (load_wgsn_fonts == TRUE) {
    load_wgsn_fonts()
  }
  
  # Prevents R from showing numbers in scientific notation.
  if (set_number_format == TRUE) {
    options(scipen=999)
  }
  
  # Sets the ggplot theme to a WGSN style one.
  if (set_wgsn_theme == TRUE) {
    ggplot2::theme_set(theme_wgsn())
  }
  
}
