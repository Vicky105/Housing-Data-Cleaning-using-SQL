-- DATA CLEANING IN SQL

-- 1. Formatting the date and numeric columns

ALTER TABLE housing_data
ALTER COLUMN saledate DATE;

ALTER TABLE housing_data
ALTER COLUMN landvalue FLOAT;

ALTER TABLE housing_data
ALTER COLUMN buildingvalue FLOAT;

ALTER TABLE housing_data
ALTER COLUMN totalvalue FLOAT;

-- 2. Filling null values in property address with respect to parcelID

UPDATE h1
SET propertyaddress = h2.propertyaddress
FROM Housing_Data h1
JOIN Housing_Data h2
ON h1.ParcelID = h2.ParcelID AND h1.UniqueID <> h2.UniqueID
WHERE h1.PropertyAddress IS NULL;

-- OR

UPDATE h1
SET propertyaddress = ISNULL(h1.propertyaddress, h2.propertyaddress)
FROM Housing_Data h1
JOIN Housing_Data h2
ON h1.ParcelID = h2.ParcelID AND h1.UniqueID <> h2.UniqueID;

SELECT TOP 3 h1.ParcelID, h1.PropertyAddress, h2.ParcelID, h2.PropertyAddress, 
    ISNULL(h1.PropertyAddress, h2.PropertyAddress)
FROM Housing_Data h1
JOIN Housing_Data h2
ON h1.ParcelID = h2.ParcelID AND h1.UniqueID <> h2.UniqueID;

-- 3. Splitting Property address into Address and City and inserting as new columns

ALTER TABLE housing_data
ADD property_street_address VARCHAR(100);

ALTER TABLE housing_data
ADD property_city VARCHAR(50);

UPDATE housing_data
SET property_street_address = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1);

UPDATE Housing_Data
SET property_city = SUBSTRING(propertyaddress, CHARINDEX(',', PropertyAddress) + 1, LEN(propertyaddress));

SELECT SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Address, 
    SUBSTRING(propertyaddress, CHARINDEX(',', PropertyAddress) + 1, LEN(propertyaddress)) AS City,
    PropertyAddress
FROM housing_data;

-- 4. Splitting Owner address into Address, State, and City and inserting as new columns
SELECT PARSENAME(REPLACE(owneraddress, ',', '.'), 3) AS streetaddress,
    PARSENAME(REPLACE(owneraddress, ',', '.'), 2) AS City,
    PARSENAME(REPLACE(owneraddress, ',', '.'), 1) AS state
FROM Housing_Data;

ALTER TABLE housing_data
ADD Owner_street_address VARCHAR(100);

ALTER TABLE housing_data
ADD Owner_city VARCHAR(30);

ALTER TABLE housing_data
ADD Owner_state VARCHAR(30);

UPDATE housing_data
SET Owner_street_address = PARSENAME(REPLACE(owneraddress, ',', '.'), 3);

UPDATE housing_data
SET Owner_city = PARSENAME(REPLACE(owneraddress, ',', '.'), 2);

UPDATE housing_data
SET Owner_state = PARSENAME(REPLACE(owneraddress, ',', '.'), 1);

-- 5. Removing duplicate rows in the table

WITH cte AS (
    SELECT *,
        RANK() OVER (PARTITION BY ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference, OwnerName ORDER BY UniqueID) AS rnk
    FROM Housing_Data
)
DELETE FROM Housing_Data
WHERE UniqueID IN (
    SELECT UniqueID
    FROM cte
    WHERE rnk > 1
);

-- OR

WITH cte AS (
    SELECT *,
        RANK() OVER (PARTITION BY ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference, OwnerName ORDER BY UniqueID) AS rnk
    FROM Housing_Data
)
DELETE FROM cte
WHERE rnk > 1;

-- 6. Filling null values in acreage, landvalue, buildingvalue, totalvalue with average values

UPDATE Housing_Data
SET acreage = (SELECT AVG(acreage) FROM Housing_Data)
WHERE acreage IS NULL;

UPDATE Housing_Data
SET landvalue = (SELECT AVG(landvalue) FROM Housing_Data)
WHERE landvalue IS NULL;

UPDATE Housing_Data
SET buildingvalue = (SELECT AVG(buildingvalue) FROM Housing_Data)
WHERE buildingvalue IS NULL;

UPDATE Housing_Data
SET totalvalue = (SELECT AVG(totalvalue) FROM Housing_Data)
WHERE totalvalue IS NULL;

-- 7. Filling YearBuilt, bedrooms, fullBath, and halfBath with mode values

UPDATE Housing_Data
SET YearBuilt = (
    SELECT TOP 1 YearBuilt
    FROM Housing_Data
    GROUP BY YearBuilt
    ORDER BY COUNT(YearBuilt) DESC
)
WHERE YearBuilt IS NULL;

UPDATE Housing_Data
SET bedrooms = (
    SELECT TOP 1 bedrooms
    FROM Housing_Data
    GROUP BY bedrooms
    ORDER BY COUNT(bedrooms) DESC
)
WHERE bedrooms IS NULL;

UPDATE Housing_Data
SET fullBath = (
    SELECT TOP 1 fullBath
    FROM Housing_Data
    GROUP BY fullBath
    ORDER BY COUNT(fullBath) DESC
)
WHERE fullBath IS NULL;

UPDATE Housing_Data
SET HalfBath = (
    SELECT TOP 1 HalfBath
    FROM Housing_Data
    GROUP BY HalfBath
    ORDER BY COUNT(HalfBath) DESC
)
WHERE HalfBath IS NULL;

-- 8. Delete unwanted columns for analysis purposes

ALTER TABLE Housing_Data
DROP COLUMN legalreference, ownername, owneraddress, taxdistrict, saledateonly, propertyaddress;
