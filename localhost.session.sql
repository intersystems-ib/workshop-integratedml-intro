

-- view original data
select * from Workshop_Data.MaternalTrain;
select * from Workshop_Data.MaternalTest;

-- create prediction model
CREATE MODEL MaternalModel PREDICTING (RiskLevel) 
FROM Workshop_Data.MaternalTrain;

-- train model
TRAIN MODEL MaternalModel;

-- validate model
VALIDATE MODEL MaternalModel 
FROM Workshop_Data.MaternalTest;

SELECT * 
FROM INFORMATION_SCHEMA.ML_VALIDATION_METRICS;

-- use the model
SELECT *, PREDICT(MaternalModel) AS PredictedRisk 
FROM Workshop_Data.MaternalTest;
