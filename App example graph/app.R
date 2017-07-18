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

      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
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
}

# Run the application
shinyApp(ui = ui, server = server)

