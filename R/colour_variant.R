colour_variant <- function(colours,
                           adjust_amount,
                           group_by = c("colour", "shade")) {
  
  # COLOUR VARIANT ----
  #
  #   * DESCRIPTION *
  #   Takes a hex code colour(s) as an input and returns either a darker or lighter shade.
  #
  #   * ARGUMENTS *
  #   - colours:
  #     The base colour to be adjusted. Required in the form of a hex code, e.g. #de421f.
  #     Multiple values can be entered together.
  #
  #   - adjust_amount:
  #     1 outputs full white, -1 outputs full black, numbers in between output either a 
  #     darker or lighter shade of the input colour. Multiple values can be entered together.
  #
  #   - group_by: default = "colour"
  #     For use when entering multiple colours and adjustment amounts. Enter "colour" to group
  #     the output by colour (dark red, red, light red, dark blue, blue, light blue), or "shades"
  #     to group the output by shades (dark red, dark blue, red, blue, light red, light blue).
  #
  #   * DETAILS *
  #   Users enter a colour as a hex code and specify how much they want to lighten or
  #   darken the shade. Values from 0 to -1 will darken the shade, and values from 0
  #   to 1 will lighten the shade. Output is in the form of a new hex code(s). Multiple 
  #   colours can be entered along with multiple adjust_amount values to return multiple 
  #   outputs. Useful for when plotting and wanting different shades of the same colour.
  #
  #   * DEPENDENCIES *
  #   'grDevices' library
  #
  #   * VERSION *
  #   1.0
  #   Last modified on 2024/01/09 by Joseph Earle
  # ----
  
  
  output <- NULL
  
  # If group_by is default, or set as 'colour', or colours or adjust_amount only has one value.
  if ("colour" %in% group_by || length(colours) == 1 || length(adjust_amount) == 1) {
    
    # Loop through each colour.
    for (clr in 1:length(colours)) {
      
      
      # Splits the hex code and converts to RGB
      rgb <- as.vector(grDevices::col2rgb(colours[clr]))
      r <- rgb[1]
      g <- rgb[2]
      b <- rgb[3]
      
      all_out_var <- NULL
      out_var <- NULL
      
      # Loops through each value in adjust_amount, makes change and appends to 
      # all_out_var variable.
      for (var in 1:length(adjust_amount)) {
        
        # No change.
        if (adjust_amount[var] == 0){out_var <- colours[clr]}
        
        # Make colour darker.
        if (adjust_amount[var] < 0){
          adjust_amount[var] <- (1 + adjust_amount[var]) * -1
          r2 <-  r * (adjust_amount[var] * -1)
          g2 <-  g * (adjust_amount[var] * -1)
          b2 <-  b * (adjust_amount[var] * -1)
          out_var <- grDevices::rgb(r2, 
                                    g2, 
                                    b2, 
                                    maxColorValue = 255)
        }
        
        # Make colour brighter.
        if(adjust_amount[var] > 0){
          r2 <- r + (adjust_amount[var] * (255 - r))
          g2 <- g + (adjust_amount[var] * (255 - g))
          b2 <- b + (adjust_amount[var] * (255 - b))
          out_var <- grDevices::rgb(r2,
                                    g2, 
                                    b2, 
                                    maxColorValue = 255)
        }
        
        # Append newly adjusted variance to list of all adjusted variances.
        all_out_var <- c(all_out_var, out_var)
        
      } # Next adjustment amount (if applicable).
      
      # Append newly adjusted colours to list of all adjusted colours.
      output <- c(output, all_out_var)
      
    } # Next colour (if applicable).
    
  } else if (group_by == "shade") {
    
    # Loop through each adjustment amount.
    for (var in 1:length(adjust_amount)) {
      
      all_out_clr <- NULL
      out_clr <- NULL
      
      # Loop through each colour.
      for (clr in 1:length(colours)) {
        
        # Splits the hex code and converts to RGB
        rgb <- as.vector(grDevices::col2rgb(colours[clr]))
        r <- rgb[1]
        g <- rgb[2]
        b <- rgb[3]
        
        # No change.
        if (adjust_amount[var] == 0){out_clr <- colours[clr]}
        
        # Make colour darker.
        if (adjust_amount[var] < 0){
          adjust_amount[var] <- (1 + adjust_amount[var]) * -1
          r2 <-  r * (adjust_amount[var] * -1)
          g2 <-  g * (adjust_amount[var] * -1)
          b2 <-  b * (adjust_amount[var] * -1)
          out_clr <- grDevices::rgb(r2, 
                                    g2, 
                                    b2, 
                                    maxColorValue = 255)
        }
        
        # Make colour brighter.
        if(adjust_amount[var] > 0){
          r2 <- r + (adjust_amount[var] * (255 - r))
          g2 <- g + (adjust_amount[var] * (255 - g))
          b2 <- b + (adjust_amount[var] * (255 - b))
          out_clr <- grDevices::rgb(r2,
                                    g2, 
                                    b2, 
                                    maxColorValue = 255)
        }
        
        # Append newly adjusted variance to list of all adjusted variances.
        all_out_clr <- c(all_out_clr, out_clr)
      } # Next colour (if applicable).
      
      # Append newly adjusted colours to list of all adjusted colours.
      output <- c(output, all_out_clr)
      
    } # Next adjustment amount (if applicable).
    
  }
  
  # Return list of all newly adjusted colours as hex codes.
  return(output)
  
}