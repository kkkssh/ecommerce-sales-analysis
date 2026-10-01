# ecommerce-sales-analysis
A SQL project analyzing e-commerce sales and customer behavior using MySQL

## Project Progress

### 1. Data Quality Checks

Performed initial data quality checks on the Online Retail dataset using MySQL.

- Checked the total number of rows, date range, and missing values.
- Identified cancelled transactions and negative quantities.
- Investigated zero and negative unit prices.
- Checked duplicate records across all columns.

**Key findings**
- Total records: 541,909
- Missing customer IDs: 135,080
- Cancelled transactions: 9,288
- Duplicate groups: 4,879
- Extra duplicate rows: 5,268
- All 1,336 negative-quantity rows with invoice numbers not starting with `C` have a unit price of zero.

The two records with negative prices are labelled `Adjust bad debt`.

These checks helped me understand the data and identify issues to look into during cleaning.
