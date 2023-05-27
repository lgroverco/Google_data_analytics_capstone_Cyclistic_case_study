--Entries that have end dates before start dates
SELECT COUNT(*)
FROM Cyclistic..last_12_months
WHERE ended_at < started_at

--Removing those entries
DELETE FROM Cyclistic..last_12_months
WHERE ended_at < started_at;

--Dropping start and end station name from the table
ALTER TABLE Cyclistic..last_12_months
DROP COLUMN start_station_id, end_station_id

--Deleting entries without end_lat or end_lng
DELETE FROM Cyclistic..last_12_months
WHERE end_lat IS NULL or end_lng IS NULL

 --Deleting entries without start or end station names.
DELETE FROM Cyclistic..last_12_months
WHERE start_station_name IS NULL or end_station_name IS NULL