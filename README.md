# Chicago-Taxi-Operations-AI-Predictive-Audit
-Executive Summary 

This project is a comprehensive end-to-end data engineering and machine learning audit of the Chicago Taxi industry. Utilizing the massive 77GB Chicago Taxi Trips public dataset in Google BigQuery, the project transitions from raw historical data analysis to predictive AI deployment and model transparency.By combining BigQuery's heavy-duty data processing with BigQuery ML's predictive power, I built an AI system that predicts passenger tipping behavior with 95% precision.

The final result is a 4-page interactive AI Audit Dashboard that analyzes market share, identifies high-demand geospatial hotspots, and provides a transparent "Truth Audit" of the model's reliability across Chicago's neighborhoods.

-The Tech Stack

Data Warehouse: Google BigQuery (SQL)

Machine Learning: BigQuery ML (Logistic Regression)

Business Intelligence: Looker Studio

Core Concepts: Data Architecture (CTAS), Feature Engineering, Binary Classification, Geospatial Analysis, Model Explainability.

-Project Architecture

1. Data Engineering & Transformation
   
The raw Chicago Taxi dataset was processed using advanced SQL techniques to ensure high-performance querying:

Data Cleaning: Handled nulls in trip_miles, fare, and community_area.

CTAS (Create Table As Select): Architected specialized tables for Market Share, Hourly Demand, and ML training sets to optimize Looker Studio performance.

Feature Engineering: Transformed raw timestamps into pickup_hour and day_of_the_week to identify cyclical demand patterns.

2. AI Model Development (BigQuery ML)
   
I developed a Logistic Regression model to predict the likelihood of a passenger tipping based on trip logistics.

Features: Pickup Area, Trip Miles, Fare, Payment Type, and Taxi Company.

Target: tip_enabled (Binary: 1 for Tip, 0 for No Tip).

3. The AI Audit & Evaluation
   
Unlike standard models, this project includes a "Field Audit" to ensure business reliability:

Model Performance: High 95% Precision ensures drivers can trust the model's positive predictions.

Feature Importance: Analysis proved that Geographic Location is the primary driver of tip propensity, far outweighing the Time of Day.

Geospatial Reliability: A Heatmap was generated to show "Reliability Hotspots," identifying where the model is most (and least) accurate for deployment.

-Business Insights

Geographic Moats: Top-tier neighborhoods generate significantly higher tip probabilities, regardless of the taxi company's brand.

Demand Volatility: Peak demand occurs between 6 PM and 9 PM, but revenue efficiency (Revenue per Trip) peaks during specific early morning airport runs.

Model Trust: By providing a "Model Truth Table," we acknowledge "misses," showing that the AI remains conservative in low-confidence scenarios to maintain high precision.

## 📊 Executive Dashboard Preview

> [!TIP]
    **View the Live Interactive Report:** [(https://datastudio.google.com/reporting/1f0f0442-bc21-4c0c-ac28-414d0f1da901)

> note : "The live report is connected via BigQuery connector to optimized tables generated through the SQL engineering scripts provided in this repository."

### Section 1: Operations & Market Analysis
*Historical trends and competitive landscape.*

![Operations Analysis](page1.png)
![Geospatial Demand](page2.png)

---

### Section 2: AI Predictive Audit
*Model explainability and reliability validation.*

![Model Performance](page3.png)
![Truth Audit & Reliability](page4.png)
