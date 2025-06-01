-- Below are the SQL (any python code #4) for the walmart sales project. 

-----------------------------------------------------------------------------------------
-- walmart report question #1: Which payment methods are most used and most profitable?
SELECT payment_method, COUNT(*) as number_of_payments,
SUM(quantity) as number_of_qty_sold,
SUM(total) as total_sales_values
FROM walmart_sales
GROUP BY payment_method;

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- walmart report question #2: Which product categories perform best, and which need attention? 
-- What is the total revenue and profit for each category?

-- times ranked highest 
SELECT category, COUNT(*) AS times_ranked_1
FROM (
    SELECT
        branch, 
        category,
        AVG(rating) AS avg_rating,
        RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank
    FROM walmart_sales
    GROUP BY branch, category
) ranked
WHERE rank = 1
GROUP BY category
ORDER BY times_ranked_1 DESC;

-- times ranked lowest 
SELECT category, COUNT(*) AS times_ranked_lowest
FROM (
    SELECT
        branch,
        category,
        AVG(rating) AS avg_rating,
        RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) ASC) AS rank
    FROM walmart_sales
    GROUP BY branch, category
) ranked
WHERE rank = 1
GROUP BY category
ORDER BY times_ranked_lowest DESC;

-- Total revenue and profit by Category
SELECT 
    category,
    SUM(total) as total_revenue,
	SUM(total*profit_margin) as profit
FROM walmart_sales
GROUP BY category;

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- walmart report question #3: Which days are busiest and most profitable? 
--What product category had the highest number of transactions each day?


-- total sales and number of transactions for each day of the week:
SELECT 
    TRIM(TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'Day')) AS day_name,
    COUNT(*) AS num_transactions,
    SUM(total) AS total_sales
FROM walmart_sales
GROUP BY day_name
ORDER BY total_sales DESC;

-- Top Category by Day of the Week
SELECT day_name, category, num_transactions
FROM (
    SELECT 
        TRIM(TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'Day')) AS day_name,
        category,
        COUNT(*) AS num_transactions,
        RANK() OVER(PARTITION BY TRIM(TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'Day')) 
                    ORDER BY COUNT(*) DESC) AS rank
    FROM walmart_sales
    GROUP BY day_name, category
) ranked
WHERE rank = 1
ORDER BY day_name;


-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- walmart report question #4: Are any stores significantly above or below the national average in customer ratings?
-- PYTHON CODE BELOW:
from scipy.stats import ttest_1samp

# Calculate the national average rating
national_avg = df['rating'].mean()

# Loop through each city and test
results = []
for city, group in df.groupby('city'):
    t_stat, p_value = ttest_1samp(group['rating'], popmean=national_avg)
    results.append({
        'city': city,
        'store_avg': group['rating'].mean(),
        't_stat': t_stat,
        'p_value': p_value
    })

# Convert results to a DataFrame
results_df = pd.DataFrame(results)

# Optional: flag significance
results_df['significant'] = results_df['p_value'] < 0.05


results_df['group'] = results_df.apply(
    lambda row: 'Above Average' if row['significant'] and row['store_avg'] > national_avg 
    else ('Below Average' if row['significant'] and row['store_avg'] < national_avg 
    else 'Not Significant'),
    axis=1
)

# Display the grouped results
above_avg = results_df[results_df['group'] == 'Above Average']
below_avg = results_df[results_df['group'] == 'Below Average']

# Show results
print("National Average Rating:", national_avg)
print("\n--- Stores Significantly Above Average ---")
display(above_avg)

print("\n--- Stores Significantly Below Average ---")
display(below_avg)


-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- walmart report question #5: Which branches saw the biggest revenue shifts from 2022 to 2023?
WITH revenue_2022 AS (
	SELECT 
	    branch, 
	    city,
	    SUM(total) AS revenue
	FROM walmart_sales
	WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2022
	GROUP BY branch, city
),
revenue_2023 AS (
	SELECT 
	    branch, 
	    city,
	    SUM(total) AS revenue
	FROM walmart_sales
	WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2023
	GROUP BY branch, city
)

SELECT 
	last_year.branch,
	last_year.city,
	last_year.revenue AS last_year_revenue,
	this_year.revenue AS current_year_revenue,
	ROUND(
		(this_year.revenue - last_year.revenue)::numeric / last_year.revenue::numeric * 100,
		2
	) AS revenue_change_ratio,
	CASE 
		WHEN this_year.revenue > last_year.revenue THEN 'Increase'
		WHEN this_year.revenue < last_year.revenue THEN 'Decrease'
		ELSE 'No Change'
	END AS change_type
FROM revenue_2022 AS last_year
JOIN revenue_2023 AS this_year
	ON last_year.branch = this_year.branch
ORDER BY revenue_change_ratio DESC;