# create some test dirs
# lapply(c(1:3), function(x) {
#     dir.create(paste0(getwd(), '/', x))
#     lapply(c('a','b','c'), function(y) {
#         file.create(paste0(getwd(), '/', x, '/', x, y))
#     })  
# })

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
              tabPanel(mainPanel(fluidRow(
                             selectInput('dir_selector', #variable name
                             label = 'Select File', # Label of field
                            choices = list.files(getwd())), #list of values from current wd (working directory - pathname)
                            verbatimTextOutput('selected_dir'), #text output from function that created directory
                 #uiOutput('file_selector')
              )
            )
          )
        )
      )
}


# PART 2. DEFINITION - SERVER FXN

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

# PART 3. INTEGRATION of Shiny object = User Interface & server function defined


shinyApp(ui, server)