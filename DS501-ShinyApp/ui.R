
library(shiny)
library(shinythemes)
library(gitlink)

shinyUI(navbarPage(theme = shinytheme("darkly"),
                  
                   "Counter Strike K-Means",
                   tabPanel(
                     "Dataset",
                     headerPanel("About"),
                     ribbon_css("https://github.com/swoosh1337/DS-Projects/tree/main/DS501-ShinyApp", text = "Github", fade = FALSE,position="left"),                  
                     mainPanel(
                       
                       "The repository of this project can be found by clicking on the link in the top left corner.
                       This Case Study3 is a clustering and correlation analysis on data from Counter Strike Global Offensive. I chose this 
                       dataset because I have been playing CSGO since 2014 and I thought it would be cool and fun to explore the data associated with it. 
                       There are several statistics in this dataset like player's name, country player is from, kill/death ratio, rating and so on.
                        A k-means clustering is a popular unsupervised machine learning algorithm. 
                        The dataset is partitioned into  a set of groups based on their simillarity.
                        The “Elbow” Method Probably is the most well known method to choose cluster numbers. Basically, the  sum of squares at each number of clusters 
                        is calculated and graphed, and  then we look for a change of slope from steep to shallow (an elbow) to determine the 
                        optimal number of clusters. This method is inexact, but good enough for my purposes. The actual plot of clusters can be seen on the last tab.
                        In the next tab, you can check the correletion graphs between different variables.
                        You can select which variables you'd like to see compared to one another and a scatterplot will be generated.
                        Correlation plot is a good way to visualize how dependent are variables on each other."
                     ),
                    
                     
                     headerPanel("Tutorial"),
                     mainPanel(
                       
                       "  In this shiny app we have several options to play with:
                       1. In the first tab, we can explore the whole dataset and look at different statistics of the players.
                       2. In the second tab we can explore the correlation plot of different features and see if there is some linear relaitonship between them.
                       We can choose different variables and see how the plot changes
                       3. In the third tab we can see K-Means analysis plot with 3 clusters.
                       4. In the foruth tabe we can manually choose number of clusters and different variables and the output.
                       5. In the last tab we can see EDA performed on this dataset."
                      
                     ),
                     mainPanel(
                       dataTableOutput('CDplot')
                     )
                     
                   ),
                 
                   tabPanel("Correlation Metrics",
                            headerPanel("CSGO Stats correlation plot"),
                            mainPanel(
                              "Here you can choose different stats and see how they correlate with each other!",
                              
                              selectInput('var1', "X Variable", variables),
                              selectInput('var2', "Y Variable", variables, selected = variables[[2]]),
                              plotOutput('correlation')
                              
                              
                            )
                            
                   ),
                   
                   tabPanel("K-Means Analysis",
                            headerPanel("Clustering Plot"),
                            mainPanel(
                              "Generally, The K-means clustering algorithm is used to find groups which have not been explicitly labeled in the data. This can be used to confirm  
                              assumptions about what types of groups exist or to identify unknown groups in complex data sets.
                              Here we can observe the k-means clustering analysis for CSGO dataset.
                                     We can observe 3 different clusters which seems to be the best from elbow plot which you can see in EDA tab.Generally, to determine the optimal 
                                     division of your data 
                                     points into clusters, such that the distance between points in each cluster is minimized, one can use the k means clustering algorithm
                                      You can observe at the bottom of the graph that
                                    the two components, on the x axis and the y axis, explain 93.62% of the point variability.
                                     which is pretty good when it comes to explaining the dataset. The higher is the percentage the less information 
                                about the data remain hidden from  our eyes. 
                              ",
                                                     
                              plotOutput('plot1')
                            )
                            
                   ),
                   
                   
                   tabPanel('K-Means Clustering',
                     headerPanel(' CSGO k-means clustering'),
                     sidebarPanel(
                       selectInput('variable1', "X Variable", variables),
                       selectInput('variable2', "Y Variable", variables, selected = variables[[2]]),
                       numericInput('cluste', 'Cluster count', 3, min = 1, max = 9)
                     ),
                     mainPanel(
                       plotOutput('plot2')
                     )),
                   
                   tabPanel("EDA", 
                           
                            titlePanel("Data analysis"), 
                            div(includeMarkdown("CS3.html"), 
                                align="justify")
                   ),

                   )) # fluidPage()