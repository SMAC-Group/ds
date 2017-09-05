#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

   # Application title
   titlePanel(" "),
  

   # Sidebar with a slider input for number of bins
   sidebarLayout(

      sidebarPanel(
        h4("Maybe add a title?"),
        br(),
        selectInput("type", label = "type = ",
                    choices = list("b" = "b", "l" = "l", "p" = "p",
                                   "s" = "s", "h" = "h"),
                    selected = "b"),

        checkboxInput("point", "Show points parameters", value = FALSE),

        conditionalPanel(
          condition = "input.point == 1",
          sliderInput("pch", "pch = ", 1, 30, 16),
          sliderInput("cex", "cex = ", 0, 4, 1, step = 0.25)
        ),

        checkboxInput("line", "Show line parameters", value = FALSE),

        conditionalPanel(
          condition = "input.line == 1",
          sliderInput("lty", "lty = ", 1, 4, 1, step = 1),
          sliderInput("lwd", "lwd = ", 0, 10, 1, step = 1)
        ),


        checkboxInput("lab", "Show label parameters", value = FALSE),

        conditionalPanel(
          condition = "input.lab == 1",
          textInput("main", "main = ", value = "my title"),
          textInput("xlab", "xlab = ", value = "x"),
          textInput("ylab", "ylab = ", value = "y"),
          sliderInput("cex.axis", "cex.axis = ", 0, 4, 1, step = 0.25),
          sliderInput("cex.lab", "cex.lab = ", 0, 4, 1, step = 0.25),
          sliderInput("cex.main", "cex.main = ", 0, 4, 1, step = 0.25)

        ),


        checkboxInput("couleur", "Show color parameters", value = FALSE),

        conditionalPanel(
          condition = "input.couleur == 1",
          sliderInput("col", "col = ", 1, 10, 1, step = 1),
          sliderInput("col.axis", "col.axis = ", 1, 10, 1, step = 1),
          sliderInput("col.lab", "col.lab = ", 1, 10, 1, step = 1),
          sliderInput("col.main", "col.main = ", 1, 10, 1, step = 1)
        ),


        checkboxInput("legend", "Add legend and show parameters", value = FALSE),

        conditionalPanel(
          condition = "input.legend == 1",
          selectInput("legend_position", label = "Legend position:",
                      choices = list("topleft" = "topleft",
                                     "topright" = "topright",
                                     "bottomleft" = "bottomleft",
                                     "bottomright" = "bottomright"),
                      selected = "topright"),

          sliderInput("leg_cex", "cex = ", 0, 4, 1, step = 0.25),

          selectInput("bty", label = "bty = ",
                      choices = list("o" = "o",
                                     "n" = "n"),
                      selected = "n")

        ),

        checkboxInput("grid", "Add: grid()", value = FALSE)



      ),

      mainPanel(
        tabsetPanel(type = "tabs", 
                    tabPanel("Plot", plotOutput("distPlot")), 
                    tabPanel("Show code", verbatimTextOutput("code"))
        )
      )
  , position = "right")
)

# Define server logic required to draw a histogram
server <- function(input, output) {

   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      xx = seq(from = 0, to = 4*pi, length.out = 60)
      yy = sin(xx)

      plot(NA, xlim = range(xx), ylim = range(yy), main = input$main,
           xlab = input$xlab, ylab = input$ylab,
           col.main = input$col.main, col.lab = input$col.lab,
           col.axis = input$col.axis, cex.main = input$cex.main,
           cex.lab = input$cex.lab, cex.axis = input$cex.axis)

      if (input$grid){
        grid()
      }

      lines(xx, yy, type = input$type,
            pch = input$pch, cex = input$cex, lwd = input$lwd,
            lty = input$lty, col = input$col)

      if (input$legend){
        legend(input$legend_position, "sin(x)", pt.lwd = input$lwd,
               lty = input$lty, col = input$col, pt.cex = input$cex,
               bty = input$bty, pch = input$pch, cex = input$leg_cex)
      }
        
      
      

   })
   
   output$code <- renderPrint({
     cat("# Generate data\n")
     cat("xx = seq(from = 0, to = 4*pi, length.out = 60)\n")
     cat("yy = sin(xx)\n")
     
     cat("\n")
     cat("# Main plot\n")
     cat("plot(xx, yy, main = '")
     cat(input$main)
     cat("', xlab = '")
     cat(input$xlab)
     cat("', ylab = '")   
     cat(input$ylab)
     cat("', type = '")   
     cat(input$type)
     cat("'")
     
     if (input$type == "b" || input$type == "b"){
       cat(", pch = ")   
       cat(input$pch)
     }
     
     
     if (input$cex != 1 & (input$type == "b" || input$type == "b")){
       cat(", cex = ")   
       cat(input$pch)
     }
     
     if (input$lwd != 1 & input$type != "p"){
       cat(", lwd = ")   
       cat(input$lwd)
     }
     
     if (input$lty != 1 & input$type != "p"){
       cat(", lty = ")   
       cat(input$lty)
     }
     
     
     if (input$col != 1){
       cat(",  col = ")   
       cat(input$col)
     }
   
     if (input$col.main != 1){
       cat(", col.main = ")
       cat(input$col.main)
     }
     
     if (input$col.lab != 1){
       cat(", col.lab = ")
       cat(input$col.lab)
     }
     
     if (input$col.axis != 1){
       cat(", col.axis = ")
       cat(input$col.axis)
     }
     
     if (input$cex.main != 1){
       cat(", cex.main = ")
       cat(input$cex.main)
     }
     
     if (input$cex.lab != 1){
       cat(", cex.lab = ")
       cat(input$cex.lab)
     }
     
     if (input$cex.axis != 1){
       cat(", cex.axis = ")
       cat(input$cex.axis)
     }
     
     cat(")\n\n")
     
     
     if (input$grid){
       cat("# Add legend\n")
       cat("grid()\n\n")
     }
     
     if (input$legend){
       cat("# Add legend\n")
       cat("legend('")
       cat(input$legend_position)
       cat("', 'sin(x)', pt.lwd = ")
       cat(input$lwd)
       cat(", lty = ")
       cat(input$lty)
       cat(", col = ")
       cat(input$col)
       cat(", pt.cex = ")
       cat(input$cex)
       cat(", bty = '")
       cat(input$bty)
       cat("', pch = ")
       cat(input$pch)
       cat(", cex = ")
       cat(input$leg_cex)
       cat(")")
     }

   })
}

# Run the application
shinyApp(ui = ui, server = server)

