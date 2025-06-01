# LP3-Walmart-Sales-SQL-Analysis

## Project Overview

This project is part of my ongoing learning in data analytics and explores Walmart sales and customer behavior using **PostgreSQL**, **Python**, and **VS Code**. While the project follows a guided tutorial by [Zero Analyst](https://youtu.be/49C3Mkmhskg?si=EwnajZu_FxV-Y3-z), I extended it by:
- Formulating new business questions
- Performing statistical testing (e.g., one-sample t-tests)
- Analyzing operational patterns across stores

Data Source: [Walmart Sales Dataset on GitHub](https://github.com/najirh/Walmart_SQL_Python)

---

## Learning Outcomes

Through this project, I developed and demonstrated the following skills:

- **SQL Proficiency**: Used aggregation, filtering, window functions (`RANK()`), `CASE` logic, and common table expressions (CTEs) to answer complex business questions.
- **Data Cleaning & Transformation**: Managed and analyzed structured sales data using PostgreSQL and Python's Pandas library.
- **Statistical Analysis**: Applied hypothesis testing using Python (`scipy.stats.ttest_1samp`) to evaluate store performance against national benchmarks.
- **Business Insight Generation**: Interpreted data to make actionable recommendations for operations, product strategy, and customer satisfaction.
- **Workflow Integration**: Combined SQL and Python in a cohesive workflow using Jupyter Notebook and VS Code for reproducible analysis.

---

## Key Questions & Insights

### 1. Which payment methods are most used and most profitable?
- **Credit cards** had the highest number of transactions, items sold, and total sales.
- **E-wallets** followed, with **cash** being least used.
> *Recommendation: Focus on optimizing digital payment methods.*

---

### 2. Which product categories perform best, and which need attention?
- Categories like **Electronic Accessories**, **Food & Beverages**, and **Health & Beauty** scored high on customer ratings but had low profits.
- Conversely, **Fashion Accessories** and **Home & Lifestyle** drove over 80% of profit but received low ratings.
>  *Recommendation: Improve customer satisfaction in high-profit but poorly rated categories.*

---

### 3. Which days are busiest and most profitable?
- **Midweek (Tue–Thu)** had the most transactions and highest revenue, with **Saturday** also showing strong sales.
- Top-selling categories vary daily, mostly dominated by **Fashion Accessories** and **Home & Lifestyle**.
> *Recommendation: Adjust staffing and inventory based on day-of-week trends.*

---

### 4. Are any stores significantly above or below the national average in customer ratings?
- Using **Python’s `ttest_1samp`**, I found:
  - 23 stores had significantly **below-average** ratings.
  - 50 stores had significantly **above-average** ratings.
>  *Recommendation: Use these insights for performance reviews and branch improvements.*

---

### 5. Which branches saw the biggest revenue shifts from 2022 to 2023?
- Example Increases:
  - El Paso (+173%)
  - Laredo (+162%)
- Example Decreases:
  - Missouri City (-63%)
  - Flower Mound (-59%)
>  *Recommendation: Investigate declining branches to identify root causes.*

---

## Tools & Skills Demonstrated
- **SQL**: Aggregations, subqueries, window functions, `CASE` statements, CTEs
- **Python (Pandas, SciPy)**: Statistical testing, data grouping, visualization prep
- **VS Code**: Integrated SQL + Python workflow

---

## Repository Structure
- README.md <- Project overview and key findings
- Walmart_Project_Python.ipynb <- Python code for t-tests & analysis
- Walmart_Sales_SQL.sql <- SQL queries for business questions
- Walmart_Uncleaned_Sales_Data <- Original, uncleaned data file
- Walmart Data Analysis Report.pdf <- Written report with tables & appendices

---

## How to Run the Project

### Requirements
- Python 3.8+
- PostgreSQL
- Jupyter Notebook (or VS Code with Jupyter extension)

### Python Setup
Install dependencies:
```bash
pip install pandas scipy
```

### SQL Setup
Import the dataset into PostgreSQL using your preferred GUI (e.g. pgAdmin) or CLI.
Then, run the SQL queries from walmart sales SQL code.sql.

---

## References
- Tutorial: [Zero Analyst - YouTube(https://youtu.be/49C3Mkmhskg?si=EwnajZu_FxV-Y3-z)
- Dataset: [GitHub Dataset Source](https://github.com/najirh/Walmart_SQL_Python)

---

## Author

Tyler Parnell (Tp-oi), Mathematics and Big Data Student.
Feel free to reach out if you have questions about the project.

*This project was completed as part of my ongoing effort to develop my data science skills and build my portfolio.*

---

## License

This project is distributed freely under the MIT license

