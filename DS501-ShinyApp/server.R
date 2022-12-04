
# library(shiny)
library(readxl)
library(cluster)
library(ggvis)
library(shinythemes)
library(tidyverse)
library(ggpubr)
library(markdown)




server <- function(input, output){
  
  
  output$CSplot = renderDataTable(
    cs_df1
  )
  output$plot1 = renderPlot(
    {clusplot(cs_df2, clusters$cluster, color=T, shade=T,labels=1,lines=1, main="CSGO K Means Clustering")
    }
  )


  output$correlation = renderPlot({
    req(input$var1)
    req(input$var2)
    x <- cs_df2[[input$var1]]
    y <- cs_df2[[input$var2]]
    plot(x, y)
  })
  

  selectedData <- reactive({
    cs_df2[, c(input$variable1, input$variable2)]
  })

  cl <- reactive({
    kmeans(selectedData(), input$cluste)
  })
  # 
  output$plot2 <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(), col = cl()$cluster,pch = 20, cex = 3)
    points( cl()$centers, pch = 4, cex = 4, lwd = 4 )
  })
}

