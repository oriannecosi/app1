# Tests sur l'application Shiny

# Maële Maleysson
# Orianne Cosi
# 11/05/2020


# On charge la library de Shiny
library(shiny)

# Définir UI pour l'appli qui dessine un histogramme 
ui <- fluidPage(

    # On donne un titre à l'appli
    titlePanel("Hello l'appli Shiny !"),

    # On code une barre avec possiblité de bouger le curseur des nombres de "bins" 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # On plot l'ensemble des "bins"
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Définir un serveur logique (calcul pour donner un histogramme)
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # Cet ouptut génère les "bins", basé sur l'input$bins de  l'ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # On dessine un histogramme avec le nombre de "bins" du curseur
        # On peut changer la couleur de l'histogramme
        hist(x, breaks = bins, col = 'peachpuff', border = 'white')
    })
}

# On lance l'application 
shinyApp(ui = ui, server = server)



# Insertion d'une image

ui <- pageWithSidebar(
    headerPanel("insertion d'une image"),
    sidebarPanel(
        sliderInput("logo", "Logo R :",
                    min = 0, max = 1000,  value = 500)
    ),
    mainPanel(

# Utiliser imageOutput pour inserer l'image
        imageOutput("logoR")
    )
)

server <- function(input, output, session) {
    output$logoR <- renderImage({
        # Création d'un fichier temporaire pour enregistrer la sortie.
        # Ce fichier sera supprimé ultérieurement par renderImage
      
        outfile <- tempfile(fileext = '.png')
        
        # Générer l'image PNG
        png(outfile, width = 400, height = 300)
        hist(rnorm(input$logo), main = "Généré dans renderImage()")
        dev.off()
        
        # Retourner une liste qui contient l'image
        list(src = outfile,
             contentType = 'image/png',
             width = 400,
             height = 300,
             alt = "This is alternate text")
    }, deleteFile = TRUE)
}

shinyApp(ui, server)


