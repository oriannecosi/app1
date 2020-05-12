# Tests sur l'application Shiny

# Maële Maleysson
# Orianne Cosi
# 11/05/2020


# On charge la library de Shiny
library(shiny)


## Création de cases à cocher


# PARTIE UI
ui <- fluidPage(
  
  # On fait des cases à cocher
  radioButtons("Statut", label = h2("Quel statut avez-vous ? "), 
                     choices = list("Etudiant(e)" = 1, "Apprenti(e)" = 2),
                     selected = 2),
  hr(),
  fluidRow(column(2, verbatimTextOutput("value2"))),
           
  radioButtons("Statut", label = h2("Quel est votre sexe ? "), 
               choices = list("Femme" = 1, "Homme" = 2),
               selected = 2),
  
  hr(),
  fluidRow(column(2, verbatimTextOutput("value"))),
  
  titlePanel("Importation"),

sidebarLayout(
  sidebarPanel(
    fileInput(
      inputId = "image1",
      label = "Importer une image",
      accept = c('image/png', 'image/jpeg','image/jpg')
    ),
    tags$hr()
  ),
  mainPanel(
    textOutput("filename"),
    imageOutput(outputId = "Image")
  )
)
)

# PARTIE SERVER
server <- function(input, output) {
  
  # On affiche l'output
  output$value <- renderPrint({ input$radio })
  output$value2 <- renderPrint({ input$radio })
  
  re1 <- reactive({gsub("\\\\", "/", input$image1$datapath)})
  
  output$Image <- renderImage({list(src = re1())})
}

shinyApp(ui, server)


