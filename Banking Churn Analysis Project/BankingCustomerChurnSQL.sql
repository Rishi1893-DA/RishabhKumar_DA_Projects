CREATE DATABASE banking_customer_churn;
USE banking_customer_churn;

-- Create Table
CREATE TABLE customer_churn (
    RowNumber INT,
    CustomerId BIGINT,
    Surname VARCHAR(100),
    CreditScore INT,
    CreditScoreBucket VARCHAR(30),
    Geography VARCHAR(50),
    Gender VARCHAR(20),
    Age INT,
    AgeBucket VARCHAR(30),
    Tenure INT,
    Balance DECIMAL(15,2),
    BalanceBucket VARCHAR(30),
    NumOfProducts INT,
    HasCrCard INT,
    IsActiveMember TINYINT,
    EstimatedSalary DECIMAL(15,2),
    SalaryBucket VARCHAR(30),
    Exited TINYINT
);

select * from customer_churn;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/BankingCustomerChrunCSV.csv'
INTO TABLE customer_churn
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 1. Total Customers
select count(*) as Total_Customers
from customer_churn;

-- 2. Total Churned Customers
select count(*) as total_customers
from customer_churn
where exited = 1;

-- 3. Total Active Customers
select count(*) as active_customers
from customer_churn
where exited = 0;

-- 4. Churn Rate
select round(count(case when exited = 1 then 1 end)*100/count(*),2)
as churn_rate
from customer_churn;

-- 5. Retention Rate
select round(count(case when exited = 0 then 1 end)*100/count(*),2)
as retention_rate
from customer_churn;

-- 6. Average Credit Score
select round(avg(CreditScore),0) as avg_creditscore
from customer_Churn;

-- 7. Average Balance
select round(avg(Balance),0) as avg_balance
from customer_Churn;

-- 8. Total Balance
select round(sum(balance),0) as total_balance
from customer_Churn;

-- 9. Average Estimated Salary
select round(avg(estimatedsalary),0) as avg_salary
from customer_churn;

-- 10. Active members vs Inactive members
select IsActiveMember,count(*) as Customers
from Customer_Churn
group by IsActiveMember;

-- 11. Credit Card Holders
select HasCrCard, count(*) as customers
from customer_churn
group by HasCrCard;

-- 12. Churn by Gender
select gender, count(*) as customers,
sum(exited) as churned
from customer_churn
group by gender;

-- 13. Churn by Age Bucket
select agebucket, count(*) as customers,
sum(exited) as churned
from customer_churn
group by agebucket;

-- 14. Churn by Geography
select geography, count(*) as customers,
sum(exited) as churned
from customer_churn
group by geography;

-- 15. Top 10 customers by balance
select customerid, surname, balance
from customer_churn
order by balance desc
limit 10;

-- 16. Top 10 customers by credit score
select customerid, surname, creditscore
from customer_churn
order by creditscore desc
limit 10;

-- 17. Average Balance by Geography
select geography,
round(avg(balance),2) as avg_balance
from customer_churn
group by geography
order by avg_balance desc;

-- 18. Average salary by geography
select geography,
round(avg(estimatedsalary),2) as avg_salary
from customer_churn
group by geography
order by avg_salary desc;