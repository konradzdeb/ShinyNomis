library(shiny); library(shinythemes)

# Define UI with theme
shinyUI(fluidPage(theme = shinytheme("flatly"),
  
  # Application title
  titlePanel("Live Labour Market Data"),
  
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
    # Provide selections for local authorities
    # Chart aesthetics
    h4("Aesthetics"),
    # Line width
    sliderInput("sliderLine", label = h5("Line width"), min = 0, max = 10,
                value = 1, step = 0.1, animate = FALSE),
    # Point Size
    sliderInput("sliderPoint", label = h5("Point size"), min = 0, max = 20,
                value = 6, step = 0.1, animate = FALSE),
    checkboxGroupInput("checkCouncil", label = h4("Councils"), 
                choices = lst.councils, selected = "Aberdeen City")
    # Close the side panel elements here
    ),
    # Show the generated plot and the data
    mainPanel(
      tabsetPanel(
        # Define panel with the chart
        tabPanel("Plot", plotOutput(outputId = "main_plot",  width = '100%',
                                    height = '100%')),
        # Define panel with the data set
        tabPanel("Data",dataTableOutput('dataChartTable'))
      ),
      h4("Notes"),
      tags$p(HTML("<p style='font-size:12px'>The following application was developed for the educational purposes. The application sources the NOMIS labour market data from the <a href='https://www.nomisweb.co.uk/default.asp', target='_blank'>NOMIS</a> website. The code for the app is available via <a href='https://github.com/konradedgar/ShinyNomis', target='_blank'>GitHub</a>.</p>")),
      tags$p(HTML("<p align='right', style='font-size:10px'>Konrad Zdeb @ <a href='https://culturedsoftwareandcuriousresearch.wordpress.com/', target='_blank'>Cultured Software and Curious Research</a></p>"))
    )
  )
))
