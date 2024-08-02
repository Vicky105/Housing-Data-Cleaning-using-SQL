# Housing-Data-Cleaning-using-SQL

## Table of Contents
* [Introduction](#introduction)
* [Data Sources](#data-sources)
* [Data Dictionary](#data-dictionary)
* [Methodology](#methodology)
* [Key Findings](#key-findings)
* [Tools Used](#tools-used)
* [Conclusion](#conclusion)
* [Future Work](#future-work)

## Introduction
This project involves cleaning and preprocessing housing data using SQL. The focus is on formatting dates, filling null values, splitting addresses, removing duplicates, and updating columns with average and mode values.

## Data Sources
Housing Data dataset:
- [Housing Data](https://github.com/Vicky105/Housing-Data-Cleaning-using-SQL/blob/4c7097ed72e73acf771527d6c051209c6622a063/Housing%20Data.csv)

## Data Dictionary

### Housing Data Table
| Column Name            | Description                            | Data Type |
|------------------------|----------------------------------------|-----------|
| UniqueID               | Unique identifier                      | INT       |
| ParcelID               | Unique parcel identifier               | INT       |
| SaleDate               | Date of the sale                       | DATE      |
| LandValue              | Value of the land                      | FLOAT     |
| BuildingValue          | Value of the building                  | FLOAT     |
| TotalValue             | Total property value                   | FLOAT     |
| PropertyAddress        | Full property address                  | VARCHAR   |
| OwnerAddress           | Full owner address                     | VARCHAR   |
| YearBuilt              | Year the property was built            | INT       |
| Bedrooms               | Number of bedrooms                     | INT       |
| FullBath               | Number of full bathrooms               | INT       |
| HalfBath               | Number of half bathrooms               | INT       |
| Acreage                | Property size in acres                 | FLOAT     |
| Property_Street_Address| Property street address                | VARCHAR   |
| Property_City          | Property city                          | VARCHAR   |
| Owner_Street_Address   | Owner street address                   | VARCHAR   |
| Owner_City             | Owner city                             | VARCHAR   |
| Owner_State            | Owner state                            | VARCHAR   |

## Methodology
**Data Cleaning and Preprocessing:**
- Formatting date and numeric columns.
- Filling null values based on other records in the dataset.
- Splitting addresses into separate columns for street, city, and state.
- Removing duplicate rows.
- Filling null values with mean or mode values as appropriate.

## Key Findings
- Address and city fields were successfully split and populated.
- Null values in key columns were filled using average and mode values.
- Duplicate rows were identified and removed efficiently.

## Tools Used
- **EXCEL:** For data preprocessing
- **SQL**: For data cleaning and preprocessing.

## Conclusion
This project demonstrates effective methods for cleaning and preprocessing housing data using SQL. The cleaned dataset can now be used for further analysis and insights.

## Future Work
- **Advanced Analysis:** Perform more advanced statistical analysis on the cleaned data using SQL or Python
- **Visualization:** Create interactive dashboards for the analysed data using Power BI
