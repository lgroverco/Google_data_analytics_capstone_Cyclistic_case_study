library(tidyverse)
library(readr)
last_12_months <- read_csv("CyclisticPortfolio/tripdata/last-12-months.csv", 
                           +     col_types = cols(started_at = col_datetime(format = "%Y-%m-%d %H:%M:%S"), 
                                                  +         ended_at = col_datetime(format = "%Y-%m-%d %H:%M:%S"), 
                                                  +         ride_length = col_time(format = "%H:%M:%S")))
last_12_months <- subset(last_12_months, as.numeric(difftime(ended_at, last_12_months$started_at, units = "mins"))<= 1500)  
member <- subset(last_12_months, member_casual == "member")
casual <- subset(last_12_months, member_casual == "casual")
mem_len <- difftime(member$ended_at, member$started_at, units = "mins")
cas_len <- difftime(casual$ended_at, casual$started_at, units = "mins")
mean(mem_len)
median(mem_len)
mean(cas_len)
median(cas_len)
mem_per_day <- table(member["day_of_week"])
cas_per_day <- table(casual["day_of_week"])

ggplot(data=last_12_months)+
  geom_count(mapping=aes(x=member_casual, y=rideable_type))

ggplot(data=last_12_months, aes(x=rideable_type,y=as.numeric(difftime(last_12_months$ended_at, last_12_months$started_at, units="mins"))))+
  geom_boxplot()+
  facet_wrap(vars(member_casual))

ggplot(data=last_12_months)+
  geom_col(mapping=aes(x=day_of_week,y=as.numeric(length(last_12_months)),color=rideable_type))+
    facet_wrap(vars(member_casual))