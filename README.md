Intro to automated machine learning directly from SQL using IntegratedML feature in InterSystems IRIS. You can find more information in the [documentation](https://docs.intersystems.com/irisforhealthlatest/csp/docbook/DocBook.UI.Page.cls?KEY=GIML_Intro)


# Setup
Run the container we will use as our IRIS instance:
```
docker-compose up -d
```

# Prepare the data

## (a). Check the data
We are going to use a dataset about health risks for pregnant patients. Have a look at the details here:
https://www.kaggle.com/csafrit2/maternal-health-risk-data

We have already included in the repository a [data file](data/maternal_health_risk.csv).


## (b). Split training and test data
We need to split the [data](data/maternal_health_risk.csv) into training and test datasets. Prepare data simply split the data and generate a train and test CSV files. Have a look at the [code](src/Workshop/Util.cls) using Embedded Python.

```
do ##class(Workshop.Util).PrepareData()
```

## (c). Load CSV files
We will use [csvgen](https://openexchange.intersystems.com/package/csvgen) to create persistent classes and load data from CSV files. 

```
do ##class(community.csvgen).Generate("/app/data/train.csv",",","Workshop.Data.MaternalTrain")
do ##class(community.csvgen).Generate("/app/data/test.csv",",","Workshop.Data.MaternalTest")
```

# Create your model
Create a model to predict `RiskLevel`:

```
CREATE MODEL MaternalModel PREDICTING (RiskLevel) FROM Workshop_Data.MaternalTrain
```

# Training the model
You can now train the model using the training data

```
TRAIN MODEL MaternalModel
```

# Validating the model
Evaluate the performance of the predictions of your model

```
VALIDATE MODEL MaternalModel FROM Workshop_Data.MaternalTest
```

```
SELECT * FROM INFORMATION_SCHEMA.ML_VALIDATION_METRICS
```

# Using the model
Finally you can run predictions on RiskLevel. Here you can compare the predictions Vs. real data:

```
SELECT *, PREDICT(MaternalModel) AS PredictedRisk FROM Workshop_Data.MaternalTest
```
