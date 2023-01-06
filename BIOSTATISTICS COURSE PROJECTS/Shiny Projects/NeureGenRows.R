####################################

# https://shiny.rstudio.com/gallery/shiny-theme-selector.html
# https://shiny.rstudio.com/articles/reactivity-overview.html





# Load R packages
library(shiny)
library(shinythemes)

#create  a dataframe to draw from
list = c("Genomic Testing", "Consulting")
theme = "cosmo"
# theme = "cerulean"
#list_wd = list.files(getwd())), #list of values from current wd (working directory - pathname)

####

# PART 1: DEFINITION - UI LAYOUT

ui <- fluidPage(theme = shinytheme(theme),  
                titlePanel(
                  h1("NeuReGx")
                ),
                navbarPage(
                  "Genomic Testing", #Title of Nav bar
                  tabPanel("Demographics", #name of 1st tab
                           sidebarPanel(
                             tags$h3("Submit a Request:"),
                             helpText("Demographic information."),
                             textInput("txt1", "First Name:", ""),
                             textInput("txt2", "Last Name:", ""),
                             #textInput("txt3", "Request Type:", ""),
                             fluidRow(
                               selectInput('txt4', #variable name
                                           label = 'Select Service', # Label of field
                                           choices = list)), #list of values from current wd (working directory - pathname)
                           # Input: Select a file ----
                           fileInput("file1", "Choose CSV File",
                                     accept = c(
                                       "text/csv",
                                       "text/comma-separated-values,text/plain",
                                       ".csv")
                           ),
                           tags$hr(),
                           checkboxInput("header", "Header", TRUE)
                           ), # sidebarPanel
                  mainPanel(h1("Review Information:"), 
                            h4("Output:"),
                             helpText("Please make sure the file contains RSIDs"),
                             h1(" "),
                             verbatimTextOutput("txtout"), # name & last name
                             verbatimTextOutput("txtout4"), #request type - ddmenu
                             verbatimTextOutput("txtout3"), #file name
                             
                             dataTableOutput('dto')
                           )
                        # mainPanel
                           
                  ) # Navbar 1, tabPanel 1
#########################################This Tabpanel interferes with the mainpanel from tabapnel1
          

#                      tabPanel("Services",
#                                    mainPanel(fluidRow(
#                                      fileInput("file1", "Choose CSV File",
#                                                accept = c(
#                                                  "text/csv",
#                                                  "text/comma-separated-values,text/plain",
#                                                  ".csv")
#                                                ),
#                                      tags$hr(),
#                                      checkboxInput("header", "Header", TRUE)
#                                      ),
#                                      dataTableOutput('dto'),
#                                      )
#         )
))
#########################################

##############################################
# navbarPage
# fluidPage


# PART 2. DEFINITION - SERVER FXN

server <- function(input, output) {
  
  output$txtout <- renderText({
    paste( "Name:", input$txt1, input$txt2, sep=" " )
  })
  
  #output$txtout2 <- renderText({
  #  paste( "Request:", input$txt3, sep = " " )
  #})
  
  output$txtout3 <- renderText({
    paste0( "File:", input$file1, sep = " " )
  })
  
  output$txtout4 <- renderText(
    {paste0('Service: ', input$txt4)
      })
  
  # Reactive expression with the data, in this case iris
  #----------------
  contents <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    inFile <- input$file1
    
    if (is.null(inFile)) return(NULL)
    
    read.csv(inFile$datapath, header = input$header)
    
  })
  #----------------
  
  #the extensions parameter coupled with the options list does the trick  
  output$dto <- renderDataTable(contents(), #extensions = 'Buttons',
                                    options = list(dom = 'Bfrtip',
                                               buttons = c('copy', 'csv', 'excel', 'pdf', 'print'))
  )
}
# PART 3. INTEGRATION of Shiny object = User Interface & server function defined

shinyApp(ui = ui, server = server)