import cx_Oracle
import numpy as np
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import chart_studio
import chart_studio.plotly as py
import chart_studio.dashboard_objs as dashboard

chart_studio.tools.set_credentials_file(username='DovIra', api_key='*********')
con = cx_Oracle.connect('test/passtest@//localhost:1521/xe')
cursor = con.cursor()


def fileId_from_url(url):
    url_raw = url.split('/')
    cleared = [s.strip('~') for s in url_raw]  # remove the ~
    nickname = cleared[3]
    id = cleared[4]
    fileId = nickname + ':' + id
    return fileId


# ----query1------
query_1 = """select
LOCATIONS.LOCATION_NAME as location_name, sum(RAINFALL) as sum_rainfall
from WEATHER
join LOCATIONS on LOCATIONS.LOCATION_NAME = WEATHER.location_code
group by LOCATION_CODE
order by sum(RAINFALL) desc
FETCH FIRST 5 ROWS ONLY
"""

cursor.execute(query_1)

val_query1 = list()
lab_query1 = list()

for location_name, sum_rainfall in cursor:
    val_query1.append(sum_rainfall)
    lab_query1.append(location_name)

# ----end query1-----
# ----query2------
query_2 = """select LOCATIONS.LOCATION_NAME as location_name, sum(RAINFALL) as sum_rainfall
from WEATHER
join LOCATIONS on LOCATIONS.LOCATION_NAME = WEATHER.location_code
where extract(year from WEATHER_DATE) = 2017
group by LOCATION_CODE
"""

cursor.execute(query_2)

val_query2 = list()
lab_query2 = list()

for location_name, sum_rainfall in cursor:
    val_query2.append(sum_rainfall)
    lab_query2.append(location_name)

# ----end query2-----
# ----query3------

query_3 = """select
       to_char(WEATHER_DATE,'Month') as month_name,
       extract(month from WEATHER_DATE) as month_number,
       ROUND(avg((MINTEMP+MAXTEMP)/2),2) as avg_temperature
from weather
where extract(year from WEATHER_DATE) = 2017
group by to_char(WEATHER_DATE,'Month'), extract(month from WEATHER_DATE)
order by extract(month from WEATHER_DATE)"""

cursor.execute(query_3)

val_query3 = list()
lab_query3 = list()

for month_name, month_number, avg_temperature in cursor:
    val_query3.append(avg_temperature)
    lab_query3.append(month_name)

# ----end query3-----
bar = go.Bar(
    x=lab_query1,
    y=val_query1
)
graph_query1 = py.plot([bar], auto_open=False, filename='task 1')

pie = go.Pie(
    labels=lab_query2,
    values=val_query2
)
graph_query2 = py.plot([pie], auto_open=False, filename='task 2')

scatter = go.Scatter(
    x=lab_query3,
    y=val_query3
)
graph_query3 = py.plot([scatter], auto_open=False, filename='task 3')

cursor.close()
con.close()

# dashboard creation ---------------------------------------------------

my_board = dashboard.Dashboard()
box_1 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': fileId_from_url(graph_query1),
    'title': '1 запит-перші 5 локацій з мах числом опадів'
}
box_2 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': fileId_from_url(graph_query2),
    'title': '2 запит-кількість опадів у % по містах Австралії за 2017р',

}
box_3 = {
    'type': 'box',
    'boxType': 'plot',
    'fileId': fileId_from_url(graph_query3),
    'title': '3 запит-динаміка середньої температури у 2017 році по місяцям'
}

my_board.insert(box_1)
my_board.insert(box_2, 'below', 1)
my_board.insert(box_3, 'right', 2)

py.dashboard_ops.upload(my_board, 'Iriska')
