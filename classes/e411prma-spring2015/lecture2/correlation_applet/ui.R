# ui.r
shinyUI(fluidPage(
  titlePanel("Correlations"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput('cor', label = "Correlation", 0,
                   min = -.95, max = .95, step = .05)),
    mainPanel(plotOutput("corplot"))
  )
))