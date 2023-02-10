전제 : 승부는 선발과 선발 타자들과의 결과로 결정난다. 만약 선발이 타자들에게 공략을 잘 당할 경우 질 확률이 높아지고 반대로 잘 막을 경우 이길 확률이 높아진다.

#### #라이브러리

`baseballr, dplyr, readxl, writexl`

# #타자

## \#(왼 of 오)른손 잡이별, 구종별 상대 성적

## `convert_to_vs_batter(id)`

### #데이터

### `convert_to_statcast_22_batter(id)`

### #패스트볼 제외

### `convert_to_value(data,p_throws,p_type)`

### #홈런, 안타, 사구, 볼넷

### `convert_to_events(data,p_throws,p_type,events)`

### #볼

### `convert_to_filter(data3,p_throws3,p_type3)`

###### (홈런:1.7, 3루타:1.37, 2루타:1.08, 안타:0.77, 사구:0.65, 볼넷:0.62, 거른 볼:0.1) 출처:나무위키

###### #패스트볼

### `convert_to_fastball_value(data,p_throws,p_type,velocity)`

### #홈런, 안타, 사구, 볼넷

#### `convert_to_fastball_events(data,p_throws,p_type,events,velocity)`

#### #볼

#### `convert_to_fastball_filter(data,p_throws,p_type,velocity)`

## #엑셀 파일에 선수 스탯 추가하기

## combine_stat_with_xlxs(ID,address)

# #투수

## #투수 타자별, 구종별 ratio

## #convert_to_vs_batter(ID)

###### 공식: BAbip \* hits/(전체-볼) convert_to_vs_batter

### #데이터 생성

### #convert_to_statcast_22_pitcher(ID)

### #BAbip 추출

### convert_to_BAbip(name)

### #투수 비율 측정(패스트볼 제외)

### convert_to_ratio(data,stand,p_type)

#### #안타 이상 개수

#### convert_to_hits_pitcher(data,stand,p_type)

#### #전체-볼

#### convert_to_ab_except_ball(data,stand,p_type)

### #투수 비율 측정(패스트볼)

### convert_to_ratio_fastball(data,stand,p_type,velocity)

#### #투수 비율 측정(패스트볼)

#### convert_to_hits_pitcher_fastball(data,stand,p_type,velocity)

#### #전체-볼

#### convert_to_ab_except_ball_fastball(data,stand,p_type,velocity)

## #투수 ratio 엑셀

## combine_stat_with_xlxs_pitcher(id,address)

## #투수의 (우 or 좌) 타자별 구종 퍼센티지 (5퍼센트 이하 폐지)

## convert_to_percentage(id)

### #데이터 생성

### #convert_to_statcast_22_pitcher(ID)

### #각 구종별, 타자별 퍼센티지(패스트볼 제외)

### convert_to_percentage_pitcher(data,stand,p_type)

### #각 구종별, 타자별 퍼센티지(패스트볼 제외)

### convert_to_percentage_pitcher_fastball(data,stand,p_type,velocity)

## \# 투수 통합 구종 타자별 ratio \* percentage

## convert_to_ultimate_pitcher(id)

### #투수 타자별, 구종별 ratio

### #convert_to_vs_batter(ID)

### #투수의 (우 or 좌) 타자별 구종 퍼센티지 (5퍼센트 이하 폐지)

### convert_to_percentage(id)

## **License**

The **`baseballr`** package is released under the [**MIT License**].
