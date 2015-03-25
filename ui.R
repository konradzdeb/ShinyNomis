library(shiny); library(shinythemes)

# Define UI with theme
shinyUI(fluidPage(theme = shinytheme("flatly"),
  
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
                step = 1, animate = FALSE),
    h4("Geographies"),
    # Provide selections for local authorities
    selectInput("selectIndicator", label = "", choices = lst.councils, selected = 1)
    )
    
    # Show the generated plot and the data
    mainPanel(
      tabsetPanel(
        # Define panel with the chart
        tabPanel("Plot",textOutput("testText")),
        # Define panel with the data set
        tabPanel("Data",textOutput("testText"))
      )
    )
  )
))
