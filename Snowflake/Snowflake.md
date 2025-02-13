**Snowflake Setup Documentation**

This document outlines the steps to set up Snowflake for your project, including creating roles, warehouses, and schemas.

### Prerequisites
- You must have **ACCOUNTADMIN** privileges to execute these commands.
- Ensure that Snowflake is properly configured and accessible.

### Setup Steps
Execute the following SQL commands in Snowflake:

#### 1. Set Role
```sql
USE ROLE ACCOUNTADMIN;
```

#### 2. Create and Grant Role
```sql
CREATE ROLE IF NOT EXISTS TRANS;
GRANT ROLE TRANS TO ROLE ACCOUNTADMIN;
```

#### 3. Create Warehouse
```sql
CREATE WAREHOUSE IF NOT EXISTS SNOW_WAREHOUSE;
GRANT OPERATE ON WAREHOUSE SNOW_WAREHOUSE TO ROLE TRANS;
```

#### 4. Create Database and Schemas
```sql
CREATE DATABASE IF NOT EXISTS DATA_ZOOMCAMP;
CREATE SCHEMA IF NOT EXISTS DATA_ZOOMCAMP.RAW;
CREATE SCHEMA IF NOT EXISTS DATA_ZOOMCAMP.DEV;
```

#### 5. Grant Permissions
```sql
GRANT ALL ON WAREHOUSE SNOW_WAREHOUSE TO ROLE TRANS;
GRANT ALL ON DATABASE DATA_ZOOMCAMP TO ROLE TRANS;
GRANT ALL ON ALL SCHEMAS IN DATABASE DATA_ZOOMCAMP TO ROLE TRANS;
```

### Verification
After executing the above commands, verify the setup:
1. **Check Role Assignments**
   ```sql
   SHOW ROLES;
   ````
2. **Check Warehouses**
   ```sql
   SHOW WAREHOUSES;
   ```
3. **Check Databases and Schemas**
   ```sql
   SHOW DATABASES;
   SHOW SCHEMAS IN DATABASE DATA_ZOOMCAMP;
   ```

This ensures that all roles, warehouses, and schemas are correctly set up and accessible.

