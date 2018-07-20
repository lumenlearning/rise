#' RISE Analysis
#'
#' Conduct RISE analysis to automatically identify learning outcomes whose learning resources or assessments might benefit from continuous improvement efforts.
#'
#' @param df A dataframe containing three columns: outcome name, avg score on aligned assessmets, and average views of aligned learning resources. The columns in the data frame must be in exactly this order.
#' @param visual When this argument is FALSE (the default), the function returns an annotated data frame with RISE information in the final two columns. When this argument is TRUE, the function returns a ggplot2 graph of the RISE diamond.
#'
#' @return Returns either an annotated data frame or a graph, depending on the value of visual.
#' @export
#' @examples
#' library(ggplot2)
#' rise(sample_df, visual = TRUE)

rise <- function(df, visual = FALSE) {
  if (!is.data.frame(df)) {
    stop("You must pass a data frame to this function.")
  }
  if (ncol(df) < 3) {
    stop("Your data frame must have at least three columns.")
  }

  # Only rows without NAs in the columns we care about
  df <- df[complete.cases(df[, 3]), ]
  df <- df[complete.cases(df[, 2]), ]

  # Basic descriptives
  x_sd <- sd(unlist(df[, 3]), na.rm = TRUE)
  x_mean <- mean(unlist(df[, 3]), na.rm = TRUE)
  y_sd <- sd(unlist(df[, 2]), na.rm = TRUE)
  y_mean <- mean(unlist(df[, 2]), na.rm = TRUE)


  # # # # # # # # # # # # # # # # # # # # # # # #
  # Create the graph
  # # # # # # # # # # # # # # # # # # # # # # # #

  # Points
  p1x <- x_mean - 3 * x_sd
  p1y <- y_mean
  p2x <- x_mean
  p2y <- y_mean + 3 * y_sd
  p3x <- x_mean + 3 * x_sd
  p3y <- y_mean
  p4x <- x_mean
  p4y <- y_mean - 3 * y_sd

  # Lines for geom_segment
  l1 <- data.frame(x1 = p1x, x2 = p2x, y1 = p1y, y2 = p2y)
  l2 <- data.frame(x1 = p2x, x2 = p3x, y1 = p2y, y2 = p3y)
  l3 <- data.frame(x1 = p3x, x2 = p4x, y1 = p3y, y2 = p4y)
  l4 <- data.frame(x1 = p4x, x2 = p1x, y1 = p4y, y2 = p1y)

  # Create the plot
  p <- ggplot2::ggplot(df, aes(unlist(df[, 3]), unlist(df[, 2]))) +
    geom_point() +
    geom_hline(yintercept = y_mean) +
    geom_vline(xintercept = x_mean) +
    geom_segment(aes_string(x = 'x1', y = 'y1', xend = 'x2', yend = 'y2'), linetype = "dotted", colour = "dodgerblue3", data = l1) +
    geom_segment(aes_string(x = 'x1', y = 'y1', xend = 'x2', yend = 'y2'), linetype = "dotted", colour = "dodgerblue3", data = l2) +
    geom_segment(aes_string(x = 'x1', y = 'y1', xend = 'x2', yend = 'y2'), linetype = "dotted", colour = "dodgerblue3", data = l3) +
    geom_segment(aes_string(x = 'x1', y = 'y1', xend = 'x2', yend = 'y2'), linetype = "dotted", colour = "dodgerblue3", data = l4) +
    xlab(names(df[, 3])) +
    ylab(names(df[, 2]))


  # # # # # # # # # # # # # # # # # # # # # # # #
  # Annotate the data frame
  # # # # # # # # # # # # # # # # # # # # # # # #

  # Data frames for regression to find slopes
  df1 <- data.frame(x = c(p1x, p2x), y = c(p1y, p2y)) # Top left
  df2 <- data.frame(x = c(p2x, p3x), y = c(p2y, p3y)) # Top right
  df3 <- data.frame(x = c(p4x, p1x), y = c(p4y, p1y)) # Bottom left
  df4 <- data.frame(x = c(p3x, p4x), y = c(p3y, p4y)) # Bottom right

  # Slopes and intercepts
  t <- lm(y ~ x, df1) # temporary df
  i1 <- coef(t)[1] # first intercept
  s1 <- coef(t)[2] # first slope
  t <- lm(y ~ x, df2)
  i2 <- coef(t)[1]
  s2 <- coef(t)[2]
  t <- lm(y ~ x, df3)
  i3 <- coef(t)[1]
  s3 <- coef(t)[2]
  t <- lm(y ~ x, df4)
  i4 <- coef(t)[1]
  s4 <- coef(t)[2]

  # Put points in RISE quadrants
  df$rise_quadrant <- NA
  for (i in 1:nrow(df)) {
    if (df[i, 3] < x_mean && df[i, 2] >= y_mean) {
      df[i, ]$rise_quadrant <- 1
    }
    if (df[i, 3] >= x_mean && df[i, 2] >= y_mean) {
      df[i, ]$rise_quadrant <- 2
    }
    if (df[i, 3] < x_mean && df[i, 2] < y_mean) {
      df[i, ]$rise_quadrant <- 3
    }
    if (df[i, 3] >= x_mean && df[i, 2] < y_mean) {
      df[i, ]$rise_quadrant <- 4
    }
  }

  # Label points as inside or outside the diamond
  df$rise_outside <- 0
  for (i in 1:nrow(df)) {
    if (df[i, ]$rise_quadrant == 1) {
      if (df[i, 2] >= s1 * df[i, 3] + i1) {
        df[i, ]$rise_outside <- 1
      }
    }
    if (df[i, ]$rise_quadrant == 2) {
      if (df[i, 2] >= s2 * df[i, 3] + i2) {
        df[i, ]$rise_outside <- 1
      }
    }
    if (df[i, ]$rise_quadrant == 3) {
      if (df[i, 2] < s3 * df[i, 3] + i3) {
        df[i, ]$rise_outside <- 1
      }
    }
    if (df[i, ]$rise_quadrant == 4) {
      if (df[i, 2] < s4 * df[i, 3] + i4) {
        df[i, ]$rise_outside <- 1
      }
    }
  }

  if (visual == TRUE) {
    return(p)
  }
  else {
    return(df)
  }
}
