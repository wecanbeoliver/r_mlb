library(baseballr)
library(dplyr)
library(readxl)
library(writexl)

# statcast_22 형태로 출력하는 함수
convert_to_statcast_22_batter <- function(id){
  temp <-  statcast_search_batters("2022-04-07","2022-10-05", batterid = id)
  result <- temp %>% select(c("player_name","pitch_type","release_speed","events","description","zone","des","stand","p_throws","type","bb_type"))
  result <- as_tibble(result)
  return(result)
}
#가치있는 값(events의 개수)을 반환
convert_to_events <- function(data1,p_throws1,p_type1,events1){
  event_count <- nrow(filter(data1, (p_throws==p_throws1) & (pitch_type %in% p_type1) & (events %in% events1)))
  return(event_count)
}
#볼 골라낸것
convert_to_filter <- function(data2,p_throws2,p_type2){
  filter_ball <- nrow(filter(data2, (p_throws==p_throws2) & (pitch_type %in% p_type2) & ( ( (11<=zone & zone<=14) & type == "B"))))
  return(filter_ball)
}
#계수들은 나무위키의 wOBA 참조
convert_to_value <- function(data3,p_throws3,p_type3){
  homerun <- convert_to_events(data3,p_throws3,p_type3,c("home_run"))
  triple <- convert_to_events(data3,p_throws3,p_type3,c("triple"))
  double <- convert_to_events(data3,p_throws3,p_type3,c("double"))
  single <- convert_to_events(data3,p_throws3,p_type3,c("single"))
  hit_by_pitch <- convert_to_events(data3,p_throws3,p_type3,c("hit_by_pitch"))
  walk <- convert_to_events(data3,p_throws3,p_type3,c("walk"))
  filter_ball <- convert_to_filter(data3,p_throws3,p_type3)
  
  value <- 1.7*homerun+1.37*triple+1.08*double+0.77*single+0.65*hit_by_pitch+0.62*walk+0.1*filter_ball
  return(100*value/(nrow(filter(data3, p_throws==p_throws3 & pitch_type %in% p_type3))))
}

#속도 구분이 있는 패스트볼

convert_to_fastball_events <- function(data4,p_throws4,p_type4,events4,speed4){
  if(speed4=="l"){
    event_count <- nrow(filter(data4, (release_speed >= 95)&(p_throws==p_throws4) & (pitch_type %in% p_type4) & (events %in% events4)))
    return(event_count)
  }
  else {
    event_count <- nrow(filter(data4,  (release_speed < 95)&(p_throws==p_throws4) & (pitch_type %in% p_type4) & (events %in% events4)))
    return(event_count)
  }
 
}

convert_to_fastball_filter <- function(data5,p_throws5,p_type5,speed5){
  if(speed5=="l"){
    filter_ball <- nrow(filter(data5, (release_speed >= 95)&(p_throws==p_throws5) & (pitch_type %in% p_type5) & ( ( (11<=zone & zone<=14) & type == "B"))))
    return(filter_ball)
  }
  else{
    filter_ball <- nrow(filter(data5, (release_speed < 95)&(p_throws==p_throws5) & (pitch_type %in% p_type5) & ( ( (11<=zone & zone<=14) & type == "B"))))
    return(filter_ball)
  }
}

convert_to_fastball_value <- function(data6,p_throws6,p_type6,speed6){
  homerun <- convert_to_fastball_events(data6,p_throws6,p_type6,c("home_run"),speed6)
  triple <- convert_to_fastball_events(data6,p_throws6,p_type6,c("triple"),speed6)
  double <- convert_to_fastball_events(data6,p_throws6,p_type6,c("double"),speed6)
  single <- convert_to_fastball_events(data6,p_throws6,p_type6,c("single"),speed6)
  hit_by_pitch <- convert_to_fastball_events(data6,p_throws6,p_type6,c("hit_by_pitch"),speed6)
  walk <- convert_to_fastball_events(data6,p_throws6,p_type6,c("walk"),speed6)
  filter_ball <- convert_to_fastball_filter(data6,p_throws6,p_type6,speed6)
  
  value <- 1.7*homerun+1.37*triple+1.08*double+0.77*single+0.65*hit_by_pitch+0.62*walk+0.1*filter_ball
  if (speed6=="l"){
    return(100*value/(nrow(filter(data6, release_speed>=95 & p_throws==p_throws6 & pitch_type %in% p_type6))))
  }
  else{
    return(100*value/(nrow(filter(data6, release_speed<95 & p_throws==p_throws6 & pitch_type %in% p_type6))))
  }
}



