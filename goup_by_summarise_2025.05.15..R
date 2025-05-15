pacman::p_load(readxl, ggpubr, car, rstatix, agricolae, ggstatsplot, reshape2, magrittr, FSA, dlookr, tidyverse)
library(dplyr)

rdata <- read.csv("진학.csv", fileEncoding="euc-kr") %>% as_tibble() %>% 
    mutate(학과=recode(학과, "건설환경공학과"="건설환경", "건설환경공학부"="건설환경",
                     "기계공학부"="기계공학", "바이오 시스템 소재학부"="바이오시스템", "바이오시스템소재학부"="바이오시스템",
                     "농업생명과학대학 바이오시스템.소재학부"="바이오시스템",
                     "식물생산과학부"="식물생산", "응용생물화학부"="응용생물화학",
                     "자연과학대학 지구환경과학부"="지구환경과학부", "지구환경과학부(물리)"="지구환경과학부",
                     "재료공학부"="재료공학", "재료공학과"="재료공학",
                     "조선해양공학과"="조선해양", "조선해양학과"="조선해양",
                     "조경.지역시스템공학부"="조경지역", "조경지역시스템공학부"="조경지역",
                     "컴퓨터공학과"="컴퓨터공학", "컴퓨터공학부"="컴퓨터공학", 
                     "화학과"="화학부", "화학생명공학과"="화생공", "화학생물공학부"="화생공"))
rdata %>% arrange(수과등급)


#1. 서울대
str(rdata)
rdata %>% filter(대학=="서울대")%>%select(전등급, 학과, 전형, 서류) %>% 
  group_by(학과, 전형, 서류) %>% 
  summarise_at(vars(전등급), list(사례수=~n(), 평균=mean, 표준편차=sd, 최소=min, 최대=max))%>%
  mutate_if(is.numeric,round,2)%>%write.csv("서울대_전등급.csv", row.names=FALSE, fileEncoding="euc-kr")


str(rdata)
#rdata %>% filter(대학=="서울대")%>%select(전등급, 학과, 전형, 서류) %>% 
  #group_by(학과, 전형, 서류) %>% 
  #summarise(list(사례수=n(), 평균=mean(전등급), 표준편차=sd(전등급), 최소=min(전등급), 최대=max(전등급)))%>%
  #mutate_if(is.numeric,round,2)%>%write.csv("서울대_전등급.csv", row.names=FALSE, fileEncoding="euc-kr")

#summarise(사례수=n(), 평균=mean(전등급), 표준편차=sd(전등급), 최소=min(전등급), 최대=max(전등급))


str(rdata)
rdata %>% filter(대학=="서울대")%>%select(전등급, 학과, 전형, 서류) %>% 
  group_by(학과, 전형, 서류) %>% 
  summarise(사례수=n(), 평균=mean(전등급), 표준편차=sd(전등급), 최소=min(전등급), 최대=max(전등급))%>%
  mutate_if(is.numeric,round,2)%>%write.csv("서울대_전등급_1.csv", row.names=FALSE, fileEncoding="euc-kr")


#summarise_at(vars(전등급), 사례수=n(), 평균=mean, 표준편차=sd, 최소=min, 최대=max) 오류
#summarise_at(vars(전등급), list(사례수=n(), 평균=mean, 표준편차=sd, 최소=min, 최대=max)) 오류
#summarise_at(vars(전등급), list(사례수=~n(), 평균=mean, 표준편차=sd, 최소=min, 최대=max)) 정상

#rdata[,c(전등급, 학과, 전형, 서류)] → 오류
#c(전등급, 학과, 전형, 서류)는 **객체(변수)**로 인식합니다.
#만약 전등급, 학과 등이 객체로 정의되어 있지 않다면 에러가 납니다.


#select("전등급", "학과", "전형", "서류") → 오류
#dplyr::select() 함수는 데이터프레임을 첫 번째 인수로 받고, 그 다음에 **열 이름을 문자열 
#없이 변수처럼 적어야 합니다.
#select("전등급", "학과", "전형", "서류")는 데이터프레임 없이 열 이름만
#문자열로 전달하기 때문에 오류 발생.