mod_entities_download_data_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    
    data_card(
      
      fluidRow(
        column(3),
        column(6,
               align = "center",
               h1("Data")
        ),
        column(3)
      ),
      fluidRow(
        column(1),
        column(10,
               p("The dataset contains more than 31 thousands entities. Search by name to view data of a specific entity."),
               p(" "),
               p(" ")
        ),
        column(1)
      ),
      downloadButton(
        "download_data", "Download data"
      ),
      DTOutput(ns("acfrs"))
    )
  )
  
}


mod_entities_download_data_server <- function(id, app_data) {
  
  server <- function(input, output, session) {
    ns <- session$ns
    
    output$acfrs <- renderDT({
      acfrs %>%
        datatable(rownames = input$show_rownames,
                  extensions = c("Buttons", "Responsive"))
    })
    
    output$download_data <- downloadHandler(
      filename = function(){
        paste0(Sys.Date(), "_acfrs.csv")},
      content = function(file) {
        acfrs %>% 
          write_csv(file)
      })
    
  }
  moduleServer(id, server)
}