convert_to_vs_pitch_type <- function(id){
  
  data <- convert_to_statcast_22_batter(id)
  data <- tibble(data)
  
  #오른손 상대
  #슬라이더, 커터 비율
  R_SL_ratio <- convert_to_value(data,"R",c("SL","FC"))
  #채인지업 비율
  R_CH_ratio <- convert_to_value(data,"R",c("CH"))
  #커브 비율
  R_CU_ratio <- convert_to_value(data,"R",c("CU"))
  # 포심패스트볼(95마일 이하) 비율
  R_FAs_ratio <- convert_to_fastball_value(data,"R",c("FA","FF"),'s')
  # 포심패스트볼(95마일 이상) 비율
  R_FAl_ratio <- convert_to_fastball_value(data,"R",c("FA","FF"),'l')
  # 투심패스트볼+싱커(95마일 이하) 비율
  R_FTs_ratio <- convert_to_fastball_value(data,"R",c("FT","FS","SI"),'s')
  # 투심패스트볼+싱커(95마일 이상) 비율
  R_FTl_ratio <- convert_to_fastball_value(data,"R",c("FT","FS","SI"),'l')
  R_mean <- mean(c(R_SL_ratio,R_CH_ratio,R_CU_ratio,R_FAs_ratio,R_FAl_ratio,R_FTs_ratio,R_FTl_ratio))
  #왼손 상대
  #슬라이더, 커터 비율
  L_SL_ratio <- convert_to_value(data,"L",c("SL","FC"))
  #채인지업 비율
  L_CH_ratio <- convert_to_value(data,"L",c("CH"))
  #커브 비율
  L_CU_ratio <- convert_to_value(data,"L",c("CU"))
  # 포심패스트볼(95마일 이하) 비율
  L_FAs_ratio <- convert_to_fastball_value(data,"L",c("FA","FF"),'s')
  # 포심패스트볼(95마일 이상) 비율
  L_FAl_ratio <- convert_to_fastball_value(data,"L",c("FA","FF"),'l')
  # 투심패스트볼+싱커(95마일 이하) 비율
  L_FTs_ratio <- convert_to_fastball_value(data,"L",c("FT","FS","SI"),'s')
  # 투심패스트볼+싱커(95마일 이상) 비율
  L_FTl_ratio <- convert_to_fastball_value(data,"L",c("FT","FS","SI"),'l')
  #총 횟수
  sum <- nrow(filter(data,pitch_type != "EP"))
  
  #총 횟수가 너무 작을 경우 가치 없음
  
  if (sum<1000){
    year = 0
  }
  else{
    year = 22
  }
  
  #이름 형식 바꾸기 "Cole, Gerrit" 에서 "Gerrit Cole"
  name <- data %>% pull(player_name)
  name <- gsub(",", "", name)
  words <- strsplit(name, " ")[[1]]
  reversed_words <- rev(words)
  name <- paste(reversed_words, collapse = " ")
  
  result <- c(name = name,
              batter_id = id,
              AB = sum,
              Year = year,
              R_SL = R_SL_ratio,
              R_FAl = R_FAl_ratio,
              R_FAs = R_FAs_ratio,
              R_FTl = R_FTl_ratio,
              R_FTs = R_FTs_ratio,
              R_CU = R_CU_ratio,
              R_CH = R_CH_ratio,
              L_SL = L_SL_ratio,
              L_FAl = L_FAl_ratio,
              L_FAs = L_FAs_ratio,
              L_FTl = L_FTl_ratio,
              L_FTs = L_FTs_ratio,
              L_CU = L_CU_ratio,
              L_CH = L_CH_ratio)
  return(result)
  
}
#엑셀 파일에 선수 스탯 추가하기

combine_stat_with_xlxs <- function(ID,address){
  temp <- read_excel(address)
  batter_tibble <-  bind_cols(temp, convert_to_vs_pitch_type(ID))
  write_xlsx(batter_tibble, address)
}




#투수 함수

#공식: hits/(전체-볼)
convert_to_statcast_22_pitcher <- function(id){
  temp <-  statcast_search("2022-04-07","2022-10-05", playerid = id,player_type = 'pitcher')
  result <- temp %>% select(c("player_name","pitch_type","release_speed","events","description","zone","p_throws","stand","type","bb_type"))
  result <- as_tibble(result)
  return(result)
}

#안타 이상 개수

convert_to_hits_pitcher<- function(data1,stand1,p_type1){
  hits_count <- nrow(filter(data1, (stand==stand1) & (pitch_type %in% p_type1) & (events %in% c("single","double","triple","home_run"))))
  return(hits_count)
}

#전체-볼

convert_to_ab_except_ball <- function(data2,stand2,p_type2){
  sum <- nrow(filter(data2, stand==stand2 & pitch_type %in% p_type2))
  ball <- nrow(filter(data2, stand==stand2 & pitch_type %in% p_type2 & ( (11<=zone & zone<=14) & type == "B")))
  return(sum-ball)
}

#투수 비율 측정(패스트볼 제외)

