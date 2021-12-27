

https://www.kaggle.com/csafrit2/maternal-health-risk-data


Do ##class(community.csvgen).Generate("/app/data/train.csv",",","Workshop.Data.MaternalTrain")

Do ##class(community.csvgen).Generate("/app/data/test.csv",",","Workshop.Data.MaternalTest")

```
CREATE MODEL MaternalModel PREDICTING (RiskLevel) FROM Workshop_Data.MaternalTrain
```

```
TRAIN MODEL MaternalModel
```

```
VALIDATE MODEL MaternalModel FROM Workshop_Data.MaternalTest
```

```
SELECT * FROM INFORMATION_SCHEMA.ML_VALIDATION_METRICS
```

```
SELECT *,PREDICT(MaternalModel) AS PredictedRisk FROM Workshop_Data.MaternalTest
```
