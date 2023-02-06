library(readxl)

type <- c("name","batter_id","AB","Year","R_SL","R_FAl","R_FAs","R_FTl","R_FTs","R_CU","R_CH","L_SL","L_FAl","L_FAs","L_FTl","L_FTs","L_CU","L_CH")

batter_tibble <- tibble(type = type)
write_xlsx(batter_tibble, "batter_tibble.xlsx")


combine_stat_with_xlxs(668939,"batter_tibble.xlsx") 
combine_stat_with_xlxs(608070,"batter_tibble.xlsx")
combine_stat_with_xlxs(545361,"batter_tibble.xlsx")
combine_stat_with_xlxs(592626,"batter_tibble.xlsx")
combine_stat_with_xlxs(608369,"batter_tibble.xlsx")
# La dodgers

La_Dodgers_table <- c(669257,605131,518692,571970,663897,666158,621035,678246,660634,500743,572204,605141,502110,502110)
La_Dodgers_table <- unique(La_Dodgers_table)

LAD_batter_tibble <- tibble(type = type)
write_xlsx(batter_tibble, "LAD_batter_tibble.xlsx")
for (i in La_Dodgers_table){
  combine_stat_with_xlxs(i,"LAD_batter_tibble.xlsx")
}
type_pitcher <- c("name","batter_id","AB","Year","R_SL","R_FAl","R_FAs","R_FTl","R_FTs","R_CU","R_CH","L_SL","L_FAl","L_FAs","L_FTl","L_FTs","L_CU","L_CH")

pitcher_tibble <- tibble(type = type_pitcher)
write_xlsx(pitcher_tibble, "pitcher_tibble.xlsx")

combine_stat_with_xlxs_pitcher(660271,"pitcher_tibble.xlsx")
combine_stat_with_xlxs_pitcher(453286,"pitcher_tibble.xlsx")
combine_stat_with_xlxs_pitcher(434378,"pitcher_tibble.xlsx")
