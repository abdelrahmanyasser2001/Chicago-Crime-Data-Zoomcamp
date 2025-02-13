## Data Dictionary

| Column Name           | Description  | API Field Name      | Data Type          |
|----------------------|-------------|--------------------|-------------------|
| ID                  | Unique identifier for the record. | id | Number |
| Domestic            | Indicates whether the incident was domestic-related as defined by the Illinois Domestic Violence Act. | domestic | Checkbox |
| Beat               | Indicates the beat where the incident occurred. A beat is the smallest police geographic area. | beat | Text |
| District           | Indicates the police district where the incident occurred. | district | Text |
| Ward              | The ward (City Council district) where the incident occurred. | ward | Text |
| Community Area     | Indicates the community area where the incident occurred. | community_area | Text |
| FBI Code          | Indicates the crime classification as outlined in the FBI's National Incident-Based Reporting System (NIBRS). | fbi_code | Text |
| X Coordinate      | The x coordinate of the location where the incident occurred in State Plane Illinois East NAD 1983 projection. | x_coordinate | Number |
| Y Coordinate      | The y coordinate of the location where the incident occurred in State Plane Illinois East NAD 1983 projection. | y_coordinate | Number |
| Year              | Year the incident occurred. | year | Number |
| Updated On        | Date and time the record was last updated. | updated_on | Floating Timestamp |
| Case Number       | The Chicago Police Department RD Number (Records Division Number), which is unique to the incident. | case_number | Text |
| Latitude          | The latitude of the location where the incident occurred. | latitude | Number |
| Longitude         | The longitude of the location where the incident occurred. | longitude | Number |
| Location          | The location where the incident occurred in a format that allows for mapping. | location | Location |
| Date             | Date when the incident occurred. This is sometimes a best estimate. | date | Floating Timestamp |
| Block            | The partially redacted address where the incident occurred, placing it on the same block as the actual address. | block | Text |
| IUCR             | The Illinois Uniform Crime Reporting code linked to the Primary Type and Description. | iucr | Text |
| Primary Type     | The primary description of the IUCR code. | primary_type | Text |
| Description      | The secondary description of the IUCR code, a subcategory of the primary description. | description | Text |
| Location Description | Description of the location where the incident occurred. | location_description | Text |
| Arrest           | Indicates whether an arrest was made. | arrest | Checkbox |

For more details, visit: [Chicago Crime Data](https://data.cityofchicago.org/Public-Safety/Crimes-2001-to-Present/ijzp-q8t2/about_data)