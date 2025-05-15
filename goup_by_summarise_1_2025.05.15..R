library(dplyr)
#describe()
#library(tidyverse)
library(dlookr)
library(tidyverse)
library(psych)

#str(rdata)
#summary(rdata)

#1. 데이터 로딩
rdata <- read.csv("떡볶이 설문.csv", fileEncoding="euc-kr")

#2. select
#rdata %>% select(친구:혼자) %>% describe() %>% write.csv("select01.csv")
rdata %>% select(친구:혼자) %>% describe()
rdata %>% select(친구:혼자) %>% describe() %>% select(vars, mean, sd) %>% write.csv("select02.csv", fileEncoding="euc-kr")

#3. filter
data <- rdata %>% filter(성별=="여") %>% select(친구:혼자)
data <- rdata %>% filter(성별=="여") %>% select(친구:혼자) %>% describe()

data <- rdata %>% filter(선호도>3) %>% select(친구:혼자)
data <- rdata %>% filter(성별=="여" & 선호도>3) %>% select(친구:혼자)


#4. group_by
data <- rdata %>% group_by(성별) %>% select(친구:혼자)
data <- rdata %>% group_by(성별, 구분) %>% select(친구:혼자)

#5. mutate
data <- rdata %>% mutate(친구=as.factor(친구))
str(data)
data <- rdata %>% mutate(친구=as.numeric(친구))

#data <- rdata %>% mutate(sum=rowsums(rdata %>% select(친구:혼자)))

data <- rdata %>% mutate(sum=rowSums(rdata %>% select(친구:혼자)))
summary(data)
