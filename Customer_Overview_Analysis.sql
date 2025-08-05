--  1. Customer Acquisition Count
SELECT COUNT(*) AS total_customers 
FROM customer_churn 
WHERE customer_status = "Joined";

-- 2. Gender Distribution of Joined Customers
SELECT gender, COUNT(*) AS count,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_churn WHERE customer_status = "Joined"), 2) AS percentage 
FROM customer_churn 
WHERE customer_status = "Joined" 
GROUP BY gender;

-- 3. Age Group Distribution of Joined Customers
SELECT 
  CASE
    WHEN age < 30 THEN 'Under 30'
    WHEN age BETWEEN 30 AND 50 THEN '30–50'
    WHEN age BETWEEN 50 AND 70 THEN '50–70'
    ELSE 'Above 70'
  END AS Age_group,
  COUNT(*) AS count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_churn WHERE customer_status = "Joined"), 2) AS percentage
FROM customer_churn
WHERE customer_status = "Joined"
GROUP BY Age_group;


-- 4. Top Cities with Most Joined Customers

SELECT city, COUNT(*) AS joined_count 
FROM customer_churn 
WHERE customer_status = "Joined" 
GROUP BY city 
ORDER BY joined_count DESC 
LIMIT 10;

-- 5. Internet Type Used by Joined Customers
SELECT internet_type, COUNT(*) AS count,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_churn WHERE customer_status = "Joined" AND internet_type IS NOT NULL), 2) AS percentage 
FROM customer_churn 
WHERE customer_status = "Joined" AND internet_type IS NOT NULL 
GROUP BY internet_type;

-- 6. Avg Revenue and Monthly Charge of Joined Customers
SELECT 
ROUND(AVG(total_revenue), 2) AS avg_total_revenue, 
ROUND(AVG(monthly_charge), 2) AS avg_monthly_charge 
FROM customer_churn 
WHERE customer_status = "Joined";


-- 7. Unlimited Data Usage by Status

SELECT customer_status, COUNT(*) AS count,
ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM customer_churn WHERE unlimited_data = "Yes"), 2) AS percentage  
FROM customer_churn  
WHERE unlimited_data = "Yes"  
GROUP BY customer_status;
