wgsn_colours <- function(colour = 'all',
                         adjust_amount = NULL,
                         group_by = c('colour', 'shade')) {
  
  # WGSN COLOUR SELECTOR ----
  #
  #   * DESCRIPTION *
  #   Allows user to easily select a WGSN colour by typing the colour name and receiving
  #   the hex code value.
  #
  #   * ARGUMENTS *
  #   - colour: default = 'all'
  #     The name of the hex code colour to return. Only one value can be entered, but
  #     some values can return multiple colours.
  #
  #   - adjust_amount: default = 0
  #     1 outputs full white, -1 outputs full black, numbers in between output either a 
  #     darker or lighter shade of the input colour. Multiple values can be entered.
  #
  #   - group_by: default = 'colour'
  #     For use when entering multiple colours and adjustment amounts. Enter 'colour' to group
  #     the output by colour (dark red, red, light red, dark blue, blue, light blue), or 'shades'
  #     to group the output by shades (dark red, dark blue, red, blue, light red, light blue).
  #
  #   * DETAILS *
  #   Contains hex code values for all commonly used colours within the WGSN palette.
  #   User enters the name of the colour they wish to use and a hex code is returned.
  #   User can also enter '3', '4', or name of TrendCurve vertical to receive all
  #   colours used by those stages. Similarly, the default of 'all' will return all
  #   colours in the WGSN palette. Users can also use the adjust_amount argument to 
  #   specify how much they want to lighten or darken the shade. Values from 0 to -1 
  #   will darken the shade, and values from 0 to 1 will lighten the shade. Output is 
  #   in the form of a new hex code(s). Multiple colours can be entered along with 
  #   multiple adjust_amount values to return multiple outputs. Useful for when plotting 
  #   and wanting different shades of the same colour.
  #
  #   * DEPENDENCIES *
  #   clr_variant()
  #   'stringr' library
  #
  #   * VERSION *
  #   1.0
  #   Last modified on 2024/01/09 by Joseph Earle
  # ----
  
  # Converts the input to lowercase.
  colour <- stringr::str_to_lower(colour)
  
  # Takes the colour, uses regex to match it, and returns the corresponding hex code(s).
  if (stringr::str_detect(string = colour, pattern = "blue")) {x <- "#0729e0"}
  else if (stringr::str_detect(string = colour, pattern = "purple")) {x <- "#9564ff"}
  else if (stringr::str_detect(string = colour, pattern = "yellow")) {x <- "#faa500"}
  else if (stringr::str_detect(string = colour, pattern = "magenta")) {x <- "#c35578"}
  else if (stringr::str_detect(string = colour, pattern = "peach")) {x <- "#fe7373"}
  else if (stringr::str_detect(string = colour, pattern = "pink")) {x <- "#feb7a7"}
  else if (stringr::str_detect(string = colour, pattern = "cyan")) {x <- "#22c6d0"}
  else if (stringr::str_detect(string = colour, pattern = "mint")) {x <- "#95e9c2"}
  
  else if (stringr::str_detect(string = colour, pattern = "pos")) {x <- "#22c99f"}
  else if (stringr::str_detect(string = colour, pattern = "stag")) {x <- "#f59b00"}
  else if (stringr::str_detect(string = colour, pattern = "neg")) {x <- "#f24500"}
  
  else if (stringr::str_detect(string = colour, pattern = "gr(e|a)y.{0,3}l")) {x <- "#f7f7f7"}
  else if (stringr::str_detect(string = colour, pattern = "gr(e|a)y.{0,3}m")) {x <- "#f7f7f7"}
  else if (stringr::str_detect(string = colour, pattern = "gr(e|a)y.{0,3}d")) {x <- "#808080"}
  else if (stringr::str_detect(string = colour, pattern = "gr(e|a)y.{0,3}t")) {x <- "#464646"}
  else if (stringr::str_detect(string = colour, pattern = "gr(e|a)y.{0,3}h")) {x <- "#666666"}
  
  else if (stringr::str_detect(string = colour, pattern = "innov")) {x <- "#aa5aa1"}
  else if (stringr::str_detect(string = colour, pattern = "adopt")) {x <- "#5cb6a7"}
  else if (stringr::str_detect(string = colour, pattern = "maj|mass")) {x <- "#6da3d8"}
  else if (stringr::str_detect(string = colour, pattern = "main|cons")) {x <- "#f77551"}
  
  else if (stringr::str_detect(string = colour, pattern = "4|f.*d|be")) {x <- c("#aa5aa1", "#5cb6a7", "#6da3d8", "#f77551")}
  else if (stringr::str_detect(string = colour, pattern = "3|l.*i")) {x <- c("#aa5aa1", "#6da3d8", "#f77551")}
  else if (stringr::str_detect(string = colour, pattern = "all")) {x <- c("#0729e0", "#9564ff", "#faa500", "#c35578",
                                                                          "#fe7373", "#feb7a7", "#22c6d0", "#95e9c2",
                                                                          "#aa5aa1", "#5cb6a7", "#6da3d8", "#f77551")}
  
  # If user has entered an adjustment amount, calls the clr_variant function to get
  # alternative shades of the specified colour.
  if (!is.null(adjust_amount)){
    x <- colour_variant(x, adjust_amount = adjust_amount, group_by = group_by)
  }
  
  # Returns the hex code.
  return(x)
  
}