reate table locations(
location_name varchar(50) not null PRIMARY KEY
);

create table wind_direction(
wind_direction varchar(3) primary key
);

CREATE TABLE WEATHER (
weather_date DATE NOT NULL,
Location_code VARCHAR(50) NOT NULL REFERENCES locations(location_name),
MinTemp NUMBER(*,2) DEFAULT NULL,
MaxTemp NUMBER(*,2) DEFAULT NULL,
Rainfall NUMBER(*,2) DEFAULT NULL,
Evaporation NUMBER(*,2)  DEFAULT NULL,
Sunshine NUMBER(*,2)  DEFAULT NULL,
WindGustDir VARCHAR(3) DEFAULT NULL REFERENCES wind_direction(wind_direction),
WindGustSpeed NUMBER(*) DEFAULT NULL,
WindDir9am VARCHAR(3) DEFAULT NULL REFERENCES wind_direction(wind_direction),
WindDir3pm VARCHAR(3) DEFAULT NULL REFERENCES wind_direction(wind_direction),
WindSpeed9am NUMBER(*) DEFAULT NULL,
WindSpeed3pm NUMBER(*) DEFAULT NULL,
Humidity9am NUMBER(*) DEFAULT NULL,
Humidity3pm NUMBER(*) DEFAULT NULL,
Pressure9am NUMBER(*,2) DEFAULT NULL,
Pressure3pm NUMBER(*,2) DEFAULT NULL,
Cloud9am NUMBER(*) DEFAULT NULL,
Cloud3pm NUMBER(*) DEFAULT NULL,
Temp9am NUMBER(*,2) DEFAULT NULL,
Temp3pm NUMBER(*,2) DEFAULT NULL,
RainToday VARCHAR(3) DEFAULT NULL CHECK( RainToday IN ('No','Yes', NULL) ),
RISK_MM NUMBER(*,2) DEFAULT NULL,
RainTomorrow VARCHAR(3) DEFAULT NULL CHECK( RainTomorrow IN ('No','Yes', NULL) ),
CONSTRAINT PK_weather_location PRIMARY KEY (location_name, weather_date)
)
