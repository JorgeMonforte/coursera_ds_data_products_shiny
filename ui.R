
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Transmision type fittings"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      p("Select show residuals if you want to view them, choose the regression type from the select box"),
      checkboxInput("showResid", "show residuals:"),
      selectInput("regresion", "regresion type:", c("linear"="linear", "logistic"="logistic"))
      
    ),
   

    # Show a plot of the generated distribution
    mainPanel(
      p("The pourpose of this utility is two compare the fitting of two regersion models, linear and logistic of the relation of milleage and transmision type within the dataset mtcars."),
      plotOutput("residualsPlot")
    )
  )
))
