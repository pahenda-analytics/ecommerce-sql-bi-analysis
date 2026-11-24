# Ecommerce SQL BI Analysis

![Dashboard Overview](images/dashboard-overview.png)

## Overview

This project demonstrates an end-to-end Business Intelligence workflow using **PostgreSQL**, **SQL** and **Power BI** to analyse 743,486 transaction records from a synthetic e-commerce dataset.

After importing the dataset into PostgreSQL, I created a reusable analytical view to standardise data types and prepare the data for reporting. I then developed SQL queries to investigate sales performance, customer purchasing behaviour, product performance, marketing effectiveness, discounts and credit-note activity.

The resulting reporting layer was connected to Power BI to support interactive business reporting.

The project demonstrates practical SQL skills used by Data Analysts and Business Intelligence Analysts, including database design, analytical views, aggregations, Common Table Expressions (CTEs), window functions and data-quality validation.

---

## Business Problem

Retail businesses generate large volumes of transactional data, but raw operational datasets are rarely structured for effective reporting.

The objective of this project was to build a reusable SQL reporting layer capable of answering key business questions:

- How much revenue and profit is the business generating?
- Which customers and products generate the highest value?
- Which marketing channels perform best?
- How do sales change month-to-month?
- What is the financial impact of credit notes and bad-debt adjustments?
- How do discounted and non-discounted transactions compare?

The resulting SQL model provides a foundation for Power BI reporting and business performance analysis.

---

## Dataset

**Synthetic E-Commerce Sales Dataset**

The dataset contains:

- **743,486 transaction records**
- **32,755 sales invoices**
- **6,220 credit-note invoices**
- **5,027 identified customers**
- Multiple countries
- Customer demographic and segment fields
- Product categories and subcategories
- Marketing channels
- Credit-note transactions
- Churn indicators

Transactions without customer IDs were retained to preserve complete financial reporting. Customer-level analyses exclude unidentified customers where appropriate.

---

## Data Preparation

The reporting layer was developed in PostgreSQL using a reusable analytical view.

### SQL Reporting View

![SQL Reporting View](images/sql-reporting-view.png)

Key preparation steps included:

- Importing the source CSV into PostgreSQL.
- Creating the `sales_data` table.
- Building the reusable `v_clean_ecommerce_data` view.
- Casting text fields into appropriate numeric and timestamp data types.
- Excluding records without invoice identifiers.
- Preserving anonymous transactions with NULL customer IDs.
- Establishing a consistent reporting layer for downstream analysis.

---

## SQL Analysis

The project contains 12 SQL scripts covering the following analytical areas.

### Sales Overview

- Gross sales revenue and profit.
- Sales invoice counts.
- Average order value calculated at invoice level.
- Net financial impact of credit notes and bad-debt adjustments.

### Monthly Sales Performance

- Monthly revenue and profit.
- Month-on-month revenue growth.
- Previous-month comparisons using `LAG()`.
- Monthly sales invoice volumes.

### Customer Analysis

- Top customers by gross sales revenue.
- Customer revenue rankings.
- Window functions using `RANK()`.

### Product Analysis

- Revenue and profit by category.
- Revenue and profit by subcategory.
- Top products by revenue.
- Top products by profit.
- Product revenue rankings.

Product rankings are based on transaction descriptions and may include service or postage entries as well as physical products.

### Country Analysis

- Revenue and profit by country.
- Identified customer counts by country.
- Geographic sales distribution.

### Marketing Analysis

- Revenue and profit by marketing channel.
- Identified customer counts.
- Marketing channel profitability rankings.
- Investigation of transactions without an assigned marketing channel.

### Discount Analysis

- Discounted versus non-discounted transaction comparisons.
- Average revenue and profit per transaction row.
- Total revenue and profit by discount status.

These comparisons are observational and do not establish that discounts caused differences in profitability.

### Churn Data Quality Analysis

- Distribution of churn flags across transactions.
- Customer-level consistency checks.
- Investigation of conflicting churn indicators.

The churn field was retained for data-quality investigation rather than used to publish an unreliable customer churn rate.

### Returns and Credit-Note Analysis

- Credit-note invoice counts.
- Credit-note transaction volumes.
- Credit-note value and profit impact.
- Credit-note activity by product category.

Credit notes are used as a proxy for return activity. They should not automatically be interpreted as individual physical product returns.

### Intermediate SQL

The project also demonstrates intermediate SQL techniques commonly used in Business Intelligence:

![Month-on-Month Growth Query](images/sql-month-over-month-growth.png)

- Common Table Expressions (CTEs).
- Window Functions.
- `LAG()`.
- `ROW_NUMBER()`.
- `RANK()`.
- `DENSE_RANK()`.
- Running totals.
- Month-on-month growth analysis.

---

## Power BI Dashboard

| Executive Dashboard | Customer Analysis |
|---|---|
| ![](images/dashboard-overview.png) | ![](images/dashboard-customers.png) |

