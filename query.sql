-- query1
select
LOCATIONS.LOCATION_NAME, sum(RAINFALL) as sum_rainfall
from WEATHER_DAILY
join LOCATIONS on LOCATIONS.LOCATION_NAME = WEATHER_DAILY.location_code
group by LOCATION_CODE
order by sum(RAINFALL) desc
FETCH FIRST 5 ROWS ONLY;

-- query2
select LOCATIONS.LOCATION_NAME, sum(RAINFALL) as sum_rainfall
from WEATHER_DAILY
join LOCATIONS on LOCATIONS.LOCATION_NAME = WEATHER_DAILY.location_code
group by LOCATION_CODE
order by 2 desc
;

-- query3
select
       to_char(WEATHERDATE,'Month') as month_name,
       extract(month from WEATHERDATE) as month_number,
       ROUND(avg((MINTEMP+MAXTEMP)/2),2) as avg_temperature
from (
         SELECT WEATHER_DAILY.LOCATION_CODE,
                WEATHER_DAILY.WEATHER_DATE      as WEATHERDATE,
                MIN(WEATHER_HOURLY.TEMPERATURE) AS MINTEMP,
                MAX(WEATHER_HOURLY.TEMPERATURE) AS MAXTEMP
         FROM WEATHER_DAILY
                  JOIN WEATHER_HOURLY ON
                 WEATHER_DAILY.LOCATION_CODE = WEATHER_HOURLY.LOCATION_CODE AND
                 WEATHER_DAILY.WEATHER_DATE = WEATHER_HOURLY.WEATHER_DATE
         GROUP BY WEATHER_DAILY.LOCATION_CODE, WEATHER_DAILY.WEATHER_DATE
     )
group by to_char(WEATHERDATE,'Month'), extract(month from WEATHERDATE)
order by extract(month from WEATHERDATE)
