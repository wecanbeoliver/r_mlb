#타자

batter_type <- c("name","batter_id","AB","Year","R_SL","R_FAl","R_FAs","R_FTl","R_FTs","R_CU","R_CH","L_SL","L_FAl","L_FAs","L_FTl","L_FTs","L_CU","L_CH")

team1_batter_tibble <- tibble(type = batter_type)
write_xlsx(team1_batter_tibble, "batter_tibble.xlsx")


combine_stat_with_xlxs(668939,"team1_batter_tibble.xlsx") 
combine_stat_with_xlxs(608070,"team1_batter_tibble.xlsx")
combine_stat_with_xlxs(545361,"team1_batter_tibble.xlsx")
combine_stat_with_xlxs(592626,"team1_batter_tibble.xlsx")
combine_stat_with_xlxs(608369,"team1_batter_tibble.xlsx")


batters_table <- c(669257,605131,518692,571970,663897,666158,621035,678246,660634,500743,572204,605141,502110,502110)
batters_table <- unique(batters_table)

team1_batters_tibble <- tibble(type = batter_type)
write_xlsx(team1_batters_tibble, "team1_batter_tibble.xlsx")
for (i in batters_table){
  combine_stat_with_xlxs(i,"team1_batter_tibble.xlsx")
}

#투수

type_pitcher <- c("name","batter_id","AB","Year","R_SL","R_FAl","R_FAs","R_FTl","R_FTs","R_CU","R_CH","L_SL","L_FAl","L_FAs","L_FTl","L_FTs","L_CU","L_CH")

pitchers_tibble <- tibble(type = type_pitcher)
write_xlsx(pitchers_tibble, "pitchers_tibble.xlsx")

combine_stat_with_xlxs_pitcher(660271,"pitchers_tibble.xlsx")
combine_stat_with_xlxs_pitcher(453286,"pitchers_tibble.xlsx")
combine_stat_with_xlxs_pitcher(434378,"pitchers_tibble.xlsx")
