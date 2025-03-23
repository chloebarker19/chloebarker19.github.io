
ui = fluidPage(
  # App title
  titlePanel("Beer Data for the States!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      
      
      # Input: Make a select box 
      selectInput("select", label = h3("IBU or ABV"), 
                  choices = list("IBU" = "IBU", "ABV" = "ABV"), 
                  selected = 1),
      hr(),
      fluidRow(column(3, verbatimTextOutput("value"))),
      
      # Input: Slider for the number of bins
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      
      # Select plot type
      radioButtons("plotType", "Plot Type:",
                   choices = list("Histogram" = "hist", "Boxplot" = "box"),
                   selected = "hist"),
      
      # Filter by state
      selectInput("stateFilter", "Filter by State:",
                  choices = c("All", sort(unique(beer_data$State))),
                  selected = "All"),
      
      # Add regression line to scatterplot
      checkboxInput("showReg", "Show Regression Line on Scatterplot", value = TRUE)
    ),
    
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram or Boxplot
      plotOutput(outputId = "distPlot"),
      
      hr(),
      
      # Scatter plot of ABV vs. IBU
      plotOutput("scatterPlot"),
      
      hr(),
      
      # Additional plots
      h4("ABV Distribution by State"),
      plotOutput("stateBoxplot"),
      
      hr(),
      
      h4("IBU Distribution by State"),
      plotOutput("stateIBUBoxplot")
      
    )
  )
)

