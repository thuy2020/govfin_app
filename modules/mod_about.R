mod_about_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    
    data_card(
      
      fluidRow(
        column(3),
        column(6,
               align = "center",
               h1("Government Finance Transparency Project")
        ),
        column(3)
      ),
      fluidRow(
        column(1),
        column(10,
               p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum")
        ),
        column(1)
      ),
      plotOutput(ns("type_gov_chart"))
    ),
    ##
    data_card(
      
      fluidRow(
        column(3),
        column(6,
               align = "center",
               h1("Liability by Type")
        ),
        column(3)
      ),
      fluidRow(
        column(1),
        column(10,
               p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum")
        ),
        column(1)
      ),
      plotOutput(ns("liability_chart"))
    )
    ##
    
  )
}


mod_about_server <- function(id, app_data) {
  
  server <- function(input, output, session) {
    ns <- session$ns
    
    output$type_gov_chart <- renderPlot(
      readRDS("type_gov_chart.RDS"))
    
    output$liability_chart <- renderPlot(
      readRDS("liability_chart.RDS"))
  }
  moduleServer(id, server)
}
