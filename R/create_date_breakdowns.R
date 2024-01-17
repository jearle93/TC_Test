create_date_rollup <- function(data,
                               date_col = "post_date",
                               week = FALSE,
                               month = TRUE,
                               quarter = TRUE,
                               year = TRUE,
                               new_column_prefix = "post_",
                               check_missing_col = TRUE) {
  
  # CREATE DATE ROLLUP ----
  #
  #   * DESCRIPTION *
  #   Takes a data frame with a date column and creates a year, quarter, month and week
  #   column from it.
  #
  #   * ARGUMENTS *
  #   - data:
  #     The data frame.
  #
  #   - date_col: default = "post_date"
  #     The column of dates to convert.
  #
  #   - week: default = FALSE
  #     Create a column with the week commencing date?
  #
  #   - month: default = TRUE
  #     Create a column with the month commencing date?
  #
  #   - quarter: default = TRUE
  #     Create a column with the quarter commencing date?
  #
  #   - year: default = TRUE
  #     Create a column with the year?
  #
  #   - new_column_prefix: default = "post_"
  #     The prefix applied to the names of the new columns created. The new month
  #     column will be called "post_month" if the default is used for example.
  #
  #   - check_missing_col: default = TRUE
  #     If TRUE, will check whether the date_col exists in the data frame before running.
  #     The option to turn off this check exists as this function is called within the
  #     trendcurve_tidy function and all the column checks are already carried out there.
  #
  #   * DETAILS *
  #   Takes a data frame with a date column and creates a year, quarter, month and week
  #   column from it. Will check that the date_col exists first, then check if it is in
  #   the right date type, converting it if not. The user can then specify what rollup(s)
  #   they want to include, along with the prefix to be applied to the new column names.
  #
  #   * DEPENDENCIES *
  #   check_missing_columns()
  #   convert_snowflake_dates()
  #   'rlang' library
  #   'dplyr' library
  #   'lubridate' library
  #
  #   * VERSION *
  #   1.0
  #   Last modified on 2024/01/16 by Joseph Earle
  # ----
  
  # Checks if the date_col is present in the data.
  # Does not run if called from the trendcurve_tidy function as
  # this step is handled within that.
  if (check_missing_col == TRUE) {
    check_missing_columns(data,
                          cols = date_col)
  }
  
  # Checks if the data_col is a date type, if not, converts it to one.
  if (sapply(data |> select(!!rlang::sym(date_col)), class) == "character") {
    data <- convert_snowflake_dates(data = data,
                                    date_col = date_col)
  }
  
  # Adds a year column.
  if (year == TRUE) {
    data <- data |> 
      dplyr::mutate(!!rlang::sym(paste0(new_column_prefix, "year")) := lubridate::year(!!rlang::sym(date_col)),
                    .after = !!rlang::sym(date_col))
  }
  
  # Adds a quarter column.
  if (quarter == TRUE) {
    data <- data |> 
      dplyr::mutate(!!rlang::sym(paste0(new_column_prefix, "quarter")) := lubridate::floor_date(!!rlang::sym(date_col),
                                                                                                unit = "quarter"),
                    .after = !!rlang::sym(date_col))
  }
  
  # Adds a month column.
  if (month == TRUE) {
    data <- data |> 
      dplyr::mutate(!!rlang::sym(paste0(new_column_prefix, "month")) := lubridate::floor_date(!!rlang::sym(date_col),
                                                                                              unit = "month"),
                    .after = !!rlang::sym(date_col))
  }
  
  # Adds a week column.
  if (week == TRUE) {
    data <- data |> 
      dplyr::mutate(!!rlang::sym(paste0(new_column_prefix, "week")) := lubridate::floor_date(!!rlang::sym(date_col),
                                                                                             unit = "week"),
                    .after = !!rlang::sym(date_col))
  }
  
  return(data)
  
}
