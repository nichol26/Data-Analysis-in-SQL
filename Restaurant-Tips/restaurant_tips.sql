USE restaurant_project;

 CREATE TABLE tip_ids(
  TipID int NOT NULL,
  Tip float,
  Sex varchar(255),
  Smoker varchar(255),
  Days varchar(255),
  DiningTime varchar(255),
  Size int,
  PRIMARY KEY(TipID)
);

 # What is the average tip % given by smoker / non-smoker women / men?
Select Sex, Smoker, round(AVG(Tip/TotalBill)*100,2) as Avg_TipPercentage
FROM tips
GROUP BY Smoker, Sex;

# Compute both the std of the tip % given by smoker / non-smoker women / men
Select Sex, Smoker, round(std(Tip/TotalBill)*100,2) as Std_TipPercentage
FROM tips
GROUP BY Smoker, Sex;

# Compute the 'count', 'min' and 'max' for the tip_pct 
SELECT  COUNT(*) as TipCount, Round(max(Tip/TotalBill)*100,2) as MaxTip_Percentage, Round(min(Tip/TotalBill)*100,2) as MinTip_Percentage
From tips; 

# Select the top 5 generous smokers and non-smpkers
SELECT Smoker, round((Tip/TotalBill)*100,2) as TipPercentage
FROM tips
WHERE Smoker = 'yes'
ORDER BY TipPercentage
LIMIT 5;

SELECT Smoker, round((Tip/TotalBill)*100,2) as TipPercentage
FROM tips
WHERE Smoker = 'no'
ORDER BY TipPercentage
LIMIT 5;

# Show the percentiles of the tip_pct of smokers and non-smokers
SELECT Smoker, 
round((Tip/TotalBill)*100,2) as TipPercentage,
TotalBill,
ROUND(
PERCENT_RANK()
    OVER (
        PARTITION BY Smoker
        ORDER BY Tip/TotalBill
    ),2) as Tip_PercentileRank
FROM tips
WHERE Smoker = 'yes';

SELECT Smoker, 
round((Tip/TotalBill)*100,2) as TipPercentage,
TotalBill,
ROUND(
PERCENT_RANK()
    OVER (
        PARTITION BY Smoker
        ORDER BY Tip/TotalBill
    ),2) as Tip_PercentileRank
FROM tips
WHERE Smoker = 'no';
