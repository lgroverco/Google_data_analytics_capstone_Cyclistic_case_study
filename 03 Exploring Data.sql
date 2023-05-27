-- Looking for duplicate values
SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM Cyclistic..last_12_months;

-- Count of NULL values in the data
SELECT 
 COUNT(*) - COUNT(ride_id) ride_id,
 COUNT(*) - COUNT(rideable_type) rideable_type,
 COUNT(*) - COUNT(started_at) started_at,
 COUNT(*) - COUNT(ended_at) ended_at,
 COUNT(*) - COUNT(start_station_name) start_station_name,
 COUNT(*) - COUNT(start_station_id) start_station_id,
 COUNT(*) - COUNT(end_station_name) end_station_name,
 COUNT(*) - COUNT(end_station_id) end_station_id,
 COUNT(*) - COUNT(start_lat) start_lat,
 COUNT(*) - COUNT(start_lng) start_lng,
 COUNT(*) - COUNT(end_lat) end_lat,
 COUNT(*) - COUNT(end_lng) end_lng,
 COUNT(*) - COUNT(member_casual) member_casual 
FROM Cyclistic..last_12_months

--Are there any ride_id values that are the wrong length
SELECT COUNT(*)
FROM Cyclistic..last_12_months
WHERE len(ride_id) != 16

-- Checking distinct rideable-type and percentage of total
SELECT DISTINCT rideable_type,
	COUNT(rideable_type) as num_rides,
	COUNT(*) * 100.0/ SUM(count(*)) over () as ride_percent
FROM Cyclistic..last_12_months
GROUP BY rideable_type;

-- Member vs non member rides
SELECT DISTINCT member_casual,
	COUNT(member_casual),
	COUNT (*) * 100.0/ SUM(COUNT(*)) over () as ride_percent
FROM Cyclistic..last_12_months
GROUP BY member_casual;

