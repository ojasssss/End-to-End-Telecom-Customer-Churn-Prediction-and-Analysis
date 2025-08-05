# 📊 Customer Churn Prediction & Analysis

An end-to-end data science project to analyze customer churn using Python and SQL, build an interpretable ML model with PCA + Logistic Regression, and present business insights via Power BI dashboards.

## 🔧 Tools & Technologies Used:
SQL (MySQL), Python (Pandas, Seaborn, Scikit-learn), Jupyter Notebook, Power BI, PCA + Logistic Regression

## 🔍 1. Data Analysis (Python)

- Cleaned and standardized column names
- Handled missing values and converted columns to appropriate types (numeric/categorical)
- Encoded categorical variables for modeling
- Visualized churn behavior across features like:
  - 📃 Contract type
  - 🧓 Senior citizen status
  - 💰 Monthly charges
  - 📶 Internet service & tenure
- Identified key churn-inducing factors using univariate and bivariate plots

## 🧠 2. ML Model: PCA + Logistic Regression

- Applied **PCA** to reduce dimensionality while retaining ~86% variance with 20 components
- Integrated PCA into a `Pipeline` with Logistic Regression
- Achieved strong model performance:
  - ✅ Train Accuracy: 96%
  - ✅ Test Accuracy: 94%
  - 🎯 ROC AUC: 0.97+
- Chose this model for **interpretability** and stakeholder communication
- Performed hyperparameter tuning using `GridSearchCV`

## 🛢️ 3. SQL Analysis

Structured SQL queries to extract key insights:
- **General Overview**:
  - Total customers, gender distribution, internet service usage
  - Monthly charge stats and city-wise splits
- **Customer Profile by Status**:
  - Behavior comparison: Active vs Churned
  - Age group & contract type patterns
- **Churn-Specific**:
  - Top churn reasons (tenure, charges)
  - Demographics & services impact

## 📈 4. Power BI Dashboard

Built interactive KPIs and visuals to represent:

- Overall churn percentage
- Churn by contract type and senior citizen status
- Tenure and monthly charge comparisons
- Demographic and service usage filters
- 🔄 Added churn icons & clean layout for business storytelling
  
## ✅ Key Outcomes

- Created a **highly interpretable model** using PCA + Logistic Regression  
- **Transformed raw data** into model-ready form through Python and SQL  
- **Identified top churn indicators** to support targeted strategies  
- Developed an **interactive Power BI dashboard** for decision-makers  
- Delivered **actionable insights and churn risk profiling**

## 🗂️ Project Structure:
📁 Telecom-Churn-Analysis/
├── SQL\_Analysis/
│   └── telecom\_churn\_queries.sql
├── EDA\_ML\_Model/
│   ├── telecom\_churn\_eda.ipynb
│   └── churn\_model\_with\_pca\_logistic.ipynb
├── PowerBI\_Dashboard/
│   └── telecom\_churn\_dashboard.pbix
├── Data/
│   ├── Customer\_churn.csv
│   └── Zipcode\_population.csv
├── README.md

## 📥 Datasets
Customer_churn.csv – Main dataset with telecom customer info and churn label

Zipcode_population.csv – Supplementary dataset used for regional insights

🙋‍♂️ Author
Ojas Yeole
📧 ojasyeole1271@gmail.com
🔗 https://www.linkedin.com/in/ojasyeole/

