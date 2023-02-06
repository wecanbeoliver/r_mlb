type <- c("name","batter_id","AB","R_SL","R_FAl","R_FAs","R_FTl","R_FTs","R_CU","R_CH","L_SL","L_FAl","L_FAs","L_FTl","L_FTs","L_CU","L_CH")
# home.start.1 = 607043
# home.start.2 = 516782
# home.start.3 = 596019
# home.start.4 = 624413
# home.start.5 = 643446
# home.start.6 = 500871
# home.start.7 = 641645
# home.start.8 = 663905
# home.start.9 = 621512
# away.start.1 = 595777
# away.start.2 = 630105
# away.start.3 = 592518
# away.start.4 = 608577
# away.start.5 = 572228
# away.start.6 = 543333
# away.start.7 = 543592
# away.start.8 = 663757
# away.start.9 = 682928

away_table <- c(away.start.1,away.start.2,away.start.3,away.start.4,away.start.5,away.start.6,away.start.7,away.start.8,away.start.9)

away_batter_tibble <- tibble(type = type)



for (i in away_table){
  temp <- convert_to_vs_pitch_type(i)
  away_batter_tibble <-  bind_cols(away_batter_tibble,  temp)
  
}

home_table <- c(home.start.1,home.start.2,home.start.3,home.start.4,home.start.5,home.start.6,home.start.7,home.start.8,home.start.9)

home_batter_tibble <- tibble(type = type)



for (i in home_table){
  temp <- convert_to_vs_pitch_type(i)
  home_batter_tibble <-  bind_cols(home_batter_tibble, temp)
}





