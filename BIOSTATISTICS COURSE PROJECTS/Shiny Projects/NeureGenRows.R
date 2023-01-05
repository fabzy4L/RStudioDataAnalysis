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
                             verbatimTextOutput("txtout"), # name & last name
                             #verbatimTextOutput("txtout2"), #typed request
                             verbatimTextOutput("txtout3"), #file name
                             verbatimTextOutput("txtout4"), #request type - ddmenu
    
                           )
                        # mainPanel
                           
                  ), # Navbar 1, tabPanel 1
                  tabPanel("Upload Other Files",
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
                  
                  
                  
#########################################This Tabpanel interferes with the mainpanel from tabapnel1
          
#                  tabPanel("Services",
#                           mainPanel(fluidRow(
#                             selectInput('txt4', #variable name
#                                         label = 'Select Service', # Label of field
#                                         choices = list),
#                             verbatimTextOutput('txtout4'), #text output from function that created directory
                             #uiOutput('file_selector')
#)
#                           )
#                  ),
                 # tabPanel("FAQ", "This panel is intentionally left blank"), 

#########################################
                )
                )

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
  
  output$txtout4 <- renderText(paste0('Service: ', input$txt4))
  
  } # server


# PART 3. INTEGRATION of Shiny object = User Interface & server function defined

shinyApp(ui = ui, server = server)