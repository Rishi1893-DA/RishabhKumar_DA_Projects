create database hr_attrition_data_analysis;
use hr_attrition_data_analysis;

CREATE TABLE hr_employee_attrition (
    Age INT,
    Attrition VARCHAR(20),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeCount INT,
    EmployeeNumber INT PRIMARY KEY,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

select * from hr_employee_attrition;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HR-Employee-Attrition-CSV.csv'
INTO TABLE hr_employee_attrition
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 1. Total Employees
select count(*) as total_employees
from hr_employee_attrition;

-- 2. Total Attrition Count
select count(*) as total_attrition_count
from hr_employee_attrition
where attrition ='yes';

-- 3. Active Employees
select count(*) as active_employees
from hr_employee_attrition
where attrition = 'no';

-- 4. Attrition Rate
select round(sum(case when attrition = 'yes' then 1 else 0 end) *100/count(*),2)
as attrition_rate;

-- 5. Average Age
select round(avg(age),0) as average_age
from hr_employee_attrition;

-- 6. Average Monthly Income
select round(avg(monthlyincome),0) as average_income
from hr_employee_attrition;

-- 7. Average Years at Company
select round(avg(yearsatcompany),0) as average_years
from hr_employee_attrition;

-- 8. Average Job Satisfaction
select round(avg(jobsatisfaction),0) as job_satisfaction
from hr_employee_attrition;

-- 9. Attrition by Department
select department, count(*) as total_employees,
sum(case when attrition = 'yes' then 1 else 0 end) as attrition_count
from hr_employee_attrition
group by 1
order by attrition_count desc;

-- 10. Attrition by Job Role
select jobrole, count(*) as total_employees,
sum(case when attrition = 'yes' then 1 else 0 end) as attrition_count
from hr_employee_attrition
group by 1
order by attrition_count desc;

-- 11. Attrition by Gender
select gender, count(*) as total_employees,
sum(case when attrition = 'yes' then 1 else 0 end) as attrition_count
from hr_employee_attrition
group by 1
order by attrition_count desc;




