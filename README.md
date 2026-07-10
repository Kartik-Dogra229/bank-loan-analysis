# 🏦 Bank Loan Portfolio Analysis
**End-to-end data analytics project — Excel · SQL · Python · Power BI**

A full-cycle analysis of 38,576 personal loans issued in 2021, built to answer one question for portfolio stakeholders: **how healthy is the loan book, and where is default risk concentrated?**

---

## 📖 Project Overview

| | |
|---|---|
| **Dataset** | 38,576 personal loan records, issued throughout 2021 |
| **Fields** | Loan amount, interest rate, grade, term, purpose, borrower income, DTI, home ownership, state, loan status, payment history |
| **Business question** | How healthy is the loan portfolio, and where should risk controls tighten? |
| **Deliverables** | Cleaned dataset · SQL analysis · Python EDA & visualizations · Excel KPI workbook · Power BI interactive dashboard |

The project follows a realistic analyst workflow: clean and validate the raw data, explore it with code, summarize it in a business-friendly workbook, and ship an interactive dashboard stakeholders can filter themselves.

---

## 🛠 Tools & Skills Demonstrated

| Tool | What it was used for |
|---|---|
| **Python** (pandas, matplotlib) | Data cleaning (fixing mixed date formats), feature engineering, exploratory visualizations |
| **SQL** (SQLite) | Analyst-grade queries — KPIs, month-over-month trend with `LAG()`, cumulative totals with window functions, risk segmentation with CTEs |
| **Power BI** | Star-schema data model (DimDate + Loans fact table), custom DAX measures, filters/slicers by month, grade, purpose, term, loan status, income, loan amount, interest rate, US map by state, weekday × month heatmap matrix |

---

## 📂 Repository Structure

```
├── financial_loan.csv              # raw, uncleaned source data
├── bank-loan-analysis.csv          # processed/cleaned dataset with engineered fields
├── Bank-loan-analysis.sql          # SQL analysis queries (KPIs, trends, risk, segmentation)
├── bank_loan_analysis_eda.py       # Python cleaning + EDA + chart generation script
├── bank-loan-dashboard.pbix        # Power BI interactive dashboard
├── dashboard-overview(1).png       # dashboard screenshot — Summary view
├── dashboard-overview(2).png       # dashboard screenshot — Risk breakdown view
└── README.md
```

---

## 🧹 Data Cleaning Summary

- **Mixed date formats**: `financial_loan.csv` mixed `MM/DD/YYYY`-style and `DD-MM-YYYY`-style dates in the same column. Cross-checking values above 12 confirmed both followed a day-month-year convention — parsed consistently across all four date fields in `bank_loan_analysis_eda.py`.
- **Whitespace & missing values**: trimmed stray spaces in `term`; filled missing `emp_title` values rather than leaving nulls.
- **Feature engineering** added for analysis: `loan_category` (Good/Bad Loan), `income_band`, `dti_band`, `repayment_ratio`, and month/weekday breakouts from `issue_date` — output saved as `bank-loan-analysis.csv`.

---

## 🔎 Key Insights

- **Portfolio is fundamentally healthy** — 86.2% of loans are "Good" (Fully Paid or Current); overall default (charge-off) rate is **13.8%**.
- **Loan term is the single strongest risk signal**: 60-month loans default at **22.3%** vs **10.7%** for 36-month loans — more than double.
- **Grade ordering behaves exactly as it should** (a good sanity check on the underlying grading model): default rate climbs from **5.7% at Grade A** to **31.3% at Grade G**.
- **Small business loans are the riskiest purpose** at **25.6%** default — the highest of any category, despite representing only ~4.6% of volume.
- **Higher DTI correlates with higher default risk**: 15.6% default in the "High (20–30%)" DTI band vs 12.0% in the "Low (<10%)" band.
- **Income is protective**: default rate falls steadily from 17.4% (under $30K income) to 10.4% (over $100K income).
- **Volume grew steadily all year**: monthly funded amount rose from $25M in January to $54M in December 2021 — a 116% increase.
- **Geographic concentration**: California alone accounts for ~18% of total funded amount ($78.5M), more than the next two states combined.
- Total funded: **$435.8M** · Total received: **$473.1M** — the portfolio is net cash-positive even after charge-offs, due to interest income.

---

## 💡 Recommendations

1. **Tighten underwriting on 60-month, Grade F/G, small-business loans** — this specific combination is where risk compounds hardest (individually: term +11.6pp risk, grade +25.6pp risk, purpose +11.8pp risk vs. baseline). Consider stricter DTI thresholds or added collateral requirements for this segment specifically, rather than applying blanket rules per single factor.
2. **Re-price interest rate by DTI band, not just grade** — DTI shows a meaningful independent effect on default risk even within the same grade. A secondary risk-based pricing adjustment layered on top of grade could better reflect true risk.
3. **Investigate why small business loans carry outsized risk relative to volume** — since they're a small share of the book but the riskiest purpose category, understand whether this is originator-level underwriting quality, an economic sector effect (e.g. business volatility), or documentation/verification gaps specific to this purpose.
4. **Watch geographic concentration risk** — with California representing such a large share of funded amount, consider whether the portfolio needs deliberate diversification targets across states, so state-level economic shocks don't disproportionately impact the whole book.
5. **Use the growth trend to plan capital allocation** — funded amount nearly doubled over the year; if this trend continues, plan funding/liquidity needs proactively rather than reactively.

---

## 📊 Dashboard Preview

**Overview — KPIs, trends, map, grade & purpose risk**
![Dashboard Overview 1](dashboard-overview(1).png)

**Risk breakdown — term, business insights, seasonality heatmap**
![Dashboard Overview 2](dashboard-overview(2).png)

*(Full interactive version available in `bank-loan-dashboard.pbix` — open in Power BI Desktop to explore filters, slicers, and drill-through live.)*

---

## ▶️ How to Reproduce

1. **Python**: run `python3 bank_loan_analysis_eda.py` — cleans `financial_loan.csv`, engineers features, and outputs `bank-loan-analysis.csv` plus EDA charts
2. **SQL**: load `bank-loan-analysis.csv` into your SQLite/preferred database client and run the queries in `Bank-loan-analysis.sql` — covers KPIs, monthly trend, and risk segmentation
3. **Power BI**: open `bank-loan-dashboard.pbix` in Power BI Desktop (free download from Microsoft) — data model, DAX measures, and all visuals are already built in; use the filters on the left to explore by month, grade, purpose, term, and more

---

## 👤 Author

**Kartik Dogra**
🔗 [LinkedIn](https://linkedin.com/in/kartikdogra)
📧 kartikdogra229720@gamil.com

*Built as an end-to-end portfolio project demonstrating the analytics workflow across SQL, Python, and Power BI. Feel free to connect or reach out with questions about the approach or findings.*
