# Tests sur l'application Shiny

# Maële Maleysson
# Orianne Cosi
# 11/05/2020


# On charge la library de Shiny
library(shiny)


# Création de cases à cocher


# PARTIE UI
ui <- fluidPage(
  
  # On fait des cases à cocher
  radioButtons("Statut", label = h2("Quel statut avez-vous ? "), 
                     choices = list("Etudiant(e)" = 1, "Apprenti(e)" = 2),
                     selected = 1),
  
  radioButtons("Statut", label = h2("Quel est votre sexe ? "), 
               choices = list("Femme" = 1, "Homme" = 2),
               selected = 1),
  
  hr(),
  fluidRow(column(2, verbatimTextOutput("value")))
  
  
)

# PARTIE SERVER
server <- function(input, output) {
  
  # On crée l'output
  output$value <- renderPrint({ input$radio })
  
}

shinyApp(ui, server)


