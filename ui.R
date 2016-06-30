library(shiny)
shinyUI(fluidPage(
  titlePanel("App for predicting next word when typing text"),
  sidebarLayout(
    sidebarPanel(
      em("Instructions for using the app:"),
      p("Select the type of text, enter the text and then click the 'submit' button. It will take a while to render the next word."),
      radioButtons("radio1", label = strong("Select the type of text"), choices = list("Blog" = "blog", "News" = "news", "Twitter" = "twitter", "all of the above" = "all"), selected = "all"), 
      textInput("itext1", label = strong("Enter the text here"), value=""),
      br(),
      submitButton("Submit")
    ),
    mainPanel(
      h3("Predicted next word and probability"),
      verbatimTextOutput("otext1")
      
    )
  )
))


