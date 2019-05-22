# ui.r
shinyUI(fluidPage(
  titlePanel("Normal Distribution"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput('mu', label = "Mean", 1,
                   min = -10, max = 10),
      #selectInput("mu", label = "Mean",
      #            choices = -3:3, selected = 1),
      numericInput("sigma", label = "Standard Deviation", 2,
                  min = 0, max = 10),
      numericInput("sampsize", label = "Sample Size", 100,
                  min = 1, max = 10000)),
    mainPanel(plotOutput("normal"))
  )
))