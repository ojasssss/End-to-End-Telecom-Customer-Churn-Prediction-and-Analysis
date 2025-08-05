-- 1. Gender Distribution by Customer Status 
-- Gender distribution for churned, joined, and stayed customers
WITH status_customer AS (
  SELECT `customer_status`, COUNT(*) AS total_count
  FROM customer_churn
  GROUP BY `customer_status`
)
SELECT 
  c.`customer_status`, 
  c.gender, 
  COUNT(*) AS count,
  ROUND((COUNT(*) * 100) / (SELECT st.total_count), 2) AS percentage
FROM customer_churn AS c
JOIN status_customer AS st
ON c.`customer_status` = st.`customer_status`
GROUP BY `customer_status`, gender
ORDER BY `customer_status`, gender;


-- 2. Age group distribution by customer status

WITH age_customer AS (
  SELECT 
    customer_status, 
    CASE
      WHEN age < 30 THEN 'Under 30'
      WHEN age >= 30 AND age < 50 THEN '30-50'
      WHEN age BETWEEN 50 AND 70 THEN '50-70'
      WHEN age >= 70 THEN 'Above 70'
    END AS age_group,
    COUNT(*) AS count
  FROM customer_churn 
  GROUP BY customer_status, 
    CASE
      WHEN age < 30 THEN 'Under 30'
      WHEN age >= 30 AND age < 50 THEN '30-50'
      WHEN age BETWEEN 50 AND 70 THEN '50-70'
      WHEN age >= 70 THEN 'Above 70'
    END
),
status_total AS (
  SELECT customer_status, COUNT(*) AS total_count 
  FROM customer_churn 
  GROUP BY customer_status
)
SELECT 
  a.customer_status, 
  a.age_group, 
  a.count,
  ROUND(a.count * 100.0 / st.total_count, 2) AS percentage 
FROM age_customer AS a
JOIN status_total AS st ON a.customer_status = st.customer_status
ORDER BY a.customer_status, a.age_group;



-- 3. Cities with most churned, joined, and stayed customers

SELECT 
  city,
  customer_status,
  COUNT(*) AS count 
FROM customer_churn 
GROUP BY city, customer_status
ORDER BY count DESC;

-- 4. Internet type usage by customer status

WITH status_customer AS (
  SELECT customer_status, COUNT(*) AS total_count 
  FROM customer_churn 
  GROUP BY customer_status
)
SELECT 
  internet_type, 
  c.customer_status, 
  COUNT(*) AS count,
  ROUND(COUNT(*) * 100.0 / st.total_count, 2) AS percentage 
FROM customer_churn AS c 
JOIN status_customer AS st 
  ON c.customer_status = st.customer_status
GROUP BY internet_type, c.customer_status;

--  5. Average revenue and GB consumed per status

SELECT 
  customer_status,
  ROUND(AVG(total_revenue), 2) AS average_total_revenue,
  ROUND(AVG(avg_monthly_gb_download), 2) AS average_gb_consumed 
FROM customer_churn 
GROUP BY customer_status;

-- 6. Unlimited data usage per status
SELECT 
  customer_status, 
  COUNT(*) AS count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_churn WHERE unlimited_data = 'Yes'), 2) AS percentage
FROM customer_churn 
WHERE unlimited_data = 'Yes'
GROUP BY customer_status;

-- 7. Streaming services usage by status

SELECT 
  customer_status,
  SUM(CASE WHEN streaming_tv = 'Yes' THEN 1 ELSE 0 END) AS streaming_tv,
  SUM(CASE WHEN streaming_movies = 'Yes' THEN 1 ELSE 0 END) AS streaming_movies,
  SUM(CASE WHEN streaming_music = 'Yes' THEN 1 ELSE 0 END) AS streaming_music
FROM customer_churn 
GROUP BY customer_status;

-- 8. Customers using all three streaming services
SELECT 
  COUNT(*) AS total_users 
FROM customer_churn 
WHERE 
  streaming_tv = 'Yes' 
  AND streaming_movies = 'Yes' 
  AND streaming_music = 'Yes';
