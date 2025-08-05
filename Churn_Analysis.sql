use ojasdb;

CREATE TABLE customer_churn (
    `customer_id` VARCHAR(255),
    `gender` VARCHAR(255),
    `age` INT,
    `married` VARCHAR(255),
    `number_of_dependents` INT,
    `city` VARCHAR(255),
    `zip_code` INT,
    `latitude` FLOAT,
    `longitude` FLOAT,
    `number_of_referrals` INT,
    `tenure_in_months` INT,
    `offer` VARCHAR(255),
    `phone_service` VARCHAR(255),
    `avg_monthly_long_distance_charges` FLOAT,
    `multiple_lines` VARCHAR(255),
    `internet_service` VARCHAR(255),
    `internet_type` VARCHAR(255),
    `avg_monthly_gb_download` FLOAT,
    `online_security` VARCHAR(255),
    `online_backup` VARCHAR(255),
    `device_protection_plan` VARCHAR(255),
    `premium_tech_support` VARCHAR(255),
    `streaming_tv` VARCHAR(255),
    `streaming_movies` VARCHAR(255),
    `streaming_music` VARCHAR(255),
    `unlimited_data` VARCHAR(255),
    `contract` VARCHAR(255),
    `paperless_billing` VARCHAR(255),
    `payment_method` VARCHAR(255),
    `monthly_charge` FLOAT,
    `total_charges` FLOAT,
    `total_refunds` FLOAT,
    `total_extra_data_charges` INT,
    `total_long_distance_charges` FLOAT,
    `total_revenue` FLOAT,
    `customer_status` VARCHAR(255),
    `churn_category` VARCHAR(255),
    `churn_reason` VARCHAR(255)
);



LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customer_churn.csv'
INTO TABLE customer_churn
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    customer_id,
    gender,
    age,
    married,
    number_of_dependents,
    city,
    zip_code,
    latitude,
    longitude,
    number_of_referrals,
    tenure_in_months,
    offer,
    phone_service,
    @avg_monthly_long_distance_charges,
    multiple_lines,
    internet_service,
    internet_type,
    @avg_monthly_gb_download,
    online_security,
    online_backup,
    device_protection_plan,
    premium_tech_support,
    streaming_tv,
    streaming_movies,
    streaming_music,
    unlimited_data,
    contract,
    paperless_billing,
    payment_method,
    @monthly_charge,
    @total_charges,
    @total_refunds,
    @total_extra_data_charges,
    @total_long_distance_charges,
    @total_revenue,
    customer_status,
    churn_category,
    churn_reason
)
SET
    avg_monthly_long_distance_charges = NULLIF(@avg_monthly_long_distance_charges, ''),
    avg_monthly_gb_download = NULLIF(@avg_monthly_gb_download, ''),
    monthly_charge = NULLIF(@monthly_charge, ''),
    total_charges = NULLIF(@total_charges, ''),
    total_refunds = NULLIF(@total_refunds, ''),
    total_extra_data_charges = NULLIF(@total_extra_data_charges, ''),
    total_long_distance_charges = NULLIF(@total_long_distance_charges, ''),
    total_revenue = NULLIF(@total_revenue, '');
    
#############################################################################################################

-- 1. Verify the Data

SELECT * FROM customer_churn LIMIT 5;

-- Count rows
SELECT COUNT(*) FROM customer_churn;

-- Check for NULLs in critical columns
SELECT COUNT(*) FROM customer_churn WHERE avg_monthly_long_distance_charges IS NULL;

#############################################################################################################

-- 2. Perform Descriptive Analysis

-- Count by churn status
SELECT customer_status, COUNT(*) AS total_customers
FROM customer_churn
GROUP BY customer_status;

-- Average charges by internet type
SELECT internet_type, 
       AVG(monthly_charge) AS avg_monthly_charge
FROM customer_churn
GROUP BY internet_type;

-- Tenure distribution
SELECT tenure_in_months, COUNT(*) FROM customer_churn GROUP BY tenure_in_months;

#############################################################################################################
-- Business Questions

-- What are the most common churn reasons?
-- Top churn reasons
SELECT churn_reason, COUNT(*) AS total 
FROM customer_churn 
GROUP BY churn_reason 
ORDER BY total DESC;


-- Do monthly charges or contract types affect churn?
-- Churn by contract type
SELECT contract, customer_status, COUNT(*) 
FROM customer_churn 
GROUP BY contract, customer_status;

#############################################################################################################

-- 1. Contract vs. Churn

select contract, count(*) as total_counts,
sum(case when 'customer status'='churned' then 1 else 0 END) as churned_customers,
round(sum(case when 'customer status'='churned' then 1 else 0 END)*100/count(*),2) as churn_rate
FROM customer_churn 
GROUP BY contract;

--  2. Age Group vs. Churn
SELECT 
  CASE
    WHEN age < 30 THEN 'Under 30'
    WHEN age BETWEEN 30 AND 50 THEN '30-50'
    WHEN age BETWEEN 50 AND 70 THEN '50-70'
    WHEN age > 70 THEN 'Above 70'
  END AS Age_group,
  SUM(CASE WHEN `customer_status` = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(SUM(CASE WHEN `customer_status` = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_Rate
FROM customer_churn
GROUP BY Age_group;

--  3. Internet Type vs. Churn

SELECT 
  internet_type,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY internet_type;

 -- 4.Is the Company Losing High-Value Customers?
 SELECT 
  customer_status,
  ROUND(AVG(total_revenue), 2) AS avg_revenue,
  COUNT(*) AS count
FROM customer_churn
GROUP BY customer_status;
