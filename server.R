# Libs
library(shiny); require(ggplot2); require(grid)

shinyServer(function(input, output) {

  # Run the data download from NOMIS and run other data cleaning
  source('global.R', local=TRUE)

  # Render chart
  output$main_plot <- renderPlot({
    # Filter the data set accordingly
    dta.chrt <- subset(x = dta.nom,
                       subset = dta.nom$GEOGRAPHY_NAME %in% input$checkCouncil &
                         dta.nom$MEASURES_NAME %in% input$selectMeasure &
                         dta.nom$ITEM_NAME %in% input$selectIndicator &
                         dta.nom$DATE_NAME >= input$sliderYears[1] &
                         dta.nom$DATE_NAME <= input$sliderYears[2])
    # Define legend for convenience and alter the row number if required
    ## Legend rows are adjusted according to geographies
    g <- guide_legend(title = "Geography", title.position = 'top',
                      nrow = (if(length(unique(dta.chrt$GEOGRAPHY_NAME)) > 5) 2
                        else 1),
                      title.theme = element_text(size = 14, face = 'bold', angle = 360))
    # Graph something
    ggplot(data = dta.chrt, aes(x = DATE_NAME, y = OBS_VALUE)) +
      geom_line(aes(linetype = GEOGRAPHY_NAME, colour = GEOGRAPHY_NAME),
                size = input$sliderLine) +
      geom_point(aes(shape = GEOGRAPHY_NAME, colour = GEOGRAPHY_NAME),
                 size = input$sliderPoint) +
      ggtitle(paste(input$selectMeasure, input$selectIndicator, sep = " / ")) +
      xlab("Year") +
      ylab(input$selectIndicator) +
      guides(colour = g, shape = g, linetype = g) +
      theme(panel.background = element_rect(fill = NA),
            panel.grid.major = element_line(colour = 'gray',
                                            linetype = 'dotted'),
            legend.position = 'bottom',
            legend.background = element_rect(colour = 'black',
                                             fill = NA, size = 0.5,
                                             linetype = 'solid'),
            legend.key.width = unit(2, "cm"),
            legend.key = element_blank(),
            axis.title = element_text(colour = 'black', face = 'bold',
                                      size = 12),
            axis.text = element_text(colour = 'black', size = 12),
            plot.background = element_rect(colour = 'gray'),
            plot.title = element_text(colour = 'black', size = 14, face = 'bold'))
  }, height = 650, width = 800)
  # Render data table
  output$dataChartTable <- renderDataTable(
    # Filter the data set accordingly
    dta.chrt <- subset(x = dta.nom[,c("GEOGRAPHY_NAME",
                                      "MEASURES_NAME","ITEM_NAME",
                                      "DATE_NAME")],
                       subset = dta.nom$GEOGRAPHY_NAME %in% input$checkCouncil &
                         dta.nom$MEASURES_NAME %in% input$selectMeasure &
                         dta.nom$ITEM_NAME %in% input$selectIndicator &
                         dta.nom$DATE_NAME >= input$sliderYears[1] &
                         dta.nom$DATE_NAME <= input$sliderYears[2]))
# Close the server function
})