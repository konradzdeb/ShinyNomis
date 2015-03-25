# Libs
library(shiny);

shinyServer(function(input, output) {
  
  # Download the data from NOMIS and run other data cleaning
  source('global.R', local=TRUE)
  
  output$testText <- renderPrint({
    input$selectMeasure
  })
})
