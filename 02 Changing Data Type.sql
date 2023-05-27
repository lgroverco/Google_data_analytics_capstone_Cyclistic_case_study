
-- Converting ride_length to time for correct display.
ALTER TABLE [Cyclistic].[dbo].[last_12_months]
ALTER COLUMN ride_length time(0);

