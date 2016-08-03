
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(ggplot2)

get.logistic <- function(model) {
  b <- model$coefficients[[1]]
  a <- model$coefficients[[2]]
  function(x) {
    l <- a * x + b
    1 / (1 + exp(-l))
  }
}

get.linear <- function(model) {
  b <- model$coefficients[[1]]
  a <- model$coefficients[[2]]
  function(x) 
    a * x + b
}

plot.curve <- function(f, x0=10, x1=35, l=100) {
  x <- seq(x0, x1, length.out=l)
  data <- data.frame(x=x, y=f(x))
  geom_path(data=data, mapping=aes(x=x,y=y), size=1)
}

plot.resid <- function(x, y, f, colour="red") {
  df <- data.frame(x1=x, y1=f(x), x2=x, y2=y)
  geom_segment(aes(x=x1, y=y1, xend=x2, yend=y2), colour=colour, data=df)
}

fit.logistic <- glm(am ~ mpg, family="binomial", mtcars)
fit.linear <- lm(am ~ mpg, mtcars)

get_plot <- function(fit.type, plot.resid) {
  p <- ggplot(data=mtcars, mapping=aes(x=mpg, y=am)) + geom_point()
  if (fit.type == "linear")
    f <- get.linear(fit.linear)
  else
    f <- get.logistic(fit.logistic)
  p <- p + plot.curve(f)
  if (plot.resid)
    p <- p + plot.resid(mtcars$mpg, mtcars$am, f)
  p
}

library(shiny)

shinyServer(function(input, output) {
  output$residualsPlot <- renderPlot(get_plot(input$regresion, input$showResid))
})