| Product Analysis | Marketing & Returns |
|---|---|
| ![](images/dashboard-products.png) | ![](images/dashboard-marketing-returns.png) |

The Power BI dashboard connects to the PostgreSQL reporting view and provides visual reporting across:

- Executive performance indicators.
- Revenue and profit trends.
- Customer purchasing analysis.
- Product performance.
- Country analysis.
- Marketing performance.
- Returns and credit-note activity.
- Interactive filtering.

Customer demographic, segment and churn fields were investigated separately and excluded from validated customer-level conclusions because of inconsistencies in the source data.

---

## Results

The analysis produced the following reconciled financial KPIs.

| KPI | Value |
|---|---:|
| Gross Sales Revenue | **£14,531,923.10** |
| Gross Sales Profit | **£5,837,332.13** |
| Net Revenue | **£13,405,009.26** |
| Net Profit | **£5,391,514.65** |
| Sales Invoices | **32,755** |
| Average Order Value | **£443.66** |
| Credit-Note Invoices | **6,220** |
| Credit-Note Value | **-£990,361.82** |
| Identified Customers | **5,027** |

Net revenue and net profit account for both credit-note activity and bad-debt adjustments.

### Key Findings

- Gross sales revenue exceeded **£14.5 million**, with net revenue of approximately **£13.4 million** after credit notes and bad-debt adjustments.
- Net profit was approximately **£5.39 million**.
- The average sales invoice value was **£443.66**, calculated using invoice-level revenue rather than transaction-row averages.
- The UK accounted for approximately 85.5% of gross sales revenue.
- Referral was the highest-performing named marketing channel by gross revenue and profit, although the four named channels produced relatively similar results.
- Transactions without an assigned marketing channel represented approximately £2.22 million in gross sales revenue.
- December 2010 was the highest-revenue full month in the reporting period.
- Kitchen had the largest credit-note value among the six product categories.

### Data Quality Findings

An important part of the project was identifying limitations in the source dataset rather than treating every field as reliable.

**Missing customer identifiers**

- 169,916 transaction rows (approximately 22.8%) have no customer ID.
- These transactions were retained for financial reporting but excluded from identified customer-level analysis.

**Inconsistent customer attributes**

Customer demographics and segments were not consistent across transactions:

- 4,854 customers had multiple segment assignments.
- 4,824 customers had multiple gender assignments.
- 4,885 customers had multiple age values.

These fields were therefore excluded from customer-level performance conclusions.

**Inconsistent churn indicators**

- 4,816 of 5,027 identified customers (95.8%) had conflicting churn flags across their transactions.
- Consequently, a reliable customer churn rate could not be established.

**Credit notes and bad debt**

- Credit notes generated a net negative revenue impact of £990,361.82.
- Three bad-debt adjustment records generated a further negative revenue impact of £136,552.02.
- These adjustments were separated from gross sales reporting to avoid inflating sales invoice counts or misrepresenting sales performance.

These findings demonstrate the importance of validating source data and defining financial metrics consistently before building business reports.

---

## Technologies

### Languages
- SQL

### Database
- PostgreSQL

### Business Intelligence
- Power BI Desktop

### Development Tools
- pgAdmin 4
- Visual Studio Code
- Git
- GitHub

---

## Repository Structure

```text
ecommerce-sql-bi-analysis/
│
├── data/
│   └── .gitkeep.txt
│
├── images/
│   ├── dashboard-overview.png
│   ├── dashboard-customers.png
│   ├── dashboard-products.png
│   ├── dashboard-marketing-returns.png
│   ├── sql-reporting-view.png
│   ├── sql-sales-overview-query.png
│   ├── sql-month-over-month-growth.png
│   └── sql-window-functions.png
│
├── powerbi/
│   └── Ecommerce_Dashboard.pbix
│
├── sql/
│   ├── 01_init_sales_schema.sql
│   ├── 02_transform_sales_view.sql
│   ├── 03_analytics_mom_metrics.sql
│   ├── 04_sales_overview.sql
│   ├── 05_customer_analysis.sql
│   ├── 06_product_analysis.sql
│   ├── 07_country_analysis.sql
│   ├── 08_marketing_analysis.sql
│   ├── 09_discount_analysis.sql
│   ├── 10_churn_analysis.sql
│   ├── 11_intermediate_analysis.sql
│   └── 12_returns_analysis.sql
│
├── .gitignore
├── LICENSE
└── README.md
```

Source datasets are excluded from version control.

---

## Related Project

**Python Monthly Reporting Pipeline**

A complementary project using Python to automate data ingestion, cleaning, KPI generation and monthly reporting through a reusable ETL pipeline.

Repository: https://github.com/pahenda-analytics/python-monthly-reporting-pipeline

---

## Author

**Data Analytics & Business Intelligence Portfolio**

GitHub: https://github.com/pahenda-analytics