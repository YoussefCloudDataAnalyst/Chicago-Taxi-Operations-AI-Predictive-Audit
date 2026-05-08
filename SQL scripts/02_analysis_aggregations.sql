-- ==================================================================================
-- PROJECT: Chicago Taxi Operations & AI Predictive Audit
-- BIGQUERY PROJECT ID: chicago-taxi-analytics-495018
-- PURPOSE: Creating optimized tables for BI dashboards (Market Share & Demand)
-- ==================================================================================

-- 1. Market Share Analysis (Pie Chart Page 1)
CREATE OR REPLACE TABLE `chicago-taxi-analytics-495018.taxi_analysis.taxi_companies_marketshare` AS
SELECT 
    company,
    COUNT(*) AS total_trips,
    SUM(fare) AS total_revenue,
    (COUNT(*) / SUM(COUNT(*)) OVER()) * 100 AS market_share_perc
FROM `chicago-taxi-analytics-495018.taxi_analysis.clean_trips`
GROUP BY 1
ORDER BY total_trips DESC;

-- 2. Geospatial Activity (Heatmap Page 2)
CREATE OR REPLACE TABLE `chicago-taxi-analytics-495018.taxi_analysis.pickup_location_activity` AS
SELECT 
    area_id,
    COUNT(*) AS trip_count,
    AVG(tips) AS avg_tip
FROM `chicago-taxi-analytics-495018.taxi_analysis.clean_trips`
GROUP BY 1;

-- 3. Correlation Analysis: Tips vs Payment Type
CREATE OR REPLACE TABLE `chicago-taxi-analytics-495018.taxi_analysis.tip_by_payment_type` AS
SELECT 
    payment_type,
    AVG(tips) AS avg_tip_amount,
    COUNT(*) AS volume
FROM `chicago-taxi-analytics-495018.taxi_analysis.clean_trips`
GROUP BY 1;
