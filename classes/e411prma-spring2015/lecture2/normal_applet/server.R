library("ggplot2")
shinyServer(
  function(input,output){
    output$normal <- renderPlot({
      dat <- rnorm(as.numeric(input$sampsize), as.numeric(input$mu), as.numeric(input$sigma))
      qplot(dat, geom = "histogram", binwidth = 1, fill = I("white"), color = I("red")) + xlab("Score") + ylab("Frequency")
      })
  })





