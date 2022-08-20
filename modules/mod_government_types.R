mod_government_types_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    
    data_card(
      
      fluidRow(
        column(3),
        column(6,
               align = "center",
               h1("State Governments")
        ),
        column(3)
      ),
      fluidRow(
        column(1),
        column(10,
               p("States with low liability-to-revenue ratios include Tennessee, Oklahoma, Nebraska, Idaho, and Iowa in that order")
        ),
        column(1)
      ),
      plotOutput(ns("top10state"))
    ),
    #
    data_card(
      
      fluidRow(
        column(3),
        column(6,
               align = "center",
               h1("City Governments")
        ),
        column(3)
      ),
      fluidRow(
        column(1),
        column(10,
               p("Among the one hundred largest US cities, Chicago, IL was the most indebted with liabilities amounting to 617% of revenues due mostly to unfunded pension obligations. Other major cities with liabilities more than quadruple revenues were Houston, TX, Atlanta, GA and Dallas, TX."),
               p("Four cities had liability-to-revenue ratios below 100%. In ascending order by ratio these were Boise, ID, Irvine, CA, Santa Clarita, CA and Aurora, CO.")
        ),
        column(1)
      ),
      plotOutput(ns("top100_cities_ratio"))
  ),
  #
  
  #
  data_card(
    
    fluidRow(
      column(3),
      column(6,
             align = "center",
             h1("County Governments")
      ),
      column(3)
    ),
    fluidRow(
      column(1),
      column(10,
             p("Of the county governments we analyzed, Titus County, in northeastern Texas, had the highest ratio of liabilities to revenues, at 723%. Almost all the county’s debt stemmed from bonds. Its $114 million in bonded debt amounted to over $3600 per resident."),
             p("Other counties with ratios exceeding 400% were Suffolk County, NY, Wilson County, TN, Ohio County, WV and Dickens County, TX. Of these, Suffolk County is by far the largest. More than half of its $12.3 billion of reported liabilities stemmed from unfunded retiree healthcare obligations."),
             p("Many counties have not produced audited financial reports for fiscal year 2020. In most of these cases, the county was not required to produce an audit. In New England, many counties do not have governing bodies. Elsewhere, the county government does not meet thresholds for reporting. In other cases, a county is required to produce a financial statement but is very late in doing so."),
             p("Most counties in New Jersey, Arkansas and some midwestern states do not adhere to government accounting standards and thus report no liabilities as well or only some types of liabilities, so their ratios are not comparable to counties in the majority of states where GASB standards are regularly used."),
             p("Among counties with over 100,000 population that follow government accounting standards, Walworth County WI had the lowest liability to revenue ratio of less than 13%. Its pension plan (part of the Wisconsin Retirement System) and its OPEB plan were both fully funded. Weld County, CO had the second lowest ratio, 15%, Its pension plan was also fully funded.")
      ),
      column(1)
    ),
    plotOutput(ns("counties_chart"))
  ),
  #
  data_card(
    
    fluidRow(
      column(3),
      column(6,
             align = "center",
             h1("Independent School Districts")
      ),
      column(3)
    ),
    fluidRow(
      column(1),
      column(10,
             p("In some areas, K-12 education agencies do not issue audited financial statements because they operate as part of a city or county government. In this section, we consider only independent school districts, which have their own financial reports."),
             p("Large independent school districts reported less extreme levels than cities, with none exceeding 400%. Among the largest school districts by enrollment, the Chicago Board of Education had the highest liability to revenue ratio at 396%."),
             p("Other districts with ratios of 300% or higher were Frisco Independent School District, TX, Los Angeles Unified School District, CA, San Diego Unified School District, CA, and Cypress-Fairbanks Independent School District, TX in descending order."),
             p("Among GASB-compliant entities, the lowest ratio, 25%, was reported by Baltimore City Public School System, MD. This district benefits from the fact that the state has sole responsibility for its unfunded pension liability and the city has sole responsibility for its unfunded OPEB liability. Other large school districts with low liability to revenue ratios (below 85%) in ascending order were Board of Education of Shelby County, TN, Osceola County District School Board, FL, District School Board of Pinellas County, FL, Duval County Public Schools, FL, and Sarasota County District School Board, FL.")
      ),
      column(1)
    ),
    plotOutput(ns(""))
  ),
  #
  )
}


mod_government_types_server <- function(id, app_data) {
  
  server <- function(input, output, session) {
    ns <- session$ns
    
    
    output$state_map_ratio <- renderPlot(
      readRDS("state_map_ratio.RDS")
      
    )
    
    output$top10state <- renderPlot(
      #state_map_ratio <- readRDS("state_map_ratio.RDS")
      #top10state <- 
        readRDS("top10_bottom10_states.RDS")
    )
    
    output$top100_cities_ratio <- renderPlot(
      readRDS("top100_cities_ratio.RDS"))
    
    output$counties_chart <- renderPlot(
      readRDS("counties_chart.RDS")
    )
    
  }
  moduleServer(id, server)
}
