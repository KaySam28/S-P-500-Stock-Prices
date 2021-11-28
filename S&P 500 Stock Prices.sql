--An overview of the data
Select *
from SP


--Date with the highest trading volume

SELECT Top 1
	  convert(date, date) As Date,
	SUM(volume) AS Vol
FROM SP
GROUP BY date
ORDER BY Vol	 desc


--The two items which had the largest volume on the day of the largest volume
SELECT Top 2
	symbol,
	SUM(volume)"Volume"
FROM SP
WHERE date IN ('2015/08/24')
GROUP BY symbol
ORDER BY "Volume" DESC


--Finding the difference between high and low for all dates for Amazon


SELECT
	 convert(date, date) As Date,
	(high - low) as HighLow
FROM sp
WHERE symbol LIKE '%AMZN'
order by HighLow Desc


--On which date did Amazon (AMZN) see the most volatility, measured by the difference between the high and low price?
SELECT
	Top 1
	 convert(date, date) As Date,
	(high - low) AS HighLow
FROM sp
WHERE symbol LIKE '%AMZN'
ORDER BY HighLow desc

--On which day of the week does volume tend to be highest? Lowest?
select 
	avg(volume) as VolumePerDay,
	datename(weekday,date) as WeekDay
from sp
group by datename(weekday,date)
order by VolumePerDay desc

--If you could go back in time and invest in one stock from 1/2/2014 - 12/29/2017, which would you choose? What % gain would you realize?
--This is purely based on the sum of the opening and closing volume of each stock
SELECT top 5
	--year(date),
	symbol,
	sum("close" - "open") as  diff
FROM sp
GROUP BY symbol,year(date)
ORDER BY diff desc


--What % gain would you realize?
--As this is based on the percentaged ganed by each stock over the three year period
SELECT Top 5
	--year(date),
	symbol,
	Case when (
	sum ("close" - "open"))
	=0 then null else
	(
	"open"/
	sum ("close" - "open") *100)  
	end as diff
FROM sp
GROUP BY symbol,year(date),"open"
ORDER BY diff desc



--Stock with high volume trading
SELECT
	Top 5
	symbol,
	SUM(Volume) "Volume"
FROM sp
GROUP BY symbol
ORDER BY "Volume" DESC;

-- stock with high volume by date
SELECT 
	symbol,
	convert(date, date) As Date,
	sum(volume) "Volume"
FROM sp
GROUP BY symbol, date
ORDER BY "Volume" DESC


--The avegage opening and closing price of stock

SELECT
	symbol,
	round(avg("open"),2) as "Open",
	 round(avg("close"),2) as "Close"
FROM sp
GROUP BY symbol
ORDER BY "Close" DESC;