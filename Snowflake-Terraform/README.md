
## Terraform Setup
#### Step 1: Install Terraform
If you haven’t already, you need to install Terraform on your local machine. You can download it from the official website: Terraform Downloads.

#### Step 2: Create a Terraform Configuration File
Create a new directory for your Terraform project and create Terraform configuration files (e.g., `main.tf`, `providers.tf`, `variables.tf`) within that directory. These files will contain your Terraform configuration.

Here is `providers.tf`:

```hcl
terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.76"
    }
  }
}

provider "snowflake" {
  username = var.snowflake_username
  password = var.snowflake_password
  account  = var.snowflake_account_name
  region   = var.snowflake_region
}
```

#### Step 3: Define Variables
Define the necessary variables in `variables.tf` to store sensitive information securely.


## Snowflake Setup

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

