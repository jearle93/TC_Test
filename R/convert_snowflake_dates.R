convert_snowflake_dates <- function(data,
                                    date_col){
  
  # CONVERT SNOWFLAKE DATES ----
  #
  #   * DESCRIPTION *
  #   Converts string type dates from Snowflake YYYY-MM-DD into usable date types.
  #
  #   * ARGUMENTS *
  #   - data:
  #     The data frame.
  #
  #   - clean_names: default = TRUE
  #     The column of dates to convert.
  #
  #   * DETAILS *
  #   Converts string type dates from Snowflake into usable date types. Strings must
  #   be in the format YYYY-MM-DD or YY-MM-DD.
  #
  #   * DEPENDENCIES *
  #   'dplyr' library
  #   'rlang' library
  #   'lubridate' library
  #
  #   * VERSION *
  #   1.0
  #   Last modified on 2024/01/15 by Joseph Earle
  # ----
  
  data <- data |> 
    dplyr::mutate(!!rlang::sym(date_col) := lubridate::ymd(!!rlang::sym(date_col)))
  
  return(data)
  
}
