mod_home_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    
    data_card(
      
      fluidRow(
        column(3),
        column(6,
               align = "center",
               h1("Liability Ratios")
        ),
        column(3)
      ),
      fluidRow(
        column(1),
        column(10,
               p("Although most governments can sustain some level of debt, excessive liabilities can become a threat to fiscal health. In this analysis, we consider a standardized ratio of government debt burdens:  the ratio of each government’s total liabilities to its total revenues."),
               p("The plot below shows liability ratios in 50 states and DC, the largest 100 counties and cities.")
        ),
        column(1)
      ),
      plotlyOutput(ns("all_entities_liab_rev_ratio"))
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
               p("In fiscal year 2020, state and local governments reported over $7 trillion of liabilities. While this total is much less than the money owed by the federal government, it is not uniformly distributed around the country. Some states, cities, counties and special purpose governments owe much more than others."),
               
               p("In these maps, we compare the ratio of each government’s liabilities to its total revenues. This ratio gives a better indication of any given government’s ability to carry its obligations than per capita amounts because governments vary in their ability to raise revenue from their respective populations."),
              
               p("Municipal bonds account for the largest share of state and local government liabilities, but not the majority. In fact, the sum of pension and other post-employment (i.e. retiree health care liabilities) exceed bonded debt. Loans, leases and compensated absences (earned but unpaid vacation and sick leave) make up the balance of long-term liabilities. Governments also have a variety of short-term liabilities such as payables that are due within one year.")
        ),
        column(1)
      ),
      sankeyNetworkOutput(ns("liabilities_type_chart"))
    ),
    ##
    data_card(
      
      fluidRow(
        column(3),
        column(6,
               align = "center",
               h1("Liabilities by Government Category")
        ),
        column(3)
      ),
      fluidRow(
        column(1),
        column(10,
               p("States account for over a third of total reported liabilities. Among other types of general purpose governments, counties carry less debt than cities, towns and villages. Educational entities (primarily traditional K-12 school districts) owe more than $1.2 trillion with other types of special purpose governments (including transit, water, and fire districts) reported around $1.1 trillion in debt.")
        ),
        column(1)
      ),
      sankeyNetworkOutput(ns("liabilities_gov_cat_chart"))
    )
    ##
  )
}



mod_home_server <- function(id, app_data) {
  
  server <- function(input, output, session) {
    ns <- session$ns
    
    output$all_entities_liab_rev_ratio <- renderPlotly(
      all_entities_liab_rev_ratio <- readRDS("data/all_entities_liab_rev_ratio.RDS"))
    
    
    output$liabilities_type_chart <- renderSankeyNetwork(
      readRDS("data/liabilities_type_chart.RDS")
    )
    
    output$liabilities_gov_cat_chart <- renderSankeyNetwork(
      readRDS("data/liabilities_gov_cat_chart.RDS")
    )
      
  }
  moduleServer(id, server)
}
