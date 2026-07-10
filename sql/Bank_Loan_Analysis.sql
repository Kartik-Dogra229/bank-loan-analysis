

--BANK LOAN ANALYSIS 
   

--STEP 1: CREATE DATABASE 
CREATE DATABASE BankLoanAnalysis


USE BankLoanAnalysis



--STEP 2: CREATE TABLE

CREATE TABLE bank_loan_data (
    id INT,
    address_state VARCHAR(50),
    application_type VARCHAR(50),
    emp_length VARCHAR(50),
    emp_title VARCHAR(255),
    grade VARCHAR(10),
    home_ownership VARCHAR(50),
    issue_date DATE,
    last_credit_pull_date DATE,
    last_payment_date DATE,
    loan_status VARCHAR(50),
    next_payment_date DATE,
    member_id BIGINT,
    purpose VARCHAR(100),
    sub_grade VARCHAR(20),
    term VARCHAR(50),
    verification_status VARCHAR(50),
    annual_income VARCHAR(50),
    dti VARCHAR(50),
    installment VARCHAR(50),
    int_rate VARCHAR(50),
    loan_amount VARCHAR(50),
    total_acc INT,
    total_payment VARCHAR(50),
    loan_category VARCHAR(50),
    issue_month INT,
    issue_month_name VARCHAR(20),
    issue_year INT,
    repayment_ratio FLOAT,
    income_band VARCHAR(50),
    dti_band VARCHAR(50))


 --STEP 3: IMPORT CSV
 


BULK INSERT bank_loan_data
FROM '"C:\Users\lenovo\OneDrive\Desktop\processed\bank-loan-analysis.csv"'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = 'ACP')


 --DATA CLEANING QUERIES
   

/* Convert currency fields into numeric values */
SELECT
    REPLACE(REPLACE(loan_amount,'$',''),',','') AS CleanLoanAmount
FROM bank_loan_data;

/* Missing Values Check */
SELECT *
FROM bank_loan_data
WHERE loan_status IS NULL;


--KPI QUERIES
  

/* Total Loan Applications */
SELECT COUNT(*) AS Total_Loan_Applications
FROM bank_loan_data;

/* Total Funded Amount */
SELECT SUM(CAST(REPLACE(REPLACE(loan_amount,'$',''),',','') AS FLOAT))
AS Total_Funded_Amount
FROM bank_loan_data;

/* Total Amount Received */
SELECT SUM(CAST(REPLACE(REPLACE(total_payment,'$',''),',','') AS FLOAT))
AS Total_Amount_Received
FROM bank_loan_data;

/* Average Interest Rate */
SELECT AVG(CAST(REPLACE(int_rate,'%','') AS FLOAT))
AS Avg_Interest_Rate
FROM bank_loan_data;

/* Average DTI */
SELECT AVG(CAST(dti AS FLOAT)) AS Avg_DTI
FROM bank_loan_data;

--MONTHLY TREND ANALYSIS
   

/* Monthly Loan Applications */
SELECT
    issue_year,
    issue_month,
    COUNT(*) AS Applications
FROM bank_loan_data
GROUP BY issue_year, issue_month
ORDER BY issue_year, issue_month;

/* Monthly Funded Amount */
SELECT
    issue_year,
    issue_month,
    SUM(CAST(REPLACE(REPLACE(loan_amount,'$',''),',','') AS FLOAT))
    AS Funded_Amount
FROM bank_loan_data
GROUP BY issue_year, issue_month
ORDER BY issue_year, issue_month;

/* Monthly Amount Received */
SELECT
    issue_year,
    issue_month,
    SUM(CAST(REPLACE(REPLACE(total_payment,'$',''),',','') AS FLOAT))
    AS Amount_Received
FROM bank_loan_data
GROUP BY issue_year, issue_month
ORDER BY issue_year, issue_month;


--LOAN STATUS ANALYSIS


SELECT
    loan_status,
    COUNT(*) AS Loan_Count
FROM bank_loan_data
GROUP BY loan_status
ORDER BY Loan_Count DESC;

/* Funded Amount by Loan Status */
SELECT
    loan_status,
    SUM(CAST(REPLACE(REPLACE(loan_amount,'$',''),',','') AS FLOAT))
    AS Funded_Amount
FROM bank_loan_data
GROUP BY loan_status;


--STATE ANALYSIS
  

SELECT
    address_state,
    COUNT(*) AS Applications
FROM bank_loan_data
GROUP BY address_state
ORDER BY Applications DESC;

--LOAN PURPOSE ANALYSIS
   

SELECT
    purpose,
    COUNT(*) AS Loan_Count
FROM bank_loan_data
GROUP BY purpose
ORDER BY Loan_Count DESC;


--HOME OWNERSHIP ANALYSIS
 

SELECT
    home_ownership,
    COUNT(*) AS Customer_Count
FROM bank_loan_data
GROUP BY home_ownership;


 --GRADE ANALYSIS
   

SELECT
    grade,
    COUNT(*) AS Loan_Count,
    AVG(repayment_ratio) AS Avg_Repayment_Ratio
FROM bank_loan_data
GROUP BY grade
ORDER BY grade;


--INCOME BAND ANALYSIS
   

SELECT
    income_band,
    COUNT(*) AS Customers
FROM bank_loan_data
GROUP BY income_band
ORDER BY Customers DESC;

--TOP 10 LOANS
   

SELECT TOP 10
    id,
    purpose,
    CAST(REPLACE(REPLACE(loan_amount,'$',''),',','') AS FLOAT)
    AS Loan_Amount
FROM bank_loan_data
ORDER BY Loan_Amount DESC;

/* END OF PROJECT */
