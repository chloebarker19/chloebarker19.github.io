
server = function(input, output) {
  # Reactive dataset filtered by state
  beer_state = reactive({
    if (input$stateFilter == "All") {
      beer_data
    } else {
      beer_data %>% filter(State == input$stateFilter)
    }
  })
  
  # Histogram or Boxplot of selected variable
  output$distPlot = renderPlot({
    state_data = beer_state()
    x = state_data[[input$select]]
    
    if (input$plotType == "hist") {
      bins = seq(min(x), max(x), length.out = input$bins + 1)
      hist(x, breaks = bins, col = "lightseagreen", border = "white",
           xlab = input$select, main = paste("Histogram of", input$select))
    } else {
      boxplot(x, horizontal = TRUE, col = "deepskyblue4",
              xlab = input$select, main = paste("Boxplot of", input$select))
    }
  })
  
  # Scatter plot with optional regression line
  output$scatterPlot = renderPlot({
    state_data = beer_state()
    
    p = ggplot(state_data, aes(x = ABV, y = IBU)) + geom_point(color = "blue3", alpha = 0.8) +
      labs(title = "Scatterplot of IBU vs ABV", x = "ABV", y = "IBU")
    
    if (input$showReg) {
      p = p + geom_smooth(method = "lm", se = FALSE, color = "magenta1")
    }
    
    p
  })
  
  # Additional plot 1: Box plots of ABV by State
  output$stateBoxplot <- renderPlot({
    ggplot(beers, aes(x = State, y = ABV)) + geom_boxplot(fill = "maroon3") +
      theme(axis.text.x = element_text(angle = 90)) + ggtitle("ABV Distribution by State") + xlab("State") + ylab("ABV")
  })
  
  # Additional plot 2: Box plots of IBU by State
  output$stateIBUBoxplot <- renderPlot({
    ggplot(beers, aes(x = State, y = IBU)) + geom_boxplot(fill = "maroon3") +
      theme(axis.text.x = element_text(angle = 90)) + ggtitle("IBU Distribution by State") + xlab("State") + ylab("IBU")
  })
  
}


shinyApp(ui = ui, server = server)
