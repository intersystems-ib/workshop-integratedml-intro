

-- train data
CREATE TABLE Workshop_Data.MaternalTrain (
        Age INT,
        SystolicBP INT,
        DiastolicBP INT,
        BS DOUBLE,
        BodyTemp DOUBLE,
        HeartRate INT,
        RiskLevel VARCHAR(255)
)

LOAD DATA FROM FILE '/app/data/train.csv'
INTO Workshop_Data.MaternalTrain (Age,SystolicBP,DiastolicBP,BS,BodyTemp,HeartRate,RiskLevel)
VALUES (Age,SystolicBP,DiastolicBP,BS,BodyTemp,HeartRate,RiskLevel)
USING {"from":{"file":{"charset": "UTF-8"}}}


SELECT * FROM Workshop_Data.MaternalTrain

-- test data
CREATE TABLE Workshop_Data.MaternalTest (
        Age INT,
        SystolicBP INT,
        DiastolicBP INT,
        BS DOUBLE,
        BodyTemp DOUBLE,
        HeartRate INT,
        RiskLevel VARCHAR(255)
)

LOAD DATA FROM FILE '/app/data/test.csv'
INTO Workshop_Data.MaternalTest (Age,SystolicBP,DiastolicBP,BS,BodyTemp,HeartRate,RiskLevel)
VALUES (Age,SystolicBP,DiastolicBP,BS,BodyTemp,HeartRate,RiskLevel)
USING {"from":{"file":{"charset": "UTF-8"}}}

SELECT * FROM Workshop_Data.MaternalTest


-- create model
CREATE MODEL MaternalModel PREDICTING (RiskLevel) FROM Workshop_Data.MaternalTrain

-- train model
TRAIN MODEL MaternalModel

-- validate model
VALIDATE MODEL MaternalModel FROM Workshop_Data.MaternalTest

SELECT * FROM INFORMATION_SCHEMA.ML_VALIDATION_METRICS

-- view logs
SELECT substring(LOG, 1, 50000) LOG,* FROM INFORMATION_SCHEMA.ML_TRAINING_RUNS

-- predict using model
SELECT *, PREDICT(MaternalModel) AS PredictedRisk,PROBABILITY(MaternalModel FOR 'mid risk') As Probability
FROM Workshop_Data.MaternalTest

SELECT *, PREDICT(MaternalModel) AS PredictedRisk, PROBABILITY(MaternalModel FOR 'mid risk') As Probability
FROM Workshop_Data.MaternalTest 
WHERE PROBABILITY(MaternalModel FOR 'mid risk') > 0.7

