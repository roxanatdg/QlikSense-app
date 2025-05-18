-- ================================================
-- Airbnb Disertatie Database Schema
-- ================================================

-- Create Database
CREATE DATABASE airbnb_disertatie;
GO

USE airbnb_disertatie;
GO

-- ================================================
-- DIMENSION TABLES
-- ================================================

-- Cities Dimension
CREATE TABLE Cities (
    ID_City INT PRIMARY KEY,
    City VARCHAR(100),
    Country VARCHAR(100),
    Population BIGINT,
    Timezone VARCHAR(50),
    Region VARCHAR(100),
    Avg_Income_EUR_per_year DECIMAL(10, 2)
);

-- DayType Dimension
CREATE TABLE DayType (
    ID_Day INT PRIMARY KEY,
    Day VARCHAR(20)
);

-- Furnishing Levels Dimension
CREATE TABLE Furnishing_levels (
    Furnishing_id INT PRIMARY KEY,
    Level_name VARCHAR(50),
    Description TEXT
);

-- Room Type Dimension
CREATE TABLE RoomType (
    ID_Room INT PRIMARY KEY,
    Room_Type VARCHAR(100),
    Description TEXT,
    Privacy_level VARCHAR(50),
    Has_private_bath BIT,
    Ideal_for VARCHAR(100),
    Furnishing_id INT,
    CONSTRAINT FK_Rooms_Furnishing FOREIGN KEY (Furnishing_id)
        REFERENCES Furnishing_levels(Furnishing_id)
);

-- ================================================
-- FACT TABLES
-- ================================================

-- Listings Fact Table
CREATE TABLE Listings (
    ID_Listing INT PRIMARY KEY IDENTITY(1,1),
    ID_City INT,
    Price DECIMAL(10, 4),
    ID_Day INT,
    ID_Room INT,
    Shared_Room BIT,
    Private_Room BIT,
    Person_Capacity INT,
    Superhost BIT,
    Multiple_Rooms BIT,
    Business BIT,
    Cleanliness_Rating DECIMAL(4, 2),
    Guest_Satisfaction DECIMAL(5, 2),
    Bedrooms INT,
    City_Center_km DECIMAL(10, 6),
    Metro_Distance_km DECIMAL(10, 6),
    Attraction_Index DECIMAL(12, 6),
    Normalised_Attraction_Index DECIMAL(10, 6),
    Restaurant_Index DECIMAL(12, 6),
    Normalised_Restaurant_Index DECIMAL(10, 6),

    CONSTRAINT FK_Listings_City FOREIGN KEY (ID_City)
        REFERENCES Cities(ID_City),
    CONSTRAINT FK_Listings_Day FOREIGN KEY (ID_Day)
        REFERENCES DayType(ID_Day),
    CONSTRAINT FK_Listings_Room FOREIGN KEY (ID_Room)
        REFERENCES RoomType(ID_Room)
);

-- Financials Table
CREATE TABLE Financials (
    Year INT,
    Revenue_EUR_M DECIMAL(18, 2),
    Operating_Expenses_EUR_M DECIMAL(18, 2),
    Profit_Margin DECIMAL(5, 2),
    Marketing_Spend_EUR_M DECIMAL(18, 2),
    EBITDA_Margin DECIMAL(5, 2)
);

-- ================================================
-- OUTLIER FLAG LOGIC
-- ================================================

-- Create new table with Price Outlier Flag
SELECT 
    ID_Listing, 
    ID_City, 
    ID_Day, 
    ID_Room, 
    Shared_Room, 
    Private_Room, 
    Person_Capacity, 
    Superhost, 
    Multiple_Rooms, 
    Business, 
    Cleanliness_Rating, 
    Guest_Satisfaction, 
    Bedrooms, 
    City_Center_km, 
    Metro_Distance_km, 
    Attraction_Index, 
    Normalised_Attraction_Index, 
    Restaurant_Index, 
    Normalised_Restaurant_Index, 
    Price,

    -- Flag outliers based on IQR
    CASE 
        WHEN Price < Q1 - 1.5 * (Q3 - Q1) OR Price > Q3 + 1.5 * (Q3 - Q1) THEN 1
        ELSE 0
    END AS Price_Outlier_Flag

INTO Listings_With_OutlierFlag

FROM (
    SELECT 
        *, 
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Price) OVER (PARTITION BY ID_City) AS Q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Price) OVER (PARTITION BY ID_City) AS Q3
    FROM airbnb_disertatie.dbo.Listings
) AS PriceStats;
