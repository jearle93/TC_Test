is.c0 <- function(x){
  
  # IS/IS NOT CHARACTER(0) ----
  #
  #   * DESCRIPTION *
  #   Add to a filter to show only rows that contain 'character(0)'.
  #   Can be proceeded by a '!' to remove rows that contain 'character(0)'.
  #
  #   * ARGUMENTS *
  #   - x:
  #     The column to evaluate for 'character(0)'.
  #
  #   * DETAILS *
  #   When using str_extract() to extract regex patterns, any rows that don't
  #   match will show 'character(0)' instead of a blank or NA value. Adding
  #   this to a filter function will allow only these values to show. Prefix
  #   the function by an '!' to do the opposite and exclude these values. For
  #   example, filter(!is.c0(column_name)).
  #
  #   * DEPENDENCIES *
  #   None
  #
  #   * VERSION *
  #   1.0
  #   Last modified on 2024/01/09 by Joseph Earle
  # ----
  
  x == "character(0)"
  
}
