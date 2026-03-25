![Next Phase](https://img.shields.io/badge/Next-EDA-orange)

### 👉 **Click to View the SQL Data Cleaning Script and Dataset**
[![SQL](https://img.shields.io/badge/SQL-MySQL-blue)](./Data_Cleaning_Project_with_SQL.sql)
[![Dataset](https://img.shields.io/badge/Data-Global%20Layoffs-green)](./layoffs_dataset.csv)

# 🌍 Global Layoffs Data Cleaning Project (SQL)

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

## 🔹 Data Cleaning Highlights

### Duplicate Detection
```sql
SELECT *,
ROW_NUMBER() OVER(
  PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging;
```
Identified and removed duplicates with precision

### 🔹 Data Standardization
- Used TRIM() to remove whitespace
- Standardized inconsistent values (e.g., "Crypto%" → "Crypto")
- Cleaned country formatting issues

- Handling Missing Values
- Replaced blanks with NULLs
- Imputed missing values using self-joins
- Removed unusable records

### 🔹 Date Conversion
```sql
STR_TO_DATE(date, '%m/%d/%Y')
```
Converted text-based dates into SQL DATE format

### 🔹🔄 Data Cleaning Workflow
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


### 🔹 📈 Business Impact
📊 Enables accurate trend analysis
📉 Prevents misleading insights from duplicates
🌍 Improves cross-country comparability
⚡ Prepares data for dashboards and reporting

### 🔹 🧠 Lessons Learned
- Real-world datasets are rarely clean and require careful preprocessing
- SQL window functions like ROW_NUMBER() are powerful for deduplication
- Handling missing and inconsistent data is critical to ensure accurate analysis
- Standardizing text and date formats prevents downstream errors in reporting
- Maintaining data integrity allows for more reliable insights


### 🔹💡 Why This Project is Important
- Clean data is the foundation of all analytics
- Prevents misleading conclusions from duplicates or null values
- Ensures that business decisions are data-driven and accurate
- Builds practical skills in SQL, data cleaning, and preprocessing, which are highly sought after by employers

### 🔹 🧩 Tools & Technologies
SQL (MySQL)


## 🚀** Next Steps: Exploratory Data Analysis (EDA)**

In Phase 2, I will analyze:

📅 Layoff trends over time
🏭 Industry impact
🌍 Geographic distribution
💰 Relationship between funding and layoffs

📬 Let's Connect

If you're a recruiter or hiring manager interested in my work, feel free to reach out or connect with me on LinkedIn!
https://www.linkedin.com/in/afeez-akinleye/
