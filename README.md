# 🌍 Global Layoffs Data Cleaning Project (SQL)

![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Data Cleaning](https://img.shields.io/badge/Focus-Data%20Cleaning-green)
![Project Status](https://img.shields.io/badge/Status-Completed-success)
![Next Phase](https://img.shields.io/badge/Next-EDA-orange)

### 👉 **Click to View the SQL Data Cleaning Script and Dataset**
[![SQL](https://img.shields.io/badge/SQL-MySQL-blue)](./Data_Cleaning_Project_with_SQL.sql)
[![Dataset](https://img.shields.io/badge/Data-Global%20Layoffs-green)](./layoffs_dataset.csv)

---

## 📌 Project Overview
This project focuses on cleaning and preparing a real-world dataset containing **global employee layoff data** across multiple industries and countries.

Raw data is often messy and unreliable. In this project, I transformed unstructured data into a **clean, consistent, and analysis-ready dataset** using SQL.

🔄 **Project Phases:**
- **Phase 1:** Data Cleaning & Preparation ✅  
- **Phase 2:** Exploratory Data Analysis (EDA) *(coming next)*  

---

## 🗂️ Dataset Description
The dataset includes global layoff records with the following fields:

- 🏢 Company  
- 🌍 Location  
- 🏭 Industry  
- 👥 Total Laid Off  
- 📊 Percentage Laid Off  
- 📅 Date  
- 🚀 Company Stage  
- 🌐 Country  
- 💰 Funds Raised (Millions)  

### ⚠️ Data Issues Identified
- Duplicate records  
- Missing/null values  
- Inconsistent text formatting  
- Non-standard date formats  

---

## 🎯 Project Objectives
- ✔️ Ensure **data accuracy and consistency**  
- ✔️ Remove **duplicate records**  
- ✔️ Standardize **categorical and date fields**  
- ✔️ Handle **null and missing values**  
- ✔️ Prepare dataset for **EDA and analytics**  

---

## 🛠️ Technical Skills Demonstrated

### 🔹 Data Cleaning & Transformation
- Created **staging tables** to preserve raw data  
- Built a structured and repeatable cleaning workflow  

### 🔹 Advanced SQL (Window Functions)
```sql
ROW_NUMBER() OVER(
  PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date
)

Identified and removed duplicates with precision
🔹 Data Standardization
Used TRIM() to remove whitespace
Standardized inconsistent values (e.g., "Crypto% → Crypto")
Cleaned country formatting issues
🔹 Date Conversion

STR_TO_DATE(date, '%m/%d/%Y')

Converted text-based dates into SQL DATE format
🔹 Handling Missing Values
Replaced blanks with NULLs
Imputed missing values using self-joins
Removed unusable records
🔹 Data Integrity
Eliminated irrelevant columns (row_num)
Ensured dataset is analytics-ready

Raw Data
   ↓
Staging Table Creation
   ↓
Duplicate Detection (ROW_NUMBER)
   ↓
Duplicate Removal
   ↓
Data Standardization
   ↓
Null Handling & Imputation
   ↓
Final Clean Dataset

📸 Sample Query (Duplicate Detection)
SELECT *,
ROW_NUMBER() OVER(
  PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging;

📈 Business Impact

This project highlights the importance of clean data in decision-making:

📊 Enables accurate trend analysis
📉 Prevents misleading insights from duplicates
🌍 Improves cross-country comparability
⚡ Prepares data for dashboards and reporting

🧠 Key Learnings
Real-world data is messy and requires preprocessing
SQL is powerful for data transformation and cleaning
Window functions are essential for deduplication
Data quality directly impacts business insights

🚀 Next Steps: Exploratory Data Analysis (EDA)

In Phase 2, I will analyze:

📅 Layoff trends over time
🏭 Industry impact
🌍 Geographic distribution
💰 Relationship between funding and layoffs

🧩 Tools & Technologies
SQL (MySQL)
📬 Let's Connect

If you're a recruiter or hiring manager interested in my work, feel free to reach out or connect with me on LinkedIn!
