-- ==================================================================================
-- PROJECT: Chicago Taxi Operations & AI Predictive Audit
-- BIGQUERY PROJECT ID: chicago-taxi-analytics-495018
-- PURPOSE: Auditing AI predictions against actual outcomes (The Truth Audit).
-- ==================================================================================

-- 1. GENERATING THE TRUTH TABLE
-- Joining predictions with actuals to create the "final_predictions_display" table
CREATE OR REPLACE TABLE `chicago-taxi-analytics-495018.taxi_analysis.final_predictions_display` AS
SELECT
  tip_enabled AS actual_tipped,
  predicted_tip_enabled AS predicted_will_tip,
  -- Extracting the probability of the '1' (Tip) class for the Confidence Score
  ROUND(p.prob, 4) AS tip_probability
FROM
  ML.PREDICT(MODEL `chicago-taxi-analytics-495018.taxi_analysis.tip_prediction_model`,
    (SELECT * FROM `chicago-taxi-analytics-495018.taxi_analysis.ml_training_data` LIMIT 1000)),
  UNNEST(predicted_tip_enabled_probs) AS p
WHERE p.label = 1;

-- 2. GEOSPATIAL RELIABILITY AUDIT
-- Calculating accuracy percentage by neighborhood for the reliability heatmap
CREATE OR REPLACE TABLE `chicago-taxi-analytics-495018.taxi_analysis.prediction_accuracy_by_area` AS
SELECT
  area_id,
  COUNT(*) AS total_trips,
  -- Accuracy = (Correct Predictions / Total Predictions)
  ROUND(SUM(CASE WHEN tip_enabled = predicted_tip_enabled THEN 1 ELSE 0 END) / COUNT(*), 4) AS model_reliability_score
FROM
  ML.PREDICT(MODEL `chicago-taxi-analytics-495018.taxi_analysis.tip_prediction_model`,
    (SELECT * FROM `chicago-taxi-analytics-495018.taxi_analysis.clean_trips`))
GROUP BY 1
HAVING total_trips > 100; -- Filtering out areas with low sample sizes for statistical significance
