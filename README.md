# Kickstarter-SQL-Project
# 📊 Kickstarter Data Analysis (SQL)

##  Project Overview  
This project analyzes Kickstarter project data from **two datasets** (`ks-projects-201612` and `ks-projects-201801`) by joining them into a consolidated table (`Full_Projects_Tables`). The analysis explores funding trends, project success factors, and country/category performance using **SQL Server**.

---

##  Dataset Details  
- **Key columns**:  
  - `ID` → Unique project ID  
  - `name` → Project title  
  - `category` / `main_category` → Project classification  
  - `currency` / `country` → Funding currency & location  
  - `goal`, `usd_goal_real` → Funding goal (local & USD)  
  - `usd_pledged`, `usd_pledged_real` → Amount pledged (local & USD)  
  - `state` → Project outcome (successful, failed, canceled)  
  - `backers` → Number of backers  
  - `launched`, `deadline` → Project timeline  

---

##  SQL Tasks Performed Available in(https://github.com/Henrykinyara/Kickstarter-SQL-Project/blob/main/SQL/Kickstarter%20Project.sql)

###  Data Preparation  
- Joined the two datasets into one unified table  
- Cleaned inconsistent datatypes (`nvarchar` → numeric/date types)  
- Removed redundant columns  

### Analysis Queries  
1. **Count**: Total number of projects  
2. **Filter**: Successful vs failed vs canceled projects  
3. **Aggregate**: Average goal by main category  
4. **Ranking**: Top 5 projects by number of backers  
5. **Percentage**: % of projects meeting or exceeding funding goal  
6. **Country comparison**: Average pledged amounts by country  
7. **Time-based**: Success rates by year/month (seasonality trends)  
8. **Category performance**: Best-performing categories under $10,000 goal  
9. **Backers vs. success**: Average backers by project outcome  
10. **Multi-condition**: Median goal of failed projects by category & country  

---

## Key Insights  
- More backers strongly correlate with project success  
- Categories with goals below $10,000 tend to have higher success rates  
- Seasonality shows certain months/years have better outcomes  
- Countries vary in average pledged amounts  

---

##  Tech Stack  
- **SQL Server** 
- **GitHub** for version control  

---
