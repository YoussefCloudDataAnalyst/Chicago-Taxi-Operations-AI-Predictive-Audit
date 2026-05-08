-- ==================================================================================
-- PROJECT: Chicago Taxi Operations & AI Predictive Audit
-- PURPOSE: Clean and transform 200M+ rows of raw data for high-performance BI.
-- AUTHOR:  Youssef Jadir (Sales Growth Business Partner)
-- ==================================================================================

-- Create a cleaned base table to avoid scanning 77GB repeatedly (Cost Optimization)
CREATE OR REPLACE TABLE `chicago-taxi-analytics-495018.taxi_analysis.cleaned_taxi_trips` AS
SELECT 
    unique_key,
    taxi_id,
    trip_start_timestamp,
    -- Feature Engineering: Extracting time dimensions
    EXTRACT(HOUR FROM trip_start_timestamp) AS pickup_hour,
    EXTRACT(DAYOFWEEK FROM trip_start_timestamp) AS day_of_week,
    -- Handling Geospatial Nulls
    COALESCE(CAST(pickup_community_area AS STRING), 'Unknown') AS area_id,
    -- Metric Cleanup
    trip_miles,
    fare,
    tips,
    -- Creating the Target Label for ML (Binary Classification)
    CASE WHEN tips > 0 THEN 1 ELSE 0 END AS tip_enabled,
    payment_type,
    company
FROM 
    `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE 
    -- Filtering noise: Removing trips with zero miles or missing fare data
    trip_miles > 0 
    AND fare > 0
    -- Focusing on recent logistics (Adjust year as needed)
    AND EXTRACT(YEAR FROM trip_start_timestamp) >= 2022;

-- ==================================================================================
-- TABLE FOR LOOKER: Hourly Demand Summary
-- ==================================================================================
CREATE OR REPLACE TABLE `your_project.taxi_analysis.hourly_demand_summary` AS
SELECT 
    pickup_hour,
    AVG(trip_miles) as avg_distance,
    COUNT(*) as total_trips,
    AVG(fare) as avg_fare
FROM 
    `chicago-taxi-analytics-495018.taxi_analysis.cleaned_taxi_trips`
GROUP BY 1;
