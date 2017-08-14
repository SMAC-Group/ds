library(shiny)
library(knitr)

make_files = function(input, rmd = FALSE){
  if (rmd){
    file.create("test.txt")
    sink("test.txt")
  }
  

  cat("---\n")
  cat("title: 'test'\n")
  cat("output: html_document\n")
  cat("---\n")
  
  cat("\n## Some title\n\n")
  cat("Some intro text\n\n")
  
  if (input$bullet){
    cat("- First \n")
    cat("- Second \n")
    cat("- Third \n")
  }
  
  if(rmd){
    sink()
  }
  
  if (rmd){
    file.rename('test.txt', 'test.Rmd')
  }
}

ui <- shinyUI(
  fluidPage(
    title = "GMWM GUI",
    
    checkboxInput("bullet", label = "Add bullet point example", value = FALSE),
    
    tabsetPanel(id = "tabs",
                tabPanel("Raw code", verbatimTextOutput(outputId = "raw")),
                tabPanel("Compiled html", uiOutput('markdown'))
    )
  )
)
server <- function(input, output) {
  
  output$raw <- renderPrint({
    make_files(input, rmd = FALSE)
  })

    
  output$markdown <- renderUI({
    make_files(input, rmd = TRUE)
    HTML(markdown::markdownToHTML(knit('test.Rmd', quiet = TRUE)))
  })
}

shinyApp(ui, server)