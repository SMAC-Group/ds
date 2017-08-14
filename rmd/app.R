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
  
  cat("\n## RMarkdown Playground\n\n")
  cat("Experiment with the Rmd Code below and test output.\n\n")
  
  if(input$header){
    cat("# Header Type 1\n## Header Type 2 \n### Header Type 3\n\n")
  }
  
  if(input$bullet){
    cat("- First \n- Second \n- Third \n\n")
  }
  
  if(input$bolditalic){
    cat("Use * or _ to emphasize things:\n\n")
    cat("*this is in italic*  and _so is this_\n\n")
    cat("**this is in bold**  and __so is this__\n\n")
    cat("***this is bold and italic***  and ___so is this___\n\n")
  }
  
  if(input$p){
    cat("**Paragraph together (on one line):**\n\n")
    cat("When I first brought my cat home from the humane society she was a mangy, pitiful animal. It cost a lot to adopt her: forty dollars. And then I had to buy litter, a litterbox, food, and dishes for her to eat out of. Two days after she came home with me she got taken to the pound by the animal warden. There's a leash law for cats in Fort Collins. If they're not in your yard they have to be on a leash. Anyway, my cat is my best friend. I'm glad I got her. She sleeps under the covers with me when it's cold. Sometimes she meows a lot in the middle of the night and wakes me up, though. (unfocused)\n\n")
    
    cat("**Paragraph (multiple lines without breaks):**\n\n")
    
    cat("When I first brought my cat home from the humane society she was a mangy, pitiful animal.\n")
    cat("It cost a lot to adopt her: forty dollars. And then I had to buy litter, a litterbox,\n")
    cat("food, and dishes for her to eat out of. Two days after she came home with me she got taken\n")
    cat("to the pound by the animal warden. There's a leash law for cats in Fort Collins. If \n")
    cat("they're not in your yard they have to be on a leash. Anyway, my cat is my best friend. I'm\n")
    cat("glad I got her. She sleeps under the covers with me when it's cold. Sometimes she meows a \n")
    cat("lot in the middle of the night and wakes me up, though. (unfocused)\n\n")
    
    cat("**Paragraph (multiple lines with breaks):**\n\n")
    cat("When I first brought my cat home from the humane society she was a mangy, pitiful animal.\n\n")
    cat("It cost a lot to adopt her: forty dollars. And then I had to buy litter, a litterbox,\n\n")
    cat("food, and dishes for her to eat out of. Two days after she came home with me she got taken\n\n")
    cat("to the pound by the animal warden. There's a leash law for cats in Fort Collins. If \n\n")
    cat("they're not in your yard they have to be on a leash. Anyway, my cat is my best friend. I'm\n\n")
    cat("glad I got her. She sleeps under the covers with me when it's cold. Sometimes she meows a \n\n")
    cat("lot in the middle of the night and wakes me up, though. (unfocused)\n\n")
    
    cat("**Notice that the paragraph on one line and multiple lines without breaks are identical**\n\n")
  }
  
  if(input$quote){
    cat("> Use the > character in front of a line, *just like in email*.\n> Use it if you're quoting a person, a song or whatever.\n>>Add the >> if you want to quote within a quote.\n\n")
  }
  
  if(input$link){
    cat("**Links Full:** <https://google.com/>\n\n**Links Custom:** [Google](https://google.com)\n\n")
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
    sidebarLayout(
      sidebarPanel(
        checkboxInput("header", label = "Headers", value = FALSE),
        checkboxInput("bullet", label = "Bullet Points", value = FALSE),
        checkboxInput("bolditalic", label = "Emphasis", value = FALSE),
        checkboxInput("p", label = "Paragraph", value = FALSE),
        checkboxInput("quote", label = "Blockquotes", value = FALSE), 
        checkboxInput("link", label = "Links", value = FALSE)
      ),
      
      mainPanel(
        tabsetPanel(id = "tabs",
                    tabPanel("Raw code", verbatimTextOutput(outputId = "raw")),
                    tabPanel("Compiled html", uiOutput('markdown'))
        )
      )
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