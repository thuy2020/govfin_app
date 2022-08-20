div(
  class = "navbar",
  navbarPage(
    title = div(
      img(
        src = "https://reason.org/wp-content/themes/reason-dot-org-theme/resources/assets/img/logos/logo-horizontal.svg",
        height = "25px"
      ),
      ""),
    theme = "css/custom.css",
    collapsible = T,
    position = "static-top",
    
    
    tabPanel("Home",
             mod_home_ui("all_entities_ratios")
    ),
    
    tabPanel("Government Types",
             mod_government_types_ui("government_types")
    ),

    tabPanel("Entities",
             mod_entities_ui("top5_ranking"),
             mod_entities_download_data_ui("download_data")
    ),
    
    tabPanel("About",
             mod_about_ui("about")
    )
  )
)