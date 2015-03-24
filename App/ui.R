library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Hello Shiny!"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      # Indicators
      h4("Indicators"),
      # Selection of the available indicators
      selectInput("selectMeasure", label = h5("Measure"), 
                  choices = lst.measures, 
                  selected = 1),
      # Selection of the available measures
      selectInput("selectIndicator", label = h5("Indicator"), 
                  choices = lst.vars, 
                  selected = 1),
    # Select the dates for the data
    sliderInput("sliderYears", label = h5("Years"), min = yr.min, 
                max = yr.max, value = c(2000, 2010), sep = "",
                step = 1, animate = TRUE)
    ),
    
    # Show the generated plot and the data
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
