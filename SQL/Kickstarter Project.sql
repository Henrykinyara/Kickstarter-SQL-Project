Use HenryKinyaraDatabase;

Select*From [ks-projects-201612]; --Viewing data from table 1
Select*From [ks-projects-201801];-- Viewing data from table 2

--Dropping NULL columns
Alter Table [ks-projects-201612]
Drop Column column14,column15,column16,column17;

--Joining both tables

Select*from [ks-projects-201612] as K1 Inner join [ks-projects-201801] as K2
on K1.ID=K2.ID;



--Creating a new table using both tables
Select [ks-projects-201612].ID,[ks-projects-201612].name,[ks-projects-201612].category,[ks-projects-201612].main_category,
[ks-projects-201612].currency,[ks-projects-201612].deadline,[ks-projects-201612].goal,[ks-projects-201612].launched,[ks-projects-201612].usd_pledged,
[ks-projects-201612].state,[ks-projects-201612].backers,[ks-projects-201612].country,[ks-projects-201801].usd_pledged_real,[ks-projects-201801].usd_goal_real
into Full_Projects_Tables
from
[ks-projects-201612] Inner join [ks-projects-201801] 
on [ks-projects-201612].ID=[ks-projects-201801].ID;

Select*From Full_Projects_Tables;


--Cleaning of column Data
--a)Goal Column
SELECT ID,goal
FROM Full_Projects_Tables
WHERE TRY_CAST(goal AS float) IS NULL --Checking problematic rows in goal column
  AND goal IS NOT NULL;

 DELETE FROM Full_Projects_Tables
WHERE TRY_CAST(goal AS float) IS NULL
  AND goal IS NOT NULL;


 SELECT ID,deadline
FROM Full_Projects_Tables
WHERE TRY_CAST(deadline AS datetime) IS NULL--Checking problematic rows in deadline column
  AND goal IS NOT NULL;

  SELECT ID,currency
FROM Full_Projects_Tables
WHERE TRY_CAST(currency AS varchar) IS NULL--Checking problematic rows in deadline column
  AND goal IS NOT NULL;

  SELECT ID,deadline
FROM Full_Projects_Tables
WHERE TRY_CAST(deadline AS datetime) IS NULL--Checking problematic rows in deadline column
  AND goal IS NOT NULL;



--ALtering column data types
Alter Table Full_Projects_Tables-- Altering goal column data type
Alter column Goal Float;

Alter Table Full_Projects_Tables-- Altering usd_pledged real column data type
Alter column usd_pledged_real Float;

Alter Table Full_Projects_Tables-- Altering backerscolumn data type
Alter column backers Float;


--How many Projects are in the dataset

Select COUNT(ID) as total_number_of_Projects from Full_Projects_Tables;

--Success rate of all projects by main category

Select Count(state) as Successful_Projects, Full_Projects_Tables.main_category from Full_Projects_Tables
where Full_Projects_Tables.state like 'successful'
Group by Full_Projects_Tables.main_category ;    -- Successful projects

Select Count(state) as Failed_Projects, Full_Projects_Tables.main_category from Full_Projects_Tables
where Full_Projects_Tables.state like 'failed'
Group by Full_Projects_Tables.main_category ;    -- Failed projects

Select Count(state) as Canceled_projects, Full_Projects_Tables.main_category from Full_Projects_Tables
where Full_Projects_Tables.state like 'canceled'
Group by Full_Projects_Tables.main_category ;    --Canceled projects 

--Average goal amount by main category

Select AVG(goal) as Average_Goal, Full_Projects_Tables.main_category from Full_Projects_Tables
Group by Full_Projects_Tables.main_category;

--Top 5 Projects with the highest number of backers

Select Top 5 Full_Projects_Tables.name,  Full_Projects_Tables.backers from Full_Projects_Tables
Order by Full_Projects_Tables.backers desc;

--Projects that met or exceeded their funding goals

SELECT 
    CAST(SUM(CASE WHEN usd_pledged_real >= usd_goal_real THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) 
    AS SuccessPercentage
FROM Full_Projects_Tables;

--Highest pledged amount by country

SELECT country, AVG(usd_pledged_real) AS AvgPledged
FROM Full_Projects_Tables
GROUP BY country
ORDER BY AvgPledged DESC;


--Success Rate by year

SELECT 
    YEAR(launched) AS LaunchYear,
    MONTH(launched) AS LaunchMonth,
    CAST(SUM(CASE WHEN state = 'successful' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS SuccessRate
FROM Full_Projects_Tables
GROUP BY YEAR(launched), MONTH(launched)
ORDER BY LaunchYear, LaunchMonth;

--Category perfomance

SELECT main_category,
    CAST(SUM(CASE WHEN state = 'successful' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS SuccessRate
FROM Full_Projects_Tables
WHERE goal < 10000
GROUP BY main_category
ORDER BY SuccessRate DESC;

--Backers vs Success
SELECT state, AVG(backers) AS AvgBackers
FROM Full_Projects_Tables
GROUP BY state
ORDER BY AvgBackers DESC;

--Failed Projects
SELECT main_category, country,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY goal) OVER (PARTITION BY main_category, country) AS MedianGoal
FROM Full_Projects_Tables
WHERE state = 'failed';


