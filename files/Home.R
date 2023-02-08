#타자

Home_batters_table <- c(656775,668939,683002,623993,663624,602104,669065,669720,622761)
Home_batters_table <- unique(Home_batters_table)



Home_batters <- convert_to_vs_pitch_type(Home_batters_table[1])


for (i in Home_batters_table[-1]){
  Home_batters <- bind_rows(Home_batters,convert_to_vs_pitch_type(i))
  
}


write_xlsx(Home_batters, "Home_batters.xlsx")


#투수

Home_pitcher <- convert_to_ultimate_pitcher(607644)


