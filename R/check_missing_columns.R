check_missing_columns <- function(data,
                                  cols) {
  
  # CHECK MISSING COLUMNS ----
  #
  #   * DESCRIPTION *
  #   Takes a data frame and a list of columns and checks if all the columns are present.
  #
  #   * ARGUMENTS *
  #   - data:
  #     The data frame.
  #
  #   - cols:
  #     The list of columns to check for.
  #
  #   * DETAILS *
  #   Takes a data frame and a list of columns and checks if all the columns are present.
  #
  #   * DEPENDENCIES *
  #   None
  #
  #   * VERSION *
  #   1.0
  #   Last modified on 2024/01/16 by Joseph Earle
  # ----
  
  missing_cols <- NULL
  for (col in cols) {
    if (!col %in% names(data)) {
      missing_cols <- c(missing_cols, col)
    }
  }
  
  if (!is.null(missing_cols)) {
    stop(paste0("The following specified columns are missing in the data: ", paste0("'", missing_cols, "'", collapse = ', '), ".\nPlease check the names are correct and try again."))
  }
  
}
