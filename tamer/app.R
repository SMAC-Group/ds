#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

cast_needle = function(plan = 10, needle_length = 1){
  available_range = plan - needle_length
  x_start = runif(2, -available_range, available_range)
  angle = runif(1, 0, 2*pi)
  x_end = needle_length*c(cos(angle), sin(angle)) + x_start
  cross = floor(x_start[2]) != floor(x_end[2])
  out = list(start = x_start, end = x_end, cross = cross)
  out
}

buffon_needle = function(B = 2084, plan = 10, needle_length = 1, seed = NULL){
  
  if (!is.null(seed)){
    set.seed(seed)
  }
  
  X_start = X_end = matrix(NA, B, 2) 
  cross = rep(NA, B)
  for (i in 1:B){
    inter = cast_needle(plan = plan, needle_length = needle_length)
    X_start[i, ] = inter$start
    X_end[i, ] = inter$end
    cross[i] = inter$cross
  }
  out = list(start = X_start, end = X_end, cross = cross, plan = plan)
  class(out) = "buffon_needle"
  out
}

plot.buffon_needle = function(obj){
  cross = obj$cross
  X_start = obj$start
  X_end = obj$end
  B = length(cross)
  cols = rev(hcl(h = seq(15, 375, length = 3), l = 65, c = 100)[1:2])
  
  titre_part1 = 'Buffon\'s needle experiment  -  '
  titre_part2 = ' = '
  pi_hat = round(2/mean(obj$cross), 6)
  
  titre = bquote(.(titre_part1) ~ hat(pi) ~ .(titre_part2) ~ .(pi_hat))
  
  plot(NA, xlab = "x", ylab = "y", xlim = c(-obj$plan, obj$plan), 
       ylim = c(-obj$plan, obj$plan), 
       main = titre)
  abline(h = (-obj$plan):obj$plan, lty = 3)
  
  for (i in 1:B){
    lines(c(X_start[i,1], X_end[i,1]), c(X_start[i,2], X_end[i,2]), 
          col = cols[cross[i] + 1])
  }
}


converge = function(B = 2084, plan = 10, needle_length = 1, seed = 1777, M = 12){
  
  if (B < 10){
    warning("B was changed to 10")
    B = 10
  }
  pi_hat = matrix(NA, B, M)
  trials = 1:B
  cols = rev(hcl(h = seq(15, 375, length = (M+1)), l = 65, c = 100, alpha = 1)[1:M])
  
  set.seed(seed)
  
  for (i in 1:M){
    cross = buffon_needle(B = B, plan = plan, needle_length = needle_length)$cross
    pi_hat[,i] = 2*trials/cumsum(cross)
  }
  
  
  plot(NA, xlim = c(1,B), ylim = pi + c(-3/4, 3/4), type = "l", col = "darkblue",
       ylab = bquote(hat(pi)[i]),
       xlab = "i", main = "Buffon\'s needle experiment in time")
  grid()
  
  for (i in 1:M){
    lines(trials, pi_hat[,i], col = cols[i])
  }
  
  abline(h = pi, lwd = 2, lty = 2)
}









# Define UI for application
ui <- fluidPage(
  
  # Application title
  titlePanel(h4("Buffon\'s needle experiment - Inputs:")),
  
  sidebarLayout(
    sidebarPanel(
      # Add inputs here!
    ),
    
    mainPanel(
      tabsetPanel(
        # Add tabs here!
      )
    )
  )
)


server <- function(input, output, session) {
  
}

# Run the application 
shinyApp(ui = ui, server = server)

