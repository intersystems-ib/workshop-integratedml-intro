Intro to automated machine learning directly from SQL using IntegratedML feature in InterSystems IRIS. You can find more information in the [documentation](https://docs.intersystems.com/irisforhealthlatest/csp/docbook/DocBook.UI.Page.cls?KEY=GIML_Intro)

<img src="img/demo-integratedml.gif" width="800px"/>

Have a look at the slides in [Workshop-IntegratedML-Intro.pdf](Workshop-IntegratedML-Intro.pdf)

# Setup
Run the container we will use as our IRIS instance:
```
docker-compose up -d
```

After that, you should be able to access to [Management Portal](http://localhost:52773/csp/sys/UtilHome.csp).

# Prepare the data

## (a). Check the data
We are going to use a dataset about health risks for pregnant patients. Have a look at the details here:
https://www.kaggle.com/csafrit2/maternal-health-risk-data

We have already included in the repository a [data file](data/maternal_health_risk.csv).


## (b). Split training and test data
We need to split the [data](data/maternal_health_risk.csv) into training and test datasets. Prepare data simply split the data and generate a train and test CSV files. Have a look at the [code](src/Workshop/Util.cls) using Embedded Python.

Run the method in a [WebTerminal](http://localhost:52773/terminal/) session.

```objectscript
do ##class(Workshop.Util).PrepareData()
```

## (c). Load CSV files
We will use [csvgen](https://openexchange.intersystems.com/package/csvgen) to create persistent classes and load data from CSV files. 

```objectscript
do ##class(community.csvgen).Generate("/app/data/train.csv",",","Workshop.Data.MaternalTrain")
```
```objectscript
do ##class(community.csvgen).Generate("/app/data/test.csv",",","Workshop.Data.MaternalTest")
```

# (d). Create your model
IntegratedML feature works directly in SQL. You can use the [SQL Explorer](http://localhost:52773/csp/sys/exp/%25CSP.UI.Portal.SQL.Home.zen?$NAMESPACE=WORKSHOP) in the Management Portal or use an external JDBC tool like SQLTools for VS Code.

Create a model to predict `RiskLevel`:

```
CREATE MODEL MaternalModel PREDICTING (RiskLevel) FROM Workshop_Data.MaternalTrain
```

# (e). Training the model
You can now train the model using the training data

```
TRAIN MODEL MaternalModel
```

# (f). Validating the model
Evaluate the performance of the predictions of your model

```
VALIDATE MODEL MaternalModel FROM Workshop_Data.MaternalTest
```

```sql
SELECT * FROM INFORMATION_SCHEMA.ML_VALIDATION_METRICS
```

# (g). Using the model
Finally you can run predictions on RiskLevel. Here you can compare the predictions Vs. real data:

```sql
SELECT *, PREDICT(MaternalModel) AS PredictedRisk FROM Workshop_Data.MaternalTest
```
