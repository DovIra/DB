create table locations(
      location_name varchar(50) not null PRIMARY KEY
);

create table wind_direction(
      wind_direction varchar(3) primary key
);

CREATE TABLE WEATHER (
      location_name VARCHAR(50) NOT NULL REFERENCES locations(location_name),
      weather_date DATE not null,
      MinTemp FLOAt(2) DEFAULT NULL,
      MaxTemp FLOAT(2) DEFAULT NULL,
      Rainfall FLOAT(2) DEFAULT NULL,
      Evaporation FLOAT(2)  DEFAULT NULL,
      Sunshine FLOAT(2)  DEFAULT NULL,
      WindGustDir VARCHAR(3) DEFAULT NULL REFERENCES wind_direction(wind_direction),
      WindGustSpeed integer DEFAULT NULL,
      WindDir9am VARCHAR(3) DEFAULT NULL REFERENCES wind_direction(wind_direction),
      WindDir3pm VARCHAR(3) DEFAULT NULL REFERENCES wind_direction(wind_direction),
      WindSpeed9am integer DEFAULT NULL,
      WindSpeed3pm integer DEFAULT NULL,
      Humidity9am INTEGER DEFAULT NULL,
      Humidity3pm INTEGER DEFAULT NULL,
      Pressure9am FLOAT(2) DEFAULT NULL,
      Pressure3pm FLOAT(2) DEFAULT NULL,
      Cloud9am INTEGER DEFAULT NULL,
      Cloud3pm INTEGER DEFAULT NULL,
      Temp9am FLOAT(2) DEFAULT NULL,
      Temp3pm FLOAT(2) DEFAULT NULL,
      RainToday VARCHAR(3) DEFAULT NULL CHECK( RainToday IN ('No','Yes') ),
      RISK_MM FLOAT(2) DEFAULT NULL,
      RainTomorrow VARCHAR(3) DEFAULT NULL CHECK( RainTomorrow IN ('No','Yes') ),
      CONSTRAINT PK_weather_location PRIMARY KEY (location_name, weather_date)
)
