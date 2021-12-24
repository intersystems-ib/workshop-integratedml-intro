


https://www.kaggle.com/fedesoriano/stroke-prediction-dataset/discussion/232298#

TODO: resample input data?

```
SELECT 
ID1, id, gender, age, hypertension, heart_disease, ever_married, work_type, Residence_type, avg_glucose_level, bmi, smoking_status, stroke
FROM Workshop_Data.Stroke
```

```
CREATE MODEL StrokeModel PREDICTING (stroke) FROM Workshop_Data.Stroke
```

```
TRAIN MODEL StrokeModel
```

```
VALIDATE MODEL StrokeModel FROM Workshop_Data.Stroke
```

```
SELECT * FROM INFORMATION_SCHEMA.ML_VALIDATION_METRICS
```

```
SELECT stroke, PREDICT(stroke ) AS strokePrediction, * FROM Workshop_Data.Stroke
```

