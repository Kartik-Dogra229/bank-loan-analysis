

--BANK LOAN ANALYSIS 
   

--STEP 1: CREATE DATABASE 
Create Database BankLoanAnalysis


Use BankLoanAnalysis



--STEP 2: CREATE TABLE

Create Table bank_loan_data 
    (id int,
    address_state varchar(50),
    application_type varchar(50),
    emp_length varchar(50),
    emp_title varchar(255),
    grade varchar(10),
    home_ownership varchar(50),
    issue_date date,
    last_credit_pull_date date,
    last_payment_date date,
    loan_status varchar(50),
    next_payment_date date,
    member_id bigint,
    purpose varchar(100),
    sub_grade varchar(20),
    term varchar(50),
    verification_status varchar(50),
    annual_income int,
    dti float,
    installment int,
    int_rate float,
    loan_amount varchar(50),
    total_acc int,
    total_payment varchar(50),
    loan_category varchar(50),
    issue_month int,
    issue_month_name varchar(20),
    issue_year int,
    repayment_ratio float,
    income_band varchar(50),
    dti_band varchar(50))


 --STEP 3: IMPORT CSV
 

Truncate table bank_loan_data;

Bulk Insert bank_loan_data
from 'C:\Users\lenovo\OneDrive\Desktop\processed\bank-loan-analysis.csv'
with (FIRSTROW = 2,
FORMAT = 'CSV',
FIELDQUOTE = '"',
FIELDTERMINATOR = ',',
ROWTERMINATOR = '0x0a',
CODEPAGE = '65001',
TABLOCK)


 --DATA CLEANING QUERIES
   

/* Convert currency fields into numeric values */
Select
    Replace(Replace(loan_amount,'$',''),',','') as CleanLoanAmount
from bank_loan_data

/* Missing Values Check */
Select *
from bank_loan_data
where loan_status IS NULL


--KPI QUERIES
  

/* Total Loan Applications */
Select Count(*) as Total_Loan_Applications
from bank_loan_data

/* Total Funded Amount */
Select Sum(Cast(Replace(Replace(loan_amount,'$',''),',','') as float))
as Total_Funded_Amount
from bank_loan_data

/* Total Amount Received */
Select Sum(Cast(Replace(Replace(total_payment,'$',''),',','') as float))
as Total_Amount_Received
from bank_loan_data

/* Average Interest Rate */
Select Avg(Cast(Replace(int_rate,'%','') as float))
as Avg_Interest_Rate
from bank_loan_data

/* Average DTI */
Select Avg(Cast(dti AS FLOAT)) as Avg_DTI
from bank_loan_data

--MONTHLY TREND ANALYSIS
   

/* Monthly Loan Applications */
Select issue_year,issue_month,Count(*) as Applications
from bank_loan_data
Group by issue_year, issue_month
Order by issue_year, issue_month

/* Monthly Funded Amount */
Select issue_year,issue_month,Sum(Cast(Replace(Replace(loan_amount,'$',''),',','') as float))
    as Funded_Amount
from bank_loan_data
Group by issue_year, issue_month
Order by issue_year, issue_month

/* Monthly Amount Received */
Select issue_year,issue_month,Sum(Cast(Replace(Replace(total_payment,'$',''),',','') as float))
    as Amount_Received
from bank_loan_data
Group by issue_year, issue_month
Order by issue_year, issue_month


--LOAN STATUS ANALYSIS


Select loan_status,Count(*) as Loan_Count
from bank_loan_data
Group by loan_status
Order by Loan_Count desc

/* Funded Amount by Loan Status */
Select
    loan_status,
    Sum(Cast(Replace(Replace(loan_amount,'$',''),',','') as float))
    as Funded_Amount
from bank_loan_data
Group by loan_status


--STATE ANALYSIS
  

Select address_state,Count(*) as Applications
from bank_loan_data
Group by address_state
Order by Applications desc

--LOAN PURPOSE ANALYSIS
   

Select purpose,Count(*) as Loan_Count
from bank_loan_data
Group by purpose
Order by Loan_Count desc


--HOME OWNERSHIP ANALYSIS
 

Select home_ownership,Count(*) as Customer_Count
from bank_loan_data
Group by home_ownership


 --GRADE ANALYSIS
   

Select grade,Count(*) as Loan_Count,avg(repayment_ratio) as Avg_Repayment_Ratio
from bank_loan_data
Group by grade
Order by grade


--INCOME BAND ANALYSIS
   
Select income_band,Count(*) as Customers
from bank_loan_data
Group by income_band
Order by Customers desc

--TOP 10 LOANS
   

Select Top 10 id,purpose,Cast(Replace(Replace(loan_amount,'$',''),',','') as float)
    as Loan_Amount
from bank_loan_data
Order by Loan_Amount desc

/* END OF PROJECT */
