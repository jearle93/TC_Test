create_trendcurve_factors <- function(data,
                                      factor_region = TRUE,
                                      factor_stage = TRUE,
                                      region_col = "region",
                                      stage_col = "stage",
                                      region_list = c("APAC", "EU", "LATAM", "NAM", "UK"),
                                      other_region = "RoW",
                                      stage_3_list = c("Innovator", "Mass", "Conservative"),
                                      stage_4_list = c("Innovator", "Early Adopter", "Early Majority", "Mainstreamer"),
                                      check_missing_cols = TRUE){
  
  # CREATE TRENDCURVE FACTORS ----
  #
  #   * DESCRIPTION *
  #   Takes a data frame (typically a TrendCurve one) and creates factors of the region_col
  #   and the stage_col.
  #
  #   * ARGUMENTS *
  #   - data:
  #     The data frame.
  #
  #   - factor_region: default = TRUE
  #     If TRUE, factor the region_col.
  #
  #   - factor_stage: default = TRUE
  #     If TRUE, factor the stage_col.
  #
  #   - region_col: default = "region"
  #     The column of regions to factor.
  #
  #   - stage_col: default = "stage"
  #     The column of stages to factor.
  #
  #   - region_list: default = c("APAC", "EU", "LATAM", "NAM", "UK")
  #     The list of regions to create factors from.
  #
  #   - other_region: default = "RoW"
  #     If a value in the region_col does not appear in the region_list, this value
  #     will be used instead.
  #
  #   - stage_3_list: default = c("Innovator", "Mass", "Conservative")
  #     The list of stages to create factors from if the vertical is one that contains
  #     three stages such as the Lifestyles & Interiors one.
  #
  #   - stage_4_list: default = c("Innovator", "Early Adopter", "Early Majority", "Mainstreamer")
  #     The list of stages to create factors from if the vertical is one that contains
  #     four stages such as the Food & Drink and Beauty one.
  #
  #   - check_missing_col: default = TRUE
  #     If TRUE, will check whether the date_col exists in the data frame before running.
  #     The option to turn off this check exists as this function is called within the
  #     trendcurve_tidy function and all the column checks are already carried out there.
  #
  #   * DETAILS *
  #   When importing TrendCurve data from Snowflake, the region_col and stage_col will be
  #   stored as simple text. This function takes those columns and converts them to factors.
  #   Doing this makes working with them for analysis easier. For example, allowing the user 
  #   to use the filters if viewing via the view() function, and showing them in the order
  #   defined in the region_list and stage_x_list when charting, rather than alphabetically.
  #
  #   * DEPENDENCIES *
  #   check_missing_columns()
  #   'dplyr' library
  #   'rlang' library
  #   'stringr' library
  #
  #   * VERSION *
  #   1.0
  #   Last modified on 2024/01/16 by Joseph Earle
  # ----
  
  # Checks if the region_col and stage_col are present in the data.
  # Does not run if called from the trendcurve_tidy function as this
  # step is handled within that.
  if (check_missing_cols == TRUE) {
    check_missing_columns(data = data,
                          cols = c(stage_col, region_col))
  }
  
  # Creates factors for the region based on the region_list. Anything found not in the
  # region_list will be marked as the other_region argument.
  if (factor_region == TRUE) {
    data <- data |> 
      dplyr::mutate(!!rlang::sym(region_col) := dplyr::if_else(!(!!rlang::sym(region_col)) %in% region_list,
                                                               true = other_region,
                                                               false = !!rlang::sym(region_col)),
                    !!rlang::sym(region_col) := factor(!!rlang::sym(region_col),
                                                       levels = c(region_list, other_region)))
  }
  

  if (factor_stage == TRUE) {
    # Detects whether there are 3 or 4 stages in the data (varies by vertical) and sets
    # the variable to the right list.
    if (any(data[[stage_col]] == "Mass",
            na.rm = TRUE)){
      stages_list <- stage_3_list
    } else {
      stages_list <- stage_4_list
    }
    
    # Creates factors for the stages_list.
    data <- data |> 
      dplyr::mutate(!!rlang::sym(stage_col) := dplyr::case_when(stringr::str_detect(!!rlang::sym(stage_col),
                                                                                    pattern = "Innov") ~ "Innovator",
                                                                stringr::str_detect(!!rlang::sym(stage_col),
                                                                                    pattern = "Adopt") ~ "Early Adopter",
                                                                stringr::str_detect(!!rlang::sym(stage_col),
                                                                                    pattern = "Major") ~ "Early Majority",
                                                                stringr::str_detect(!!rlang::sym(stage_col),
                                                                                    pattern = "Mainst") ~ "Mainstreamer",
                                                                stringr::str_detect(!!rlang::sym(stage_col),
                                                                                    pattern = "Mass") ~ "Mass",
                                                                stringr::str_detect(!!rlang::sym(stage_col),
                                                                                    pattern = "Conserv") ~ "Conservative"),
                    !!rlang::sym(stage_col) := factor(!!rlang::sym(stage_col),
                                                      levels = stages_list))
  }
  
  return(data)
  
}
