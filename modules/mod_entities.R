mod_entities_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    
    data_card(
      
      fluidRow(
        column(3),
        column(6,
               align = "center",
               h1("Data Exploration")
        ),
        column(3)
      ),
      #
      
      fluidRow(column(4, selectInput(ns("select_type_government"), "Select a Type of Government", choices = NULL)),
               column(4, selectInput(ns("select_name"), "Entity Name", choices = NULL))
      ),
      mainPanel(width = 15,
                tabsetPanel(
                  tabPanel("Ranking", plotlyOutput(ns("selected_gov_chart"))),
                  tabPanel("Per Capita", plotOutput(ns("percapita_plot"))),
                  tabPanel("Raw Data", plotOutput(ns("lia_rev_patched")))
                )),
      #
      fluidRow(
        column(1),
        column(10,
               p(" "),
               p("The plots above show rankings in several key indicators in 50 states and DC, the top 50 most populous counties, cities and towns, and school districts.")
        ),
        column(1)
      )
      
      #
    )
  )
}

ranking_data <- readRDS("data/ranking_data.RDS")
top_201_entities <- readRDS("data/top_201_entities.RDS")
group_mean_percap <- readRDS("data/group_mean_percap.RDS")

mod_entities_server <- function(id, app_data) {

  server <- function(input, output, session) {
    ns <- session$ns
    
    updateSelectInput(session,
                      "select_type_government",
                      choices = unique(ranking_data$gov_type))
    
    ############# begin RANKING tab
    observeEvent(input$select_type_government,
                 { entities_in_gov_type <- ranking_data %>% 
                     filter(gov_type == input$select_type_government) %>% pull(name)
                   
                   updateSelectInput(session,
                                     "select_name",
                                     choices = entities_in_gov_type)
                 })
    
    output$selected_gov_chart <- renderPlotly({
      
      selected_entity <- ranking_data %>%
      filter(gov_type == input$select_type_government & name == input$select_name)
      
      show5_gov <- ranking_data %>% 
        filter(gov_type == input$select_type_government) %>% 
        filter(Population <= (as.numeric(selected_entity$Population) + 2) & Population >= (as.numeric(selected_entity$Population) - 2))
      
      print(show5_ranking_plot(show5_gov))
    })

    ########### End ranking
    #### begin group mean tab
    output$percapita_plot <- renderPlot({
    
    each_entity_percap <- top_201_entities %>% 
      filter(gov_type == input$select_type_government & name == input$select_name) %>% # select name and group 
      mutate("Total Liabilities" = total_liabilities/population,
             "Net Pension\nLiability" = net_pension_liability/population, 
             "Revenues" = revenues/population) %>% 
      select(name, gov_type, `Total Liabilities`, `Net Pension\nLiability`, Revenues)
    
  
    percapita_data <- group_mean_percap %>% filter(gov_type == input$select_type_government) %>% # SELECT gove_type
      rbind(each_entity_percap) 
    
    print(percapita_plot(percapita_data))
    
    })
    
    #### END group mean tab
    output$lia_rev_patched <- renderPlot(
      readRDS("lia_rev_patched.RDS")
    )


  }
  moduleServer(id, server)
}




