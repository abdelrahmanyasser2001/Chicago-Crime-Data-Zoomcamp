resource "snowflake_warehouse" "default" {
  name           = "SNOW_WAREHOUSE"
  warehouse_size = "X-SMALL"
  auto_suspend   = 60
  auto_resume    = true
}

resource "snowflake_database" "data_zoomcamp" {
  name = "DATA_ZOOMCAMP"
}

resource "snowflake_schema" "raw" {
  database = snowflake_database.data_zoomcamp.name
  name     = "RAW"
}

resource "snowflake_schema" "dev" {
  database = snowflake_database.data_zoomcamp.name
  name     = "DEV"
}
