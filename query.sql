-- query1
select
LOCATIONS.LOCATION_NAME, sum(RAINFALL) as sum_rainfall
from WEATHER
join LOCATIONS on LOCATIONS.LOCATION_NAME = WEATHER.location_code
group by LOCATION_CODE
order by sum(RAINFALL) desc
FETCH FIRST 5 ROWS ONLY
;
-- query2
select LOCATIONS.LOCATION_NAME, sum(RAINFALL) as sum_rainfall
from WEATHER
join LOCATIONS on LOCATIONS.LOCATION_NAME = WEATHER.location_code
group by LOCATION_CODE
order by 2 desc
;

-- query3
select
       to_char(WEATHER_DATE,'Month'),
       extract(month from WEATHER_DATE),
       ROUND(avg((MINTEMP+MAXTEMP)/2),2) as avg_temperature
from weather
where extract(year from WEATHER_DATE) = 2017
group by to_char(WEATHER_DATE,'Month'), extract(month from WEATHER_DATE)
order by extract(month from WEATHER_DATE)
