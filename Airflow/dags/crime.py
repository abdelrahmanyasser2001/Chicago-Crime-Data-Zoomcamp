from airflow import DAG
from datetime import datetime , timedelta
from airflow.providers.snowflake.hooks.snowflake import SnowflakeHook
from airflow.providers.http.sensors.http import HttpSensor 
from airflow.providers.http.operators.http import SimpleHttpOperator
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator, get_current_context
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator


from io import StringIO
import requests
import os
import tarfile
import pandas as pd
import shutil


_SNOWFLAKE_CONN_ID = "snowflake_conn"
_SNOWFLAKE_TABLE = "SRC_CRIME"
_SNOWFLAKE_STAGING_TABLE = "SRC_CRIME_STAGING"
OUTPUT_DIR = "/tmp/crime_csvs"
os.makedirs(OUTPUT_DIR, exist_ok=True)




def fetch_crime_data():
    base_url = "https://data.cityofchicago.org/resource/ijzp-q8t2.csv"
    limit = 1000  
#    max_records = 50000  
    offset = 0
    all_data = []

    while True:
        url = f"{base_url}?$limit={limit}&$offset={offset}"
        response = requests.get(url)

        if response.status_code != 200:
            print(f"Error: {response.status_code}")
            break

        data = pd.read_csv(StringIO(response.text))

        if data.empty:  
            break  

        all_data.append(data)
        offset += limit  

    if all_data:
        df = pd.concat(all_data, ignore_index=True)
        output_file = os.path.join(OUTPUT_DIR, "output.csv")
        df.to_csv(output_file, index=False)
        print(f"Saved {len(df)} records to {output_file}")
    else:
        print("No data fetched.")

'''
#testing with low amount of records
###    while offset < max_records:
    while True:
        url = f"{base_url}?$limit={limit}&$offset={offset}"
        response = requests.get(url)
        
        data = pd.read_csv(StringIO(response.text))

        if response.status_code != 200:
            print(f"Error: {response.status_code}")
            break

        all_data.append(data)        

        offset += limit

#        if len(all_data) * limit >= max_records:
#            break

    df = pd.concat(all_data, ignore_index=True)
    
    output_file = os.path.join(OUTPUT_DIR, "output.csv")
    df.to_csv(output_file, index=False)
    print(f"Saved {len(df)} records to {output_file}")

'''

def insert_into_snowflake(filepath, snowflake_conn_id=_SNOWFLAKE_CONN_ID):
    hook = SnowflakeHook(snowflake_conn_id=_SNOWFLAKE_CONN_ID)
    engine = hook.get_sqlalchemy_engine()

    for filename in os.listdir(filepath):
        file_path = os.path.join(filepath, filename)

        if os.path.isfile(file_path) and filename.endswith('.csv'):
            print(f"Processing file: {file_path}")
            
            df = pd.read_csv(file_path)

            df = df[[col for col in df.columns]]

            df.columns = [col.lower() for col in df.columns]
            df.to_sql(_SNOWFLAKE_STAGING_TABLE, engine, if_exists='append', index=False)
            print(f"Inserted {len(df)} rows from {filename} into {_SNOWFLAKE_STAGING_TABLE}.")

    shutil.rmtree(filepath)
    print(f"Deleted directory: {filepath}")





CREATE_MAIN_TABLE= (
    f'''CREATE TABLE IF NOT EXISTS {_SNOWFLAKE_TABLE} (
    id INTEGER,
    domestic BOOLEAN ,
    beat TEXT ,
    district TEXT ,
    ward INTEGER,
    community_area TEXT,
    fbi_code TEXT ,
    x_coordinate INTEGER,
    y_coordinate INTEGER,
    year INTEGER ,
    updated_on TIMESTAMPTZ,
    case_number TEXT UNIQUE NOT NULL,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    location TEXT,
    date TIMESTAMPTZ,
    block TEXT,
    IUCR TEXT ,
    primary_type TEXT ,
    description TEXT,
    location_description TEXT,
    arrest BOOLEAN );'''
)


CREATE_STAGING_TABLE= (
    f'''CREATE TABLE IF NOT EXISTS {_SNOWFLAKE_STAGING_TABLE} (
    id INTEGER,
    domestic BOOLEAN ,
    beat TEXT ,
    district TEXT ,
    ward INTEGER,
    community_area TEXT,
    fbi_code TEXT ,
    x_coordinate INTEGER,
    y_coordinate INTEGER,
    year INTEGER ,
    updated_on TIMESTAMPTZ,
    case_number TEXT UNIQUE NOT NULL,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    location TEXT,
    date TIMESTAMPTZ,
    block TEXT,
    IUCR TEXT ,
    primary_type TEXT ,
    description TEXT,
    location_description TEXT,
    arrest BOOLEAN );'''
)


TRUNCATE_STAGING= (f'TRUNCATE TABLE {_SNOWFLAKE_STAGING_TABLE};')


MOVE_TO_MAIN_TABLE= (
    f'''
    INSERT INTO {_SNOWFLAKE_TABLE} (
        id ,
        domestic  ,
        beat  ,
        district  ,
        ward ,
        community_area ,
        fbi_code  ,
        x_coordinate ,
        y_coordinate ,
        year  ,
        updated_on ,
        case_number ,
        latitude ,
        longitude  ,
        location ,
        date ,
        block ,
        IUCR  ,
        primary_type  ,
        description ,
        location_description ,
        arrest  
    )
    SELECT DISTINCT
        s.id ,
        s.domestic  ,
        s.beat  ,
        s.district  ,
        s.ward ,
        s.community_area ,
        s.fbi_code  ,
        s.x_coordinate ,
        s.y_coordinate ,
        s.year  ,
        s.updated_on ,
        s.case_number ,
        s.latitude  ,
        s.longitude  ,
        s.location ,
        s.date ,
        s.block ,
        s.IUCR  ,
        s.primary_type  ,
        s.description ,
        s.location_description ,
        s.arrest  
    FROM {_SNOWFLAKE_STAGING_TABLE} s
    LEFT JOIN {_SNOWFLAKE_TABLE} m
    ON s.id = m.id
    WHERE m.id IS NULL;
    '''
    )



with DAG('crime_dag',
        start_date=datetime(2025, 1, 23),
        default_args={"snowflake_conn_id": _SNOWFLAKE_CONN_ID},
        schedule_interval='@daily',
        catchup=False,
        tags=['nada'],
        ) as dag:

  create_staging_table = SnowflakeOperator(task_id="create_staging_table", sql=CREATE_STAGING_TABLE)
  
  create_src_table = SnowflakeOperator(task_id="create_src_table", sql=CREATE_MAIN_TABLE)
  
  truncate_staging_table = SnowflakeOperator(task_id="truncate_staging_table", sql=TRUNCATE_STAGING)


  fetch_data_task = PythonOperator(
        task_id="fetch_data",
        python_callable=fetch_crime_data
  )



  verify_output = BashOperator(
        task_id='verify_output',
        bash_command=f'ls -l {OUTPUT_DIR}' 

  )

  load_data_task = PythonOperator(
        task_id='load_data',
        python_callable=insert_into_snowflake,
        op_kwargs={'filepath': OUTPUT_DIR, 'snowflake_conn_id': _SNOWFLAKE_CONN_ID}
      
  )
  
  move_data_to_main = SnowflakeOperator(task_id='move_data_to_main', sql=MOVE_TO_MAIN_TABLE)





create_staging_table >> create_src_table >> truncate_staging_table >> fetch_data_task >> verify_output >> load_data_task >> move_data_to_main
