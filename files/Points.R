Home_batter_edited <- read_excel("Home_batters.xlsx")
Away_batter_edited <- read_excel("Away_batters.xlsx")

Home_point <- 0
Away_point <- 0

points_table <- c("R_SL","R_FAl","R_FAs","R_FTl","R_FTs","R_CU","R_CH","L_SL","L_FAl","L_FAs","L_FTl","L_FTs","L_CU","L_CH")

#points of Away

for (i in points_table){
  if (Home_pitcher[i]!=-1){
    for (x in Away_batter_edited[[i]]){
      Away_point <- as.numeric(Away_point) + as.numeric(Home_pitcher[i]*x)
    }
  }
}


#points of Home

for (i in points_table){
  if (Away_pitcher[i]!=-1){
    for (x in Home_batter_edited[[i]]){
      Home_point <- as.numeric(Home_point) + as.numeric(Away_pitcher[i]*x)
    }
  }
}


if(Home_point > Away_point){
  print("Home win")
  sprintf("Home : %f, Away : %f",Home_point,Away_point)
} else {
  print("Away win")
  sprintf("Home : %f, Away : %f",Home_point,Away_point)
}