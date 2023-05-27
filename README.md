# Google Data Analytics Capstone: Cyclistic Case Study
Course: [Google Data Analytics Capstone: Complete a Case Study](https://www.coursera.org/learn/google-data-analytics-capstone?specialization=data-analytics-certificate)
## Introduction

In this case study, I will assume the role of a junior marketing analyst at a Chicago base bike-share company, Cyclistic. To answer the key business questions, I will follow the steps of the data analysis process: Ask, Prepare, Process, Analyze, Share, and Act.
## Quick links:

Data Source: [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) [Data accessed 05/23]

## Background

### Cyclistic
A bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day.

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members.

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Moreno (the director of marketing and my manager) believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs.

Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.

### Scenario
I am assuming the role of a junior marketing analyst at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, my team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve our recommendations, so they must be backed up with compelling data insights and professional data visualizations.

## Ask
### Business Task
Devise marketing strategies to convert casual riders to members.

### Analysis Questions

Three questions will guide the future marketing program:
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

Moreno has assigned me the first question: How do annual members and casual riders use Cyclistic bikes
differently?

## Prepare

### Data Source
I will be anaylzing data and identifying trends from the last 12 months of data from [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) provided by Google and made available by Motivate International Inc. under this [license](https://ride.divvybikes.com/data-license-agreement). Data-privacy issues prohibit the use of personally identifying information, meaning that pass purchases cannot be connected to credit card infromation to determine if casual riders live within the company service area or if they have purchased multiple passes.

### Data Structure
Each file available contains data for one month, saved under the naming convention of YYYYMM-divvy-tripdata. The spread sheets contain information for each trip taken incuding bike type, start and end time, start and end station, start and end location, and if the rider is an annual member or not. The column names are as follows: ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, and member_casual.

I have added columns ride_length and day_of_week to add how long rides last, and which days of the week rides occur on to my analysis.

## Process
### Microsoft SQL Server
I will be using MSQLS to merge and work with the various data sets, as the combined number of entries from the last year exceed the limit of rows Excel can be used for.

### Condensing Data
The dataset being used does not have any relational elements, so keeping the data sets separate will needlessly increase the complexity of each query. As such, I have elected to condense all of the data down into a single database named 'last_12_months' for exploration. This database contains 5,859,061 entiries.

### Converting Data type
The column 'ride_length' was displaying as a datetime value, leading to an incorrect representation of the data. To correct this, a small edit to the table needed to be done, alltering the column data type to time(0) leaves us with the correct format and values in the column.

### Exploring the Data
In order to better analyze the data, I first need to spend some time famliarizing myself with it. To do so, I am finding answers to the following questions about the data set:
  1. What data types am I working with?
  2. Are there any duplicate values?
  3. How many null values are in my data?
  4. How many types of bike are available?
  5. How many trips are from members? From casuals?
  6. What data can be removed?

#### What data types am I working with?
MSSSQLSERVER managment studio offers a very simple way to view the data types, and check if a column allows for null values. Using the right-click, 'Design' feature brings us to a chart showing the column names, data types, and a check box for if null values are alllowed.
![Screenshot 2023-05-26 193019](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/91e44b7c-15c1-4a82-b6f4-30bd9db13b7b)

As we can see here, the data I have is nvarchar, float or time/date data, which is to be expected as I dont see myself needing to do much arithmatic exploration in this data set. 

#### Are there any duplicate values?
In order to check for duplicate entries, I could have used the integrated features of Excel, but to save time I've waited until now. I want to examine the count of all entires, and subtract the count of the distinct entries to evaluate how many duplicate values there are. I'll use the ride_id column for this, as I expect this to not have duplicate or null values.
![Screenshot 2023-05-26 204542](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/a3d6fe60-3428-4a0b-8123-ece6d2f2ae8e)

Great, now we know that the ride_id column has no duplicate values and each entry will represent a distinct ride. However, I'm still operating on the assumtion that there are no null values in the column, so lets make sure of that.

#### How many null values are in my data?
While I'm ensuring that there are no nulls in my ride_id column, lets look at all of the columns too.
![Screenshot 2023-05-26 204926](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/37418228-1242-49ed-a5ae-2ed86668825c)

Great, we now know that there are no null values in the ride_id, rideable type, started_at, ended_at, start_lat, start_lng, and member_casual columns. But we will make note of the 831447 missing values in start_station_name, 1749342 missing in start_station_id, 889075 missing in end_station_name, 1449546 in end_station_id, and 5970 missing from both end_lat and end_lng.

#### Are there any ride ID's that are the incorrectly formated?
Each ride ID is a 16 character long string, so lets check and see if there are any entries that are not 16 characters long.
![Screenshot 2023-05-26 210424](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/ed6e5d4a-f116-4c1e-95a9-ab78916af823)

Good. There are no trips to delete from the table.

#### How many types of bike are available?
Becasue I'd like to include which bike types are bing used in my analysis, i'll go ahead and quickly check how many distinct values are in the rideable_type column, and what percentage of the rides they represent

![Screenshot 2023-05-26 212551](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/faa55bad-a8de-4b91-bf5b-8b7767a8545d)

#### How many trips are from members? From casuals?
Another quick query to see the proportions of member vs casual rides.

![Screenshot 2023-05-26 213042](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/2d724122-12d5-45b7-a4dc-82c79177a637)

#### What data can be removed?
There are 103 entries where the end dates precede the start dates.

![Screenshot 2023-05-26 222545](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/a8ef9bb2-114f-413d-af06-00ab40b6a56f)

We can remove those, as they are erroneous.

![Screenshot 2023-05-26 223005](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/7051609c-614f-4c02-9b36-58fe7523a605)

When analyzing this data with the end goal of understanding how members and casual riders differ in their use of Cyclistic bikes, the ID's of the start and end stations are not particularly relevant, so I am comfortable removing the columns. 

![Screenshot 2023-05-26 223706](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/cf46895a-94b0-47db-85d6-691e86a02ce9)

However, being able to analyze and visualize the distance between the start and end points would provide very valuable insight, so I'll also remove the 5970 records that are missing their end_lat and end_lng values.

![Screenshot 2023-05-26 223948](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/99c59993-e905-4847-aad1-4b7fd51e534d)

I'll also go ahead and remove the entires that are missing the start and end staion names, as that information will be valuable for vizualization and the missing data will make analysis more difficult, if not impossible.

![Screenshot 2023-05-26 224521](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/5c9618c0-1c00-4759-83cf-879a937a3331)

I've removed a total of 1,324,024 rows due to incomplete data. With that many entries missing data, it would probably be a good idea to contact the data engineers to inform them of a potential issue.

Analyze




























