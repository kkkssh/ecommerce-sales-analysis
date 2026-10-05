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
- Zero-price rows: 2,519
- Negative-price rows: 2
- All 1,336 negative-quantity rows with invoice numbers not starting with `C` have a unit price of zero.
- The two records with negative prices are labelled `Adjust bad debt`.

These checks helped identify the main data quality issues before cleaning.


### 2. Data Cleaning

Created a separate clean table and applied the following cleaning decisions:

- **Missing Customer IDs:** Kept because these records can still be used for sales analysis.
- **Cancelled Transactions:** Removed from regular sales analysis.
- **Negative Quantities:** The remaining non-cancelled negative-quantity rows were kept 
                           because they have a unit price of zero and contribute zero revenue.
- **Zero-price Rows:** Kept because they contribute zero sales revenue.
- **Negative-price Rows:** Removed because both records were labelled `Adjust bad debt`.
- **Duplicate Records:** Removed exact duplicate rows using `DISTINCT`.

**Row count after cleaning**
- Original rows: 541,909
- After removing cancelled transactions: 532,621
- After removing negative-price rows: 532,619
- After removing duplicate rows: 527,388

The final table used for analysis is `online_retail_deduplicated`.


### 3. Sales Analysis

Analyzed sales using monthly sales trend, sales by country, top products, and customer purchasing behavior.

#### Monthly Sales Trend

Analyzed monthly sales using Revenue, Sales Quantity, Number of Orders, and Average Order Value (AOV).

**Key findings**
- Highest Revenue: November 2011 - £1,503,866.78
- Lowest Revenue: February 2011 - £522,545.56
- Highest Sales Quantity: November 2011 - 749,777
- Lowest Sales Quantity: February 2011 - 280,239
- Highest Number of Orders: November 2011 - 3,021
- Lowest Number of Orders: December 2011 - 869
- Highest AOV: December 2011 - £733.94
- Lowest AOV: April 2011 - £357.03
- November 2011 AOV: £497.80

November 2011 had the highest Revenue, Sales Quantity, and Number of Orders.

The AOV in November was £497.80, which was not the highest.

December 2011 is a partial month, so it should be interpreted with caution when comparing monthly results.