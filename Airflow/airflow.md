# Data Ingestion from API to Snowflake using Airflow
## Project Overview

This project demonstrates how to ingest crime data from the City of Chicago's API into a Snowflake database using Apache Airflow. The workflow includes fetching the data, storing it temporarily in a staging table, and transferring unique records into a main table.
## Setup instruction
### Step 1: Install Astro
```bash
curl -sSL install.astronomer.io | sudo bash -s
```
### Step 2: Initialize Airflow with Astro
```bash
astro dev init
```
### Step 3: Add Required Dependencies
Modify `requirements.txt` to include the necessary provider package:
```plaintext
apache-airflow-providers-snowflake==4.4.0
```


### Step 4: Configure Airflow Connections
You need to set up `Snowflake` connection in Airflow:
#### Snowflake Connection:
- **Connection ID**: `snowflake_conn`
- **Connection Type**: `Snowflake`
- **Host**: Your Snowflake account URL (e.g., `xy12345.snowflakecomputing.com`)
- **Schema**: `DATA_ZOOMCAMP.RAW`
- **Login**: Your Snowflake username
- **Password**: Your Snowflake password
- **Extra**: `{"role": "TRANS", "warehouse": "SNOW_WAREHOUSE", "database": "DATA_ZOOMCAMP"}`.

To add these connections, go to the Airflow UI:

- Navigate to **Admin > Connections**.
- Click the **+** button to add a new connection.
- Fill in the details as described above.


pi

### Step 5: Add the DAG to Airflow
Save the provided DAG code in a Python file (e.g., `crime_dag.py`) and place it in the `dags` directory of your Airflow project.

### Step 6: Start Airflow
Start the Airflow server using Astro:
```bash
astro dev start
```






## DAG Workflow

The Airflow DAG (`crime_dag`) consists of the following steps:

### 1. **Create Staging and Source Tables**

- `create_staging_table`: Ensures a staging table exists in Snowflake.
- `create_src_table`: Ensures the main source table exists in Snowflake.

### 2. **Fetch Crime Data**

- `fetch_data_task`: Fetches crime data from the City of Chicago API in chunks and saves it to a local CSV file.

### 3. **Verify Output File**

- `verify_output`: A BashOperator task that verifies the downloaded CSV file.

### 4. **Load Data into Snowflake**

- `load_data_task`: Reads the CSV and inserts data into the Snowflake staging table.

### 5. **Move Unique Records to Main Table**

- `move_data_to_main`: Transfers unique records from the staging table to the main table.

## Running the DAG

1. Start the Airflow environment:
   ```sh
   astro dev start
   ```
2. Access the Airflow UI at `http://localhost:8080`.
3. Enable and trigger the `crime_dag` DAG.

## Clean Up

To stop the Airflow environment, run:

```sh
astro dev stop
```

This setup ensures a structured ETL process for ingesting crime data into Snowflake using Apache Airflow.


