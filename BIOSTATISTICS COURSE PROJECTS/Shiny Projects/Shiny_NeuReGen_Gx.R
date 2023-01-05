# http://github.com/dataprofessor  #
####################################

# Modified from Winston Chang, 
# https://shiny.rstudio.com/gallery/shiny-theme-selector.html

# Concepts about Reactive programming used by Shiny, 
# https://shiny.rstudio.com/articles/reactivity-overview.html

# Load R packages
library(shiny)
library(shinythemes)

  # PART 1: DEFINITION - UI LAYOUT

  ui <- fluidPage(theme = shinytheme("cosmo"),  
                  titlePanel(
                    h1("NeuReGx")
                    ),
    navbarPage(
      # theme = "cerulean",  # <--- To use a theme, uncomment this
      "Genomic Testing", #Title of Nav bar
      tabPanel("Demographics", #name of 1st tab
               sidebarPanel(
                 tags$h3("Submit a Request:"),
                # helpText("Demographic information."),
                 textInput("txt1", "First Name:", ""),
                 textInput("txt2", "Last Name:", ""),
                 textInput("txt3", "Request Type:", ""),
                # Input: Select a file ----
                fileInput("file1", "Search",
                          multiple = TRUE,
                          accept = c("text/csv",
                                     "text/comma-separated-values,text/plain",
                                     ".csv")),
                 
                                  
               ), # sidebarPanel
               mainPanel(
                            h1("Review Information:"),
                            
                            h4("Output:"),
                            helpText("Please make sure the file contains RSIDs"),
                            h1(" "),
                            verbatimTextOutput("txtout"),
                            verbatimTextOutput("txtout2"),
                            verbatimTextOutput("txtout3"),
                            

               ) # mainPanel
               
      ), # Navbar 1, tabPanel 1
      tabPanel("Upload RSIDS",
               mainPanel(
                 h1("Upload .csv file"),
                 #h4("Output:"),
                           #actionButton("action", "Select File"),
                           #Input: Select a file ----
                           fileInput("file1", "Search",
                                     multiple = TRUE,
                                     accept = c("text/csv",
                                                "text/comma-separated-values,text/plain",
                                                ".csv")),
                        ) # mainPanel
                        
               ), # Navbar 2, tabPanel2
      #tabPanel("FAQ", "This panel is intentionally left blank"), 
      #tabPanel("*", "This panel is intentionally left blank")
  
    ) # navbarPage
  ) # fluidPage

  
  # PART 2. DEFINITION - SERVER FXN
  
  server <- function(input, output) {
    
    output$txtout <- renderText({
      paste( "Name:", input$txt1, input$txt2, sep = " " )
    })
    
    output$txtout2 <- renderText({
      paste( "Request:", input$txt3, sep = " " )
    })
    
    output$txtout3 <- renderText({
      paste0( "File:", input$file1, sep = " " )
    })
    
  } # server
  

  # PART 3. INTEGRATION of Shiny object = User Interface & server function defined
  
  shinyApp(ui = ui, server = server)
