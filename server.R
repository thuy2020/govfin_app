server <- function(input, output, session) {
  mod_comm <- reactiveValues(
    app_data = NULL
  )
  mod_home_server("all_entities_ratios")
  
  mod_government_types_server("government_types")
  
  mod_entities_server("top5_ranking")
  
  mod_entities_download_data_server("download_data")
  
  mod_about_server("about")
}