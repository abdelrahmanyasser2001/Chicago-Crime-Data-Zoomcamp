# 🚀 Chicago Crime Data Pipeline - DataZoom Camp 2025

## 📌 Project Overview
This project is part of **Data ZoomCamp 2025** and focuses on building a robust data pipeline to process and visualize crime data in Chicago. The goal is to extract raw crime records from an external API, store and transform them in **Snowflake**, and create insightful visualizations using **Metabase**.

With a fully automated ETL pipeline orchestrated by **Apache Airflow**, the project ensures data is collected, processed, and made available for analysis seamlessly. The final output is a set of **interactive dashboards** that help analyze crime trends across different dimensions like time, location, and crime type.

## 🎯 Project Goals
- **Transform raw crime data** into structured, analyzable datasets
- **Automate the ETL process** using modern data tools
- **Enable data-driven insights** through visualization dashboards
- **Ensure data quality** with robust validation and testing

## 🛠️ High-Level Architecture
The data pipeline consists of the following major stages:

1. **Extract:** Crime data is pulled from an external API using **Airflow**
2. **Load:** The data is stored in **Snowflake**
3. **Transform:** Using **dbt**, data is cleaned and structured into fact and dimension tables
4. **Visualize:** Insights are presented using **Metabase dashboards**
5. **Infrastructure:** **Terraform** is used to provision **Snowflake** resources automatically

![Project Overview](/images/datazoom.png)

##  Data Processing Pipeline
### 🔹 Extraction (Airflow)
- Extracts crime data from a public API
- Runs on a scheduled basis inside **Docker** containers

### 🔹 Loading (Snowflake)
- Stores raw crime data in **staging tables**
- Provides a scalable, cloud-based data warehouse

### 🔹 Transformation (dbt)
- Cleans and structures data into **fact and dimension tables**
- Ensures data consistency and quality

![DBT Lineage Graph](/dbt/images/LineageGraph.png)

## 📊 Insights & Visualizations
The final data is used to generate interactive dashboards that provide insights into crime patterns in Chicago. Some of the key visualizations include:

- **Crime Trends Over Time** 📈
- **Crime Distribution by Location** 📍
- **Crime Types Analysis** 🔍

![chart1](/Metabase_Dashboard/images/Screenshot%20from%202025-02-14%2011-06-46.png)
![chart1](/Metabase_Dashboard/images/Screenshot%20from%202025-02-14%2011-07-04.png)
![Visualizations Pdf](/Metabase_Dashboard/metabase%20analysis.pdf)

## Data Quality & Testing
To ensure data integrity, we use:
- **dbt Tests** (e.g., uniqueness, not null constraints)
- **Custom SQL Assertions** for business logic validation

## Technologies Used
- **Apache Airflow** (Orchestration)
- **Snowflake** (Data Warehouse)
- **dbt** (Data Transformation)
- **Metabase** (Visualization)
- **Docker** (Containerization)
- **Terraform** (Infrastructure as Code for Snowflake)

## Conclusion
This project demonstrates the end-to-end data pipeline for analyzing Chicago crime data. The integration of modern data tools ensures efficient data processing, and the final dashboards provide actionable insights for understanding crime patterns.

---


