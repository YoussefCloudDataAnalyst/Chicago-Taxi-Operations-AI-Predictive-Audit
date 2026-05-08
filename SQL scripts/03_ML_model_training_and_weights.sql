-- ==================================================================================
-- PROJECT: Chicago Taxi Operations & AI Predictive Audit
-- BIGQUERY PROJECT ID: chicago-taxi-analytics-495018
-- PURPOSE: Building the Logistic Regression model and extracting Feature Weights.
-- ==================================================================================

-- 1. CREATING THE TRAINING DATASET
-- We use CTAS to isolate the features and the target label (tip_enabled)
CREATE OR REPLACE TABLE `chicago-taxi-analytics-495018.taxi_analysis.ml_training_data` AS
SELECT 
    tip_enabled,
    pickup_hour,
    day_of_week,
    area_id,
    trip_miles,
    fare,
    payment_type,
    company
FROM 
    `chicago-taxi-analytics-495018.taxi_analysis.clean_trips`
WHERE 
    -- 80% split for training using a deterministic hash
    MOD(ABS(FARM_FINGERPRINT(unique_key)), 10) < 8;

-- 2. TRAINING THE MODEL
-- Implementing Logistic Regression for Binary Classification
CREATE OR REPLACE MODEL `chicago-taxi-analytics-495018.taxi_analysis.tip_prediction_model`
OPTIONS(
  model_type='LOGISTIC_REG',
  input_label_cols=['tip_enabled'],
  auto_class_weights=TRUE
) AS
SELECT * FROM `chicago-taxi-analytics-495018.taxi_analysis.ml_training_data`;

-- 3. EXTRACTING FEATURE IMPORTANCE
-- Capturing the influence scores that fed our bar chart in Looker Studio
CREATE OR REPLACE TABLE `chicago-taxi-analytics-495018.taxi_analysis.model_feature_weights` AS
SELECT * FROM ML.WEIGHTS(MODEL `chicago-taxi-analytics-495018.taxi_analysis.tip_prediction_model`);
