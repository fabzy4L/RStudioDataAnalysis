library(shiny)
library(DT)
?runApp
ui <- fluidPage(
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Choose CSV File",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")
      ),
      tags$hr(),
      checkboxInput("header", "Header", TRUE)
    ),
    mainPanel(
      # tableOutput('dto')
      dataTableOutput('dto'),
    )
  )
)

server <- function(input,output){
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
  output$dto <- renderDataTable(contents(), extensions = 'Buttons', 
                                options = list(dom = 'Bfrtip',
                                               buttons = c('copy', 'csv', 'excel', 'pdf', 'print'))
  )
}

runApp(list(ui=ui,server=server), launch.browser=TRUE)