# UI
text_card <- function(..., header = NULL) {
  div(
    class = "card",
    style = "margin: 0px; border-radius: 20px;",
    header, 
    div(class = "card-content", ..., style = "background-color: #fff; margin-top: 20px; border-radius: 20px;")
  )
}

data_card <- function(..., header = NULL) {
  div(
    class = "card",
    style = "margin: 0px; border-radius: 20px",
    header, 
    div(class = "card-content", ..., style = "background-color: #fff; margin-top: 10px; border-radius: 20px;", 
        align = "left")
  )
}


mytheme <- theme(legend.position = "none",
                 panel.grid.major = element_blank(),
                 axis.text.y = element_text(face = 2, color = "white"),
                 axis.text.x = element_text(face = 2, color = "white"),
                 plot.title = element_text(hjust = .5, color = "white"),
                 plot.caption = element_text(hjust = 1, color = "white", size = 8),
                 plot.subtitle = element_text(hjust = .5, color = "white", size = 10),
                 panel.background = element_rect(fill = "black"),
                 plot.background = element_rect(fill = "black"))


show5_ranking_plot <- function(df) {
  df %>% 
    pivot_longer(cols = 4:8,
                 names_to = "ranking",
                 values_to = "value") %>% 
    ggplot(aes(ranking, value, color = name, group = name, text = name)) +
    geom_point(size = 7) +
    geom_bump(size = 2, smooth = 15) +
    mytheme +
    labs(x = "Category",
         y = "Rank",
         title = paste0("Ranking in 5 Key Indicators"),
         caption = "\nSource: \nGovernment Finance Data Transparency Project\nReason Foundation") + 
    scale_y_reverse() +
    scale_color_manual(values = wes_palette("Zissou1")) -> p
  
  ggplotly(p, tooltip = "text") %>% style(hoverlabel = list(font = list(color ="white", size = 15), 
                                                            bordercolor = "transparent"))
}



percapita_plot <- function(df) {
  df %>% 
    pivot_longer(cols = 2:4, 
                 names_to = "indicator",
                 values_to = "value"
    ) %>% 
    ggplot(aes(indicator, value, fill = name)) +
    geom_bar(stat="identity", position = position_dodge(width = 0.5), alpha = .8) + # overlapping the bars half way
    
    scale_y_continuous(labels = scales::dollar_format()) +
    scale_fill_manual(values = c("#E69F00",  "#56B4E9")) + #palette="Spectral"
    theme_minimal() +
    labs(title = "Per Capita Values",
         caption = "Note: Mean value of the top 50 entities\nin the corresponding government type") +
    
    theme_minimal_grid(font_size = 14, line_size = 0) +
    theme(
      legend.position = c(.1, .8),
      legend.text = element_text(face = 2, color = "white"),
      panel.grid.major = element_blank(),
      axis.text.y = element_text(face = 2, color = "white"),
      axis.text.x = element_text(face = 2, color = "white"), #angle = 30, hjust = 1
      plot.title = element_text(hjust = .5, color = "white"),
      plot.caption = element_text(hjust = 1, color = "white", size = 8),
      plot.subtitle = element_text(hjust = .5, color = "white", size = 10),
      panel.background = element_rect(fill = "black"),
      plot.background = element_rect(fill = "black"),
      plot.margin = margin(.5, .5, .5, .5, "cm")) 
   
}
