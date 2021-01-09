library(shiny)
library(shinydashboard)
library(pdftools)
library(tidyverse)
dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
    textInput("file", "HPLC report directory "),
    fileInput("standardUpload", "Upload standard curve file", multiple = FALSE),
    h4("Up-down range for standard curve"),
    numericInput("standUp","Up",value = 0.1),
    numericInput("standDown","Down",value = 0.1),
    
    actionButton("submit1","Go!",styleclass = "success")
  ),
  dashboardBody(
    downloadButton("b", "txt"),
    br(),
    dataTableOutput("a")

    
    
 
    
  )
)






