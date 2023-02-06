library(baseballr)
library(dplyr)
batter.info <- bref_daily_batter("2022-04-08", "2022-07-21") 
pitcher.info <- bref_daily_pitcher("2022-04-08", "2022-07-21")
home.start.pitcher = "Max Scherzer"
away.start.pitcher = "Yu Darvish"
home.start.pitcher.info <- pitcher.info %>% filter(Name == home.start.pitcher)  # 홈팀 선발
away.start.pitcher.info <- pitcher.info %>% filter(Name == away.start.pitcher)  # 어웨이팀 선발
home.start.1 = "Brandon Nimmo"
home.start.2 = "Starling Marte"
home.start.3 = "Francisco Lindor"
home.start.4 = "Pete Alonso"
home.start.5 = "Jeff McNeil"
home.start.6 = "Eduardo Escobar"
home.start.7 = "Luis Guillorme"
home.start.8 = "Travis Blankenhorn"
home.start.9 = "Tomás Nido"
away.start.1 = "Jurickson Profar"
away.start.2 = "Jake Cronenworth"
away.start.3 = "Manny Machado"
away.start.4 = "Nomar Mazara"
away.start.5 = "Luke Voit"
away.start.6 = "Eric Hosmer"
away.start.7 = "Austin Nola"
away.start.8 = "Trent Grisham"
away.start.9 = "CJ Abrams"
home.start.1.info <- batter.info %>% filter(Name == home.start.1)
home.start.2.info <- batter.info %>% filter(Name == home.start.2)
home.start.3.info <- batter.info %>% filter(Name == home.start.3)
home.start.4.info <- batter.info %>% filter(Name == home.start.4)
home.start.5.info <- batter.info %>% filter(Name == home.start.5)
home.start.6.info <- batter.info %>% filter(Name == home.start.6)
home.start.7.info <- batter.info %>% filter(Name == home.start.7)
home.start.8.info <- batter.info %>% filter(Name == home.start.8)
home.start.9.info <- batter.info %>% filter(Name == home.start.9)
away.start.1.info <- batter.info %>% filter(Name == away.start.1)
away.start.2.info <- batter.info %>% filter(Name == away.start.2)
away.start.3.info <- batter.info %>% filter(Name == away.start.3)
away.start.4.info <- batter.info %>% filter(Name == away.start.4)
away.start.5.info <- batter.info %>% filter(Name == away.start.5)
away.start.6.info <- batter.info %>% filter(Name == away.start.6)
away.start.7.info <- batter.info %>% filter(Name == away.start.7)
away.start.8.info <- batter.info %>% filter(Name == away.start.8)
away.start.9.info <- batter.info %>% filter(Name == away.start.9)