convert_to_ratio <- function(data3,stand3,p_type3){
  ratio <- convert_to_hits_pitcher(data3,stand3,p_type3)/convert_to_ab_except_ball(data3,stand3,p_type3)
  return(ratio)
}

#패스트볼

#안타 이상 개수

convert_to_hits_pitcher_fastball<- function(data1,stand1,p_type1,velocity1){
  if (velocity1=="l"){
    hits_count <- nrow(filter(data1, (stand==stand1) & (release_speed >= 95) & (pitch_type %in% p_type1) & (events %in% c("single","double","triple","home_run"))))
    return(hits_count)
  }
  else{
    hits_count <- nrow(filter(data1, (stand==stand1) & (release_speed < 95)  & (pitch_type %in% p_type1) & (events %in% c("single","double","triple","home_run"))))
    return(hits_count)
  }
}

#전체-볼

convert_to_ab_except_ball_fastball <- function(data2,stand2,p_type2,velocity2){
  if (velocity2=='l'){
    sum <- nrow(filter(data2, stand==stand2 &(release_speed >= 95) & pitch_type %in% p_type2))
    ball <- nrow(filter(data2, stand==stand2 & (release_speed >= 95) & pitch_type %in% p_type2 & ( (11<=zone & zone<=14) & type == "B")))
    return(sum-ball)
  }
  else{
    sum <- nrow(filter(data2, stand==stand2 &(release_speed < 95) & pitch_type %in% p_type2))
    ball <- nrow(filter(data2, stand==stand2 & (release_speed < 95) & pitch_type %in% p_type2 & ( (11<=zone & zone<=14) & type == "B")))
    return(sum-ball)
  }
}

#투수 비율 측정(패스트볼)

convert_to_ratio_fastball <- function(data3,stand3,p_type3,velocity3){
  ratio <- convert_to_hits_pitcher_fastball(data3,stand3,p_type3,velocity3)/convert_to_ab_except_ball_fastball(data3,stand3,p_type3,velocity3)
  return(ratio)
}

convert_to_vs_batter <- function(ID){
  
  data4 <- convert_to_statcast_22_pitcher(ID)
  data4 <- tibble(data4)
  
  #이름
  name <- data4 %>% pull(player_name)
  name <- gsub(",", "", name)
  words <- strsplit(name, " ")[[1]]
  reversed_words <- rev(words)
  name <- paste(reversed_words, collapse = " ")
  
  sum <- nrow(filter(data4,pitch_type != "EP"))
  
  if (sum<1000){
    year = 0
  }
  else{
    year = 22
  }
  
  R_SL_ratio <- convert_to_ratio(data4,"R",c("SL","FC"))
  R_FAl_ratio <- convert_to_ratio_fastball(data4,"R",c("FA","FF"),"l")
  R_FAs_ratio <- convert_to_ratio_fastball(data4,"R",c("FA","FF"),"s")
  R_FTl_ratio <- convert_to_ratio_fastball(data4,"R",c("FT","FS","SI"),"l")
  R_FTs_ratio <- convert_to_ratio_fastball(data4,"R",c("FT","FS","SI"),"s")
  R_CU_ratio <- convert_to_ratio(data4,"R",c("CU"))
  R_CH_ratio <- convert_to_ratio(data4,"R",c("CH"))
  L_SL_ratio <- convert_to_ratio(data4,"L",c("SL","FC"))
  L_FAl_ratio <- convert_to_ratio_fastball(data4,"L",c("FA","FF"),"l")
  L_FAs_ratio <- convert_to_ratio_fastball(data4,"L",c("FA","FF"),"s")
  L_FTl_ratio <- convert_to_ratio_fastball(data4,"L",c("FT","FS","SI"),"l")
  L_FTs_ratio <- convert_to_ratio_fastball(data4,"L",c("FT","FS","SI"),"s")
  L_CU_ratio <- convert_to_ratio(data4,"L",c("CU"))
  L_CH_ratio <- convert_to_ratio(data4,"L",c("CH"))
  
  result <- c(name = name,
              pitcher_id = ID,
              AB = sum,
              Year = year,
              R_SL = R_SL_ratio,
              R_FAl = R_FAl_ratio,
              R_FAs = R_FAs_ratio,
              R_FTl = R_FTl_ratio,
              R_FTs = R_FTs_ratio,
              R_CU = R_CU_ratio,
              R_CH = R_CH_ratio,
              L_SL = L_SL_ratio,
              L_FAl = L_FAl_ratio,
              L_FAs = L_FAs_ratio,
              L_FTl = L_FTl_ratio,
              L_FTs = L_FTs_ratio,
              L_CU = L_CU_ratio,
              L_CH = L_CH_ratio)
  return(result)
}


combine_stat_with_xlxs_pitcher <- function(ID2,address){
  temp <- read_excel(address)
  pitcher_tibble <-  bind_cols(temp, convert_to_vs_batter(ID2))
  write_xlsx(pitcher_tibble, address)
}
