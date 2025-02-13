# Chicago Crime Data Transformation with dbt

## Overview
This project uses **dbt (Data Build Tool)** to transform and model Chicago crime data. The final star schema consists of fact and dimension tables optimized for analytics.


## Installation
To set up dbt for this project, install the required dependencies:
```sh
pip install dbt-core dbt-snowflake
```

### Verify Installation
Run the following command to ensure dbt is installed properly:
```sh
dbt --version
```
Expected output:
```
dbt Core: <version>
dbt Snowflake: <version>
```
### Initialize a New dbt Project
```sh
dbt-core init
```
Configure dbt profile


## Test the Connection
Once the profile is configured, run:
```sh
dbt debug
```
If successful, dbt is ready to use!

## Running dbt Models
Execute all models with:
```sh
dbt run
```
## Running dbt Tests
```sh
dbt test
```

## Data Model - Star Schema
The project follows a star schema with the following tables:

### **Fact Table**
- **FACT_CRIME**: Stores crime incidents with keys referencing dimension tables.

### **Dimension Tables**
- **DATE_TIME_DIM**: Stores crime date and time details.
- **LOCATION_DIM**: Contains geographic details of crime locations.
- **CRIME_TYPE_DIM**: Stores crime classifications (primary type, description).

### ERD (Entity-Relationship Diagram)
![Schema](./images/star.png)

