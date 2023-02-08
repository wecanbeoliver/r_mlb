#### #라이브러리

`baseballr, dplyr, readxl, writexl`

# #타자 

##     \#(왼 of 오)른손 잡이별, 구종별 상대 성적

##       `convert_to_vs_batter(id)`

###          #데이터 

###          `convert_to_statcast_22_batter(id)`

###          #패스트볼 제외 

###          `convert_to_value(data,p_throws,p_type)` 

####              #홈런, 안타, 사구, 볼넷      

####              `convert_to_events(data,p_throws,p_type,events)` 

####              #볼 

####              `convert_to_filter(data3,p_throws3,p_type3)` 

######                          (홈런:1.7, 3루타:1.37, 2루타:1.08, 안타:0.77, 사구:0.65, 볼넷:0.62, 거른 볼:0.1) 출처:나무위키

###           #패스트볼 

###               `convert_to_fastball_value(data,p_throws,p_type,velocity)` 

####                #홈런, 안타, 사구, 볼넷 

####                 `convert_to_fastball_events(data,p_throws,p_type,events,velocity)` 

####                #볼 

####                `convert_to_fastball_filter(data,p_throws,p_type,velocity)`

#엑셀 파일에 선수 스탯 추가하기

combine_stat_with_xlxs(ID,address)

#투수

#투수 타자별, 구종별 ratio #공식: babip \* hits/(전체-볼) convert_to_vs_batter

## **License**

The **`baseballr`** package is released under the [**MIT License**](https://chat.openai.com/LICENSE).
