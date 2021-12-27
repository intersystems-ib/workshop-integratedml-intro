Class Workshop.Util Extends %RegisteredObject
{

/// do ##class(Workshop.Util).PrepareData()
ClassMethod PrepareData() As %Status [ Language = python ]
{
    import pandas as pd
    data=pd.read_csv('/app/data/maternal_health_risk.csv')

    from sklearn.model_selection import train_test_split
    # split data into train and test set
    train,test = train_test_split(data, test_size=0.30, random_state=25)
    # export to csv
    train.to_csv('/app/data/train.csv',index=False)
    test.to_csv('/app/data/test.csv',index=False)
}

}
