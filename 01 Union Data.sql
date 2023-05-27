
DROP TABLE IF EXISTS Cyclistic..[last_12_months];

--Combining all 12 months into a single table

SELECT *
INTO Cyclistic.dbo.last_12_months
FROM Cyclistic..[202205_tripdata]
	UNION ALL
	SELECT * FROM Cyclistic..[202206_tripdata]
	UNION ALL
	SELECT * FROM Cyclistic..[202207_tripdata]
	UNION ALL
	SELECT * FROM Cyclistic..[202208_tripdata]
	UNION ALL
	SELECT * FROM Cyclistic..[202209_tripdata]
	UNION ALL
	SELECT * FROM Cyclistic..[202210_tripdata]
	UNION ALL
	SELECT * FROM Cyclistic..[202211_tripdata]
	UNION ALL
	SELECT * FROM Cyclistic..[202212_tripdata]
	UNION ALL
	SELECT * FROM Cyclistic..[202301_tripdata]
	UNION ALL
	SELECT * FROM Cyclistic..[202302_tripdata]
	UNION ALL
	SELECT * FROM Cyclistic..[202303_tripdata]
	UNION ALL
	SELECT * FROM Cyclistic..[202304_tripdata];