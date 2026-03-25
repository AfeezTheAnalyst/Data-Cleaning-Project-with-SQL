-- END TO END SQL DATA CLEANING PROJECT

-- This database contains staff or employee layoff data across the globe:
-- Things I'm going to be doing --
	-- Data Cleaning
			-- Remove duplicates
            -- Standardize data
            -- Null or blank values
            -- Remove irrelevant column & rows
    
SELECT * FROM layoffs;
-- CREATING A DUPLICATE OF THE LAYOFFS AS A STAGING TABLE TO AVOID MESSING WITH THE MAIN DATA

CREATE TABLE layoff_staging
LIKE layoffs;

SELECT * FROM layoff_staging;
RENAME TABLE layoff_staging TO layoffs_staging;

-- NOW INSERT RECORDS INTO THE STAGING TABLE
INSERT layoffs_staging
SELECT * FROM layoffs;

-- LOOKING AT THE DATA, NO UNIQUE IDENTIFIER, REMOVING DUPLICATES COULD BE AN ISSUE. 
-- WE'LL CREATE A ROW NUM AND MATCH WITH SOME COLUMNS, THIS HELP REVEAL ANY DUPLICATES.

-- THERE MIGHT BE SOME RECORDS THAT ARE NOT DUPLICATES BUT LOOKS LIKE THEY DUPLICATES
-- ITS A GOOD PRACTICE TO RUN THE PARTITION OVER ALL THE COLUMNS.

SELECT *,
ROW_NUMBER () OVER(PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num 
FROM layoffs_staging;

WITH duplicates_cte AS 
(
SELECT *,
ROW_NUMBER () OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num 
FROM layoffs_staging
)
SELECT * FROM duplicates_cte
WHERE row_num > 1;



SELECT *,
ROW_NUMBER () OVER(PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num 
FROM layoffs_staging;

WITH duplicates_cte AS 
(
SELECT *,
ROW_NUMBER () OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num 
FROM layoffs_staging
)

DELETE FROM duplicates_cte
WHERE row_num > 1;

-- RUNNING THE LAST QUERY CANT BE DONE AS CTE IS UPDATABLE BECAUSE "DELETE" IS LIKE AN UPDATE STATEMENT. HERE'S THE APPROACH I'LL TAKE:
-- CREATE ANOTHER TABLE, SAY STAGGING 2, INSERT ALL THE RECORDS FROM OUR WINDOW FUNCTION, FILTER BY ROW_NUM, AND DELETE THE DUPLICATES
SELECT *,
ROW_NUMBER () OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num 
FROM layoffs_staging;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER () OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num 
FROM layoffs_staging;

SELECT * FROM layoffs_staging2
WHERE row_num >1;

DELETE FROM layoffs_staging2
WHERE row_num > 1;

SET SQL_SAFE_UPDATES = 0;

SELECT * FROM layoffs_staging2;


-- NOW THAT WE'VE DELETED THOSE DUPLICATES, WE CAN THEN REMOVE THE row_num COLUMN.

-- 2 STANDARDIZING DATA: Finding and fixing issues in the data

-- REMOVE EXTRA SPACES IN THE company COLUMN
SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = trim(company);

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT * FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE country LIKE 'United States%';

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country) AS 'trailing'
FROM layoffs_staging2

ORDER BY 1;

UPDATE layoffs_staging2
SET  country =  TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT *
FROM layoffs_staging2;

-- LOOKING AT THE DATE COLUMN THERE'S NEED TO STANDARDIZE IT

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;

-- CHANGING THE DATE COLUMN TO DATE DATA TYPE.
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- WORKING WITH NULL OR BLANK VALUES
SELECT * FROM layoffs_staging2
WHERE  total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = ''; 

SELECT * 
FROM layoffs_staging2
WHERE company LIKE "Airbnb%";

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;


UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%'; 

-- FOR THIS PROJECT WE DO NOT NEED RECORDS WITH NO LAIDOFF INFORMATION,
-- SO WE DELETE THEM

SELECT * 
FROM layoffs_staging2
WHERE  total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE  total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT * 
FROM layoffs_staging2;
