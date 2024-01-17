snowflake_query <- function(query = NULL,
                           trendcurve_date_cutoff = lubridate::today(),
                           clean_names = TRUE,
                           odbc_name = "Snowflake_ODBC",
                           warehouse_size = "x-small",
                           trendcurve_github = "https://raw.githubusercontent.com/jearle93/TC_Test/main/TC.SQL",
                           row_limit = NULL,
                           beep = TRUE){
  
  # SNOWFLAKE QUERY ----
  #
  #   * DESCRIPTION *
  #   Allows user to connect directly to Snowflake and load data from a specified query.
  #
  #   * ARGUMENTS *
  #   - query:
  #     The SQL to be run in Snowflake. For Beyond Fashion TrendCurves, the user can
  #     enter one of 'tc_fd', 'tc_li' or 'tc_beauty' which will use the standard TrendCurve
  #     SQL query template from Github.
  #
  #   - trendcurve_date_cutoff: default = today()
  #     Only used when one of the TrendCurve options are used in the 'query' argument.
  #     Allows the user to enter a cutoff date for the data. Useful if there is a couple of
  #     weeks of data for the most recent month but the user only wants the last full month.
  #     Selected date is inclusive, so '2023-12-31' would include this date's data.
  #
  #   - clean_names: default = TRUE
  #     Converts all column names to lowercase, and replaces any spaces with an underscore.
  #
  #   - odbc_name: default = "Snowflake_ODBC"
  #     The name of the Snowflake ODBC connection file on the users computer. If this is not
  #     correct, or if the file is missing, the user will be unable to connect to Snowflake.
  #
  #   - warehouse_size: default = "x-small"
  #     The size of the warehouse running the query in Snowflake. This should be the smallest
  #     one that's practical and should only be increased if the query is too large for the
  #     current one. Size options are 'x-small', 'small', 'medium', and 'large'.
  #
  #   - trendcurve_github: default = NEEDS UPDATING
  #     A link to the standard TrendCurve SQL query that should be used in Github.
  #
  #   - row_limit:
  #     Specify a limit on the number of rows to be returned from the query. Useful when
  #     testing out a query works before running it in full.
  #
  #   - beep: default = TRUE
  #     Play a sound once the query has finished running.
  #
  #   * DETAILS *
  #   Uses an ODBC file on the users computer that has their Snowflake credentials stored
  #   and can connect directly to the server. The user can then specify a Beyond Fashion
  #   TrendCurve they would like to extract the data for, or enter their own custom SQL
  #   query. The data will then load in Snowflake and be returned as a data frame for
  #   manipulation and analysis locally on the users computer.
  #
  #   * DEPENDENCIES *
  #   Snowflake ODBC connection file
  #   'rvest' library
  #   'stringr' library
  #   'DBI' library
  #   'janitor' library
  #   'dplyr' library
  #   'scales' library
  #   'beepr' library
  #
  #   * VERSION *
  #   1.0
  #   Last modified on 2024/01/15 by Joseph Earle
  # ----
  
  # Open the connection to Snowflake.
  connect_to_snowflake(odbc_name = odbc_name,
                       warehouse_size = warehouse_size)
  
  # Get the correct Snowflake table name based on the specified TrendCurve entered by
  # the user.
  tc <- NULL
  if (query == "tc_fd") {
    tc <- "FD"
  } else if (query == "tc_li") {
    tc <- "LI"
  } else if (query == "tc_beauty") {
    tc <- "BEAUTY"
  }
  
  # If the user has selected a TrendCurve query.
  if (!is.null(tc)) {
    # Pulls the standard query from the Github repository.
    tc_sql <- rvest::read_html(trendcurve_github)
    tc_sql <- rvest::html_element(tc_sql, xpath = '/html/body')
    tc_sql <- rvest::html_text(tc_sql)
    
    # Replaces the vertical variable with the correct one.
    tc_sql <- stringr::str_replace_all(tc_sql,
                                       pattern = 'TC_VERTICAL',
                                       replacement = tc)
    
    # Adds the cutoff date.
    query <- paste0(tc_sql,
                    "AND POST_DATE <= '", trendcurve_date_cutoff, "'")
  }
  
  # If a row_limit has been entered, append to the query.
  if (!is.null(row_limit)) {
    query <- paste0(query, " LIMIT ", row_limit)
  }
  
  message("Loading query...")
  
  # Loads the data and sets to a variable.
  sf_data <- DBI::dbGetQuery(sf_connection,
                             query)
  
  # Clean column names if required.
  if (clean_names == TRUE) {
    sf_data <- janitor::clean_names(sf_data)
  }
  
  # State how many rows have been loaded.
  message(paste0(scales::comma(dplyr::pull(dplyr::count(sf_data))), " rows loaded successfully"))
  
  # Make a noise to signify completion.
  if (beep == TRUE){beepr::beep()}
  
  return(sf_data)
  
}
