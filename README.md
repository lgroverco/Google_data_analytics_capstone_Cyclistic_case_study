# Google Data Analytics Capstone: Cyclistic Case Study
Course: [Google Data Analytics Capstone: Complete a Case Study](https://www.coursera.org/learn/google-data-analytics-capstone?specialization=data-analytics-certificate)
## Introduction

In this case study, I will assume the role of a junior marketing analyst at a Chicago based bike-share company, Cyclistic. To answer the key business questions, I will follow the steps of the data analysis process: Ask, Prepare, Process, Analyze, Share, and Act.
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

Moreno has assigned me the first question: How do annual members and casual riders use Cyclistic bikes differently?

## Prepare

### Data Source
I will be analyzing data and identifying trends from the last 12 months of data from [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) provided by Google and made available by Motivate International Inc. under this [license](https://ride.divvybikes.com/data-license-agreement). Data-privacy issues prohibit the use of personally identifying information, meaning that pass purchases cannot be connected to credit card information to determine if casual riders live within the company service area or if they have purchased multiple passes.

### Data Structure
Each file available contains data for one month, saved under the naming convention of YYYYMM-divvy-tripdata. The spread sheets contain information for each trip taken including bike type, start and end time, start and end station, start and end location, and if the rider is an annual member or not. The column names are as follows: ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, and member_casual.

I have added columns ride_length and day_of_week to add how long rides last, and which days of the week rides occur to my analysis.

## Process
### Microsoft SQL Server
I will be using MSQLS to merge and work with the various data sets, as the combined number of entries from the last year exceeds the limit of rows Excel can be used for.

### Condensing Data
[SQL Query](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/blob/main/01%20Union%20Data.sql)
The dataset being used does not have any relational elements, so keeping the data sets separate will needlessly increase the complexity of each query. As such, I have elected to condense all of the data down into a single database named 'last_12_months' for exploration. This database contains 5,859,061 entries.

### Converting Data type
[SQL Query](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/blob/main/02%20Changing%20Data%20Type.sql)
The column 'ride_length' was displaying as a datetime value, leading to an incorrect representation of the data. To correct this, a small edit to the table needed to be done, altering the column data type to time(0) leaves us with the correct format and values in the column.

### Exploring the Data
[SQL Query](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/blob/main/03%20Exploring%20Data.sql)
In order to better analyze the data, I first need to spend some time familiarizing myself with it. To do so, I am finding answers to the following questions about the data set:
  1. What data types am I working with?
  2. Are there any duplicate values?
  3. How many null values are in my data?
  4. How many types of bikes are available?
  5. How many trips are from members? From casuals?
  6. What data can be removed?

#### What data types am I working with?
MSSSQLSERVER management studio offers a very simple way to view the data types, and check if a column allows for null values. Using the right-click, 'Design' feature brings us to a chart showing the column names, data types, and a check box for if null values are allowed.
![Screenshot 2023-05-26 193019](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/91e44b7c-15c1-4a82-b6f4-30bd9db13b7b)

As we can see here, the data I have is nvarchar, float or time/date data, which is to be expected as I don't see myself needing to do much arithmetic exploration in this data set. 

#### Are there any duplicate values?
In order to check for duplicate entries, I could have used the integrated features of Excel, but to save time I've waited until now. I want to examine the count of all entries and subtract the count of the distinct entries to evaluate how many duplicate values there are. I'll use the ride_id column for this, as I expect this to not have duplicate or null values.
![Screenshot 2023-05-26 204542](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/a3d6fe60-3428-4a0b-8123-ece6d2f2ae8e)

Great, now we know that the ride_id column has no duplicate values and each entry will represent a distinct ride. However, I'm still operating on the assumption that there are no null values in the column, so lets make sure of that.

#### How many null values are in my data?
While I'm ensuring that there are no nulls in my ride_id column, let's look at all of the columns too.
![Screenshot 2023-05-26 204926](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/37418228-1242-49ed-a5ae-2ed86668825c)

Great, we now know that there are no null values in the ride_id, rideable type, started_at, ended_at, start_lat, start_lng, and member_casual columns. But we will make note of the 831447 missing values in start_station_name, 1749342 missing in start_station_id, 889075 missing in end_station_name, 1449546 in end_station_id, and 5970 missing from both end_lat and end_lng.

#### Are there any ride ID's that are incorrectly formatted?
Each ride ID is a 16-character long string, so let's check and see if there are any entries that are not 16 characters long.
![Screenshot 2023-05-26 210424](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/ed6e5d4a-f116-4c1e-95a9-ab78916af823)

Good. There are no trips to delete from the table.

#### How many types of bike are available?
Because I'd like to include which bike types are being used in my analysis, I'll go ahead and quickly check how many distinct values are in the rideable_type column, and what percentage of the rides they represent.

![Screenshot 2023-05-26 212551](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/faa55bad-a8de-4b91-bf5b-8b7767a8545d)

#### How many trips are from members? From casuals?
Another quick query to see the proportions of member vs casual rides.

![Screenshot 2023-05-26 213042](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/2d724122-12d5-45b7-a4dc-82c79177a637)

#### What data can be removed?
[SQL Query](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/blob/main/04%20Cleaning%20Data.sql)
There are 103 entries where the end dates precede the start dates.

![Screenshot 2023-05-26 222545](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/a8ef9bb2-114f-413d-af06-00ab40b6a56f)

We can remove those, as they are erroneous.

![Screenshot 2023-05-26 223005](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/7051609c-614f-4c02-9b36-58fe7523a605)

When analyzing this data with the end goal of understanding how members and casual riders differ in their use of Cyclistic bikes, the IDs of the start and end stations are not particularly relevant, so I am comfortable removing the columns. 

![Screenshot 2023-05-26 223706](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/cf46895a-94b0-47db-85d6-691e86a02ce9)

However, being able to analyze and visualize the distance between the start and end points would provide very valuable insight, so I'll also remove the 5970 records that are missing their end_lat and end_lng values.

![Screenshot 2023-05-26 223948](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/99c59993-e905-4847-aad1-4b7fd51e534d)

I'll also go ahead and remove the entries that are missing the start and end station names, as that information will be valuable for visualization and the missing data will make analysis more difficult, if not impossible.

![Screenshot 2023-05-26 224521](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/5c9618c0-1c00-4759-83cf-879a937a3331)

I've removed a total of 1,324,024 rows due to incomplete data. With that many entries missing data, it would probably be a good idea to contact the data engineers to inform them of a potential issue.

## Analyze
[R Code](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/blob/main/05%20Analysis%20in%20R.R)
For analysis, I will be exporting this into R, to take advantage of the power of the tidyverse library to generate visuals and the increased efficiency of R when working with large data. To do so I first exported my dataset as a .csv, then used the import wizard in R Studio to load my .csv into a dataframe called last_12_months.

![Screenshot 2023-05-27 153935](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/ac9b3ab0-4871-4254-af51-ac198fce8101)

After that, I'll look at some interesting figures like the median and mean of the ride lengths for members and casuals, as well as a table to look at the count of rides by day of the week. To do this, I first created subsets of the data based on the value in the member_casual column, then generated vectors containing the data from the ride_length column to calculate the median and mean for each subset. Using the subsets, I was also able to create a table from each subset containing a count of how many times each day occurs in the day_of_week column. Note that 1 is Sunday, and 7 is Saturday because of how the column we created in excel stored the data.

![Screenshot 2023-05-27 154719](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/876d37d0-a4dd-480a-b8cd-0a3f625c0807)

We can now note those values for use in our analysis going forward.

### Visual analysis

From here, I'll generate a few plots to see the data and look for trends. Here are some things I'm interested in looking at:
For members vs casuals
  1. Proportion of rideable_type
  2. Relationship between ride_length and rideable_type
  3. Which days are preferred by each user type

#### Proportion of rideable_type

![Screenshot 2023-05-27 172252](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/c40321dc-44f9-42b3-ae71-c1fa678eac36)

In this chart we can see that members seem to prefer classic bikes to electric bikes, and that docked bikes are only used by casual customers.

#### Relationship between ride length and bike type

![Screenshot 2023-05-27 180119](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/8b77f12d-097a-45f2-abdb-a963671f754f)

Oh. That's not very good, it seems we have some values that are skewing the data, and making the boxplot illegible. Looking at the only distinct dots visible, I think its safe to assume that no one is renting out a bike for over a day, let alone 20 days. I'll use subset() to ride length values over 1500 minutes from the dataframe, and re-generate the box plot.

![Screenshot 2023-05-27 182800](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/0606fc29-4d3d-4bbb-9a62-dca60a57fe5d)

While not much better, there is insight to be gained from this, like confidence in the scope of our data, and a better understanding of where most of our data is concentrated. Its not too surprising that the 75th percentile contains large enough values to make a box plot difficult to read, but its good confirmation.

#### Which days are preferred by each user type?

![Screenshot 2023-05-27 184031](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/488bf2a3-34a0-4d9d-9544-5cdb268c59db)

Keeping with the company expectation we can see that members ride more on work days, and casuals on weekends. Let's adjust this to break down by rideable_type.

![Screenshot 2023-05-27 221358](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/03b0e8f1-53fa-4e6d-9ab5-e92b17437895)

Much better, now we can easily see the proportions of each type of bike, per day, separated by membership status.

## Share

[Visualizations on Tableau](https://public.tableau.com/app/profile/luke.grover/viz/CyclisticVizualizationPortfolio/TripsbyEndStation)

The goal in putting together these visualizations is to help show the difference between members vs casuals and how they're using the bikes. First, we should look at the distribution of bike types across each category.

![Screenshot 2023-05-28 124252](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/42b52176-3e16-4ee3-878a-2de5e887a506)

In this set of pie charts we can see confirmation that the members have not used the docked bikes, and we also can see the ratios that make up each ride type. The percentages labeling each section are referencing each wedge's proportion of the total rides in the last year. We can see that while classic bikes make up the lion's share of the rides taken, casual customers make up a larger proportion of the electric bikes than the classic bikes, which may serve as a way of enticing conversion.

![Screenshot 2023-05-28 121710](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/4fe414de-68f7-49fe-856b-1375e666b575)

Examining graphs of the trips taken in the last year, we see some very interesting trends. The top graph is plotting trips taken per month, with summer months showing a significant uptick in rides, particularly across the casual rider-base; March to June shows a nearly 250k increase. The same trend is visible in the member base, but not as severe. This tells me that the casual riders are likely using bikes more as a method of travel and/or recreation while the weather is nicer, a fact that may be marketable.

The second graph is charting which days of the week show the most activity. Consistent with prior business knowledge, it looks like causal rides increase on the weekend, and member rides are more common on the weekday.

The third graph confirms suspicions about why weekdays are more popular with members. Looking at the hour-by-hour breakdown, we can see that members are riding the most during commuter hours, with a small uptick around lunch time. Casual riders are most active in the late afternoon, information that could be of use in generating conversion.

![Screenshot 2023-05-28 121739](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/766ac3a7-0a8d-44dc-8ee8-e43af61c519c)

Our third set of graphs shows ride duration. Broken down per month we can see more indication that the summer months bring increased use of the bikes, with the longest average casual ride duration happening in May, whereas the member rides maintain much more consistent lengths all year.

Examining the ride duration per day, we have an expected increase in duration on the weekends, stronger in the casual base than the member base. Combining this with information from the last set of charts, I think the trend of casual riders using bikes for leisure or travel on days off is beginning to cement itself. 

The final chart is showing what hours a ride starts is and the average length of those rides. With 9am to 3pm showing as the window during which the longer rides tend to happen. Through all three of these graphs, we do see that casual riders are consistently riding longer, which may serve as another axis of conversion to membership.

![Screenshot 2023-05-28 121900](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/26fa4e8e-35db-42d1-8899-e7607df11d34)

The final two charts are looking at start and end locations for members and casuals, and here we gain very valuable insight. The most popular start stations among members tend to be centered around residential areas, college campuses and business complexes, continuing to suggest that members are using our bikes for commuting. Looking at the most popular start stations for casual riders, we see that they're focused closer to tourist attractions like beaches and museums.

![Screenshot 2023-05-28 121910](https://github.com/lgroverco/Google_data_analytics_capstone_Cyclistic_case_study/assets/126990386/c2ad381c-27f4-4b95-8dfc-54742a000f7d)

Examining the end locations confirms that members are commuting from homes to work and school, as there is an increase in the use of residential stations, but the focus around college campuses and business parks remains strong. We also get reinforcement of the idea that causal riders are using bikes for leisure as the end points stay focused around attractions, parks, and other recreational spaces.

## Act

After examining the usage data between casual riders and members, we see strong evidence of the following:
  1. Casual riders generally prefer to ride on weekends in the warm months of the year, whereas members are riding more during the week.
  2. Casual rides make up about half of the total rides but are the demographic which rides for the longest duration.
  3. Casual riders are starting and ending their journeys around points of interest and recreational areas in the city.
As such, I would make the following recommendations to incentivize membership:
  1. Offer additional membership options, like weekend-er and/or seasonal memberships.
  2. Offer improved rates for members on long trips to incentivize casual conversion.
  3. Focus marketing efforts around tourist attractions and recreational spaces.



