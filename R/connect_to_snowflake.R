connect_to_snowflake <- function(odbc_name = "Snowflake_ODBC",
                                 warehouse_size = "x-small"){
  
  # CONNECT TO SNOWFLAKE ----
  #
  #   * DESCRIPTION *
  #   Allows user to connect directly to Snowflake.
  #
  #   * ARGUMENTS *
  #   - odbc_name: default = "Snowflake_ODBC"
  #     The name of the Snowflake ODBC connection file on the users computer. If this is not
  #     correct, or if the file is missing, the user will be unable to connect to Snowflake.
  #
  #   - warehouse_size: default = "x-small"
  #     The size of the warehouse running the query in Snowflake. This should be the smallest
  #     one that's practical and should only be increased if the query is too large for the
  #     current one. Size options are 'x-small', 'small', 'medium', and 'large'.
  #
  #   * DETAILS *
  #   Uses an ODBC file on the users computer that has their Snowflake credentials stored
  #   and can connect directly to the server.
  #
  #   * DEPENDENCIES *
  #   Snowflake ODBC connection file
  #   'DBI' library
  #   'odbc' library
  #
  #   * VERSION *
  #   1.0
  #   Last modified on 2024/01/15 by Joseph Earle
  # ----
  
  
  # Convert the user entered warehouse size to the correct Snowflake name.
  warehouse_size <- switch(warehouse_size,
                           "x-small" = "WH_X_SMALL_WGSN_ANALYST",
                           "small" = "WH_SMALL_WGSN_ANALYST",
                           "medium" = "WH_MEDIUM_WGSN_ANALYST",
                           "large" = "WH_LARGE_WGSN_ANALYST")
  

  # Checks if the sf_connection object exists in the environment already.
  if (!exists("sf_connection")) {
    
    # Opens the connection to Snowflake.
    message("Opening a connection to Snowflake...")
    
    sf_connection <<- DBI::dbConnect(odbc::odbc(), 
                                     .connection_string = paste0("DSN=", odbc_name, 
                                                                 "; warehouse=", warehouse_size))
    
    message(paste("Snowflake connection successfully opened to a", warehouse_size, "warehouse."))
    
  } else {
    
    # If it does exist, runs a 1 row query to test whether it's still valid.
    tryCatch({ 
      DBI::dbGetQuery(sf_connection,
                      "SELECT * FROM YIMIAN.SOCIAL.YIMIAN_INSTAGRAM_FD LIMIT 1") 
      
      message("Connection to Snowflake already open")
      }
      , error = function(e) 
      # If it's no longer valid, remove it and recreate it.
      { 
        rm(sf_connection,
           envir = .GlobalEnv)

        message("Opening a connection to Snowflake...")
         
        sf_connection <<- DBI::dbConnect(odbc::odbc(), 
                                         .connection_string = paste0("DSN=", odbc_name, 
                                                                     "; warehouse=", warehouse_size))
         
        message(paste("Snowflake connection successfully opened to a", warehouse_size, "warehouse."))
      })
  }
  
}
