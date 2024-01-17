clean_yimian_social_posts <- function(data,
                                      content_col = "content",
                                      keep_original = TRUE,
                                      to_lowercase = TRUE,
                                      strip_linebreaks = TRUE,
                                      strip_mentions = TRUE,
                                      strip_hashtags = FALSE,
                                      strip_links = TRUE,
                                      strip_non_alphanumeric = TRUE,
                                      check_missing_col = TRUE) {
  
  # CLEAN YIMIAN SOCIAL POSTS ----
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
  #   "rlang" library
  #   "dplyr" library
  #   "lubridate" library
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
                          cols = content_col)
  }
  
  # Creates a duplicate of the content_col before doing any modifications.
  message(paste0("Backing up original ", content_col, " column..."))
  if (keep_original == TRUE) {
    data <- data |> 
      dplyr::mutate(!!rlang::sym(paste0("original_", content_col)) := !!rlang::sym(content_col))
  }
  
  # Adds a space at the start and end of each entry which helps with any regex
  # matching further on.
  data <- data |> 
    dplyr::mutate(!!rlang::sym(content_col) := paste0(" ", !!rlang::sym(content_col), " "))
  
  # Sets the content_col to lower case.
  if (to_lowercase == TRUE) {
    message(paste0("Converting ", content_col, " column to lower case..."))
    data <- data |> 
      dplyr::mutate(!!rlang::sym(content_col) := stringr::str_to_lower(!!rlang::sym(content_col)))
  }
  
  # Removes line breaks (\n).
  if (strip_linebreaks == TRUE) {
    message(paste0("Removing line breaks from ", content_col, " column..."))
    data <- data |> 
      dplyr::mutate(!!rlang::sym(content_col) := stringr::str_replace_all(!!rlang::sym(content_col),
                                                                          pattern = "\\\\+ ?n\\.?",
                                                                          replacement = " "))
  }
  
  # Removes mentions.
  if (strip_mentions == TRUE) {
    message(paste0("Removing mentions from ", content_col, " column..."))
    data <- data |> 
      dplyr::mutate(!!rlang::sym(content_col) := stringr::str_replace_all(!!rlang::sym(content_col),
                                                                          pattern = "@\\w+",
                                                                          replacement = " "))
  }
  
  # Removes hashtags.
  if (strip_hashtags == TRUE) {
    message(paste0("Removing hashtags from ", content_col, " column..."))
    data <- data |> 
      dplyr::mutate(!!rlang::sym(content_col) := stringr::str_replace_all(!!rlang::sym(content_col),
                                                                          pattern = "# ?\\w+",
                                                                          replacement = " "))
  }
  
  # Removes web links.
  if (strip_links == TRUE) {
    message(paste0("Removing web links from ", content_col, " column..."))
    data <- data |> 
      dplyr::mutate(!!rlang::sym(content_col) := stringr::str_replace_all(!!rlang::sym(content_col),
                                                                          pattern = "((?:https?|ftp)://\\S+|www\\.\\S+|\\b\\S+\\.\\S+(?:/\\S*)?\\b)",
                                                                          replacement = " "))
  }
  
  # Removes non alphanumeric characters.
  if (strip_non_alphanumeric == TRUE) {
    message(paste0("Removing non alphanumeric characters from ", content_col, " column..."))
    data <- data |> 
      dplyr::mutate(!!rlang::sym(content_col) := stringr::str_remove_all(!!rlang::sym(content_col),
                                                                          pattern = "([^[:alnum:][:blank:]])"))
  }
  
  # Removes multiple consecutive spaces.
  message(paste0("Removing unnecessary spaces from ", content_col, " column..."))
  data <- data |> 
    dplyr::mutate(!!rlang::sym(content_col) := stringr::str_replace_all(!!rlang::sym(content_col),
                                                                        pattern = "\\s+",
                                                                        replacement = " "))
  
  # Trims the white space at the start and end of post added at the start
  # of this function
  data <- data |> 
    dplyr::mutate(!!rlang::sym(content_col) := stringr::str_trim(!!rlang::sym(content_col),
                                                                 side = "both"))
  
}
