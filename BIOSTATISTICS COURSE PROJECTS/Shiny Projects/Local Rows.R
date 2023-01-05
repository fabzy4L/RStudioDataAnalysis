####
#create  a dataframe to draw from
list = c("Genomic Testing", "Consulting")

####

# Load R packages
library(shiny)

# PART 1: DEFINITION - UI LAYOUT
ui <- {
  fluidPage(theme = shinytheme("cosmo"),  
            titlePanel(
              h1("NeuReGx")
            ),
            navbarPage(
              "Genomic Testing",
              tabPanel("Services",
                        mainPanel(fluidRow(
                selectInput('dir_selector', #variable name
                            label = 'Select File', # Label of field
                            choices = list),
                verbatimTextOutput('selected_dir'), #text output from function that created directory
                #uiOutput('file_selector')
              )
              )
              )
            )
  )
}



server <- function(input, output, session) {
  
  # get selected directory from input
  output$selected_dir <- renderText(paste0('File:', input$dir_selector))
  
  # render dropdown menu of files
  output$file_selector <- renderUI({
    files <- list.files(paste0(getwd(), '/', input$dir_selector))
    selectInput('file_selector',
                label = 'Select file',
                choices = files)
  })
}


shinyApp(ui, server)
