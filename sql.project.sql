-- RETAIL SALES ANALYSIS SQL PORTFOLIO PROJECT
-- Database: retail_sales_db
-- Table: orders 

-- Activating the database 
use retail_sales_db;

-- Checking c_name,data_types 
describe orders;

-- Task 1: Preview Important columns from dataset
select `order ID`,`order Date`,City,Category,
        Quantity,`Unit Price (INR)`
from orders
limit 10;

-- Task 2: Display the count of total no. of records
select count(*) as total_orders
from orders;

-- Task 3: Show Distinct customer id from dataset
select count(distinct `Customer ID`) as total_customers 
from orders;

-- Task 4: Display Quantity by category-wise
select category,sum(Quantity) as total_quantity_sold
from orders
group by category;

-- Task 5: Display total orders placed by category-wise
select category,count(*) as total_orders_placed
from orders
group by category;

-- Task 6:Display revenue by category wise
select Category,sum(Quantity*`Unit Price (INR)`) as Revenue
from orders
group by Category 
order by Revenue desc;

-- Task 7: Display revenue by month and year-wise
select year(`Order Date`) as year_revenue,
       month(`Order Date`) as month_no,
       sum(Quantity*`Unit Price (INR)`) as Revenue
from orders
group by year_revenue,month_no
order by year_revenue,month_no;

-- Task 8: display highest revenue in year and month-wise
select year(`Order Date`) as year_revenue,
       month(`Order Date`) as month_no,
	   sum(Quantity*`Unit Price (INR)`) as Revenue
from orders
group by year_revenue,month_no
order by revenue desc
limit 1;

-- Task 9: Display discount amount by category-wise
select category,
       sum((`Unit Price (INR)`*`Discount Rate`)*Quantity) as Discount_amount
from orders
group by category
order by discount_amount desc;

-- Task 10: Display net revenue by category-wise
select category,
       sum(Quantity*`Unit Price (INR)`)-sum((`Unit Price (INR)`*`Discount Rate`)*Quantity) as net_revenue
from orders
group by category
order by net_revenue desc;

-- Task 11: Display orders placed above 20000
select `Order ID`, City,(Quantity*`Unit Price (INR)`) as order_value
from orders
where (Quantity*`Unit Price (INR)`)>20000
order by order_value desc;

-- Task 12: Display revenue by city-wise
select city, sum(Quantity*`Unit Price (INR)`) as total_revenue 
from orders
group by city 
order by total_revenue desc;

-- Task 13: Display order status count
select `Order Status`,count(`Order Status`) as order_status_total
from orders
group by `Order Status`
order by order_status_total desc;

-- Task 14: City-Wise completed order analysis
select city,sum(Quantity*`Unit Price (INR)`) as Revenue
from orders
where `Order Status`='Completed'
group by city
order by Revenue desc;

-- Task 15: City-wise average order analysis
select city,
       round(avg(Quantity*`Unit Price (INR)`),2)as average_order_value
from orders
group by city
order by average_order_value desc;

-- Task 16: Category-Wise Completed order analysis
select category, count(`Order Status`) as order_count
from orders
where `Order Status`='Completed'
group by category
order by order_count desc;

-- Task 17: Category-Wise Returned Order count
select category, count(`Order Status`) as order_count
from orders
where `Order Status`='Returned' 
group by category
order by order_count desc;

-- Task 18: category-wise returned order analysis
select category,count(`Order ID`) as total_order,
       sum(case when `Order Status`='Returned' Then 1 else 0 end ) as returned_records,
       (sum(case when `Order Status`='Returned' Then 1 else 0 end ) / count(`Order ID`) *100) as returned_order_perc
 from orders
 group by category 
 order by returned_order_perc desc;
 
 -- Task 19: City-wise cancelled order count
 select city, count(`Order Status`) as order_count
 from orders
 where `Order Status`='cancelled'
 group by city
 order by order_count desc;
 
 -- Task 20: City-wise cancelled order status analysis
select city, count(`Order ID`) as order_count,
        sum(case when `Order Status`='Cancelled' then 1 else 0 end) as cancelled_count,
		(sum(case when `Order Status`='Cancelled' then 1 else 0 end)/count(`Order ID`)*100) as cancelled_rate
from orders
group by city
order by cancelled_rate desc
limit 5;

-- Task 21: Sales-Channel gross-revenue analysis
select `Sales Channel`,count(`order ID`) as total_order,sum(quantity),
        sum(Quantity*`Unit Price (INR)`) as gross_revenue 
from orders
group by `Sales Channel`
order by gross_revenue desc;

-- Task 22: Sales-Channel net-revenue analysis
select `Sales Channel`,
	   sum(Quantity*`Unit Price (INR)`)-sum((`Unit Price (INR)`*`Discount Rate`)*Quantity) as net_revenue
from orders
group by `Sales Channel`
order by net_revenue desc;

-- Task 23: Sales Channel Revenue Contribution Percentage
select `Sales Channel`,
        sum(Quantity*`Unit Price (INR)`) as channel_gross_revenue,
        (
            sum(Quantity*`Unit Price (INR)`)/
            (select sum(Quantity*`Unit Price (INR)`)
		     from orders)
		) *100 as revenue_contribution_pct
from orders
group by `Sales Channel`
order by revenue_contribution_pct desc;

-- Task 24: Quantity Sold by Sales Channel
select `Sales Channel`,
		sum(Quantity) as quantity_sold
from orders
group by `Sales Channel`
order by quantity_sold;

-- Task 25: Quantity Sold by Sales Channel
select `Sales Channel`,
		sum(Quantity) as total_quantity,
        ( 
           select sum(Quantity) as total_quantity 
           from orders
		) as total_quantity_sold
from orders
group by `Sales Channel`
order by total_quantity;

-- Task 26: Average order value
select avg(Quantity*`Unit Price (INR)`)
from orders;

-- Task 27: Top 5 Orders Above Average Value
select `Order ID`,City,
	    (Quantity*`Unit Price (INR)`) as Order_value
from orders
where (Quantity*`Unit Price (INR)`)>
        (
			select avg(Quantity*`Unit Price (INR)`) 
            from orders
		) 
order by Order_value desc
limit 5;

-- Task 28: Calculate Total Quantity Sold
select (
			select sum(Quantity) 
            from orders
		) as total_Quantity_sold;

-- Task 29: Count Total Orders
select (
			select count(`Order ID`)
            from orders
		) as total_orders;

-- Task 30: Calculate Average Quantity
select (
			select avg(Quantity)
            from orders
		) as average_quantity;

-- Task 31: Orders with Above-Average Quantity
select `Order ID`,Quantity
from orders
where Quantity >
		(
			select avg(Quantity) 
            from orders
		);
-- Task 32: Orders with Below-Average Quantity
select `Order ID`,Quantity
from orders
where Quantity <
		(
			select avg(Quantity) 
            from orders
		);

-- Task 33: Find Maximum Quantity Orders
select `Order ID`,Quantity
from orders
where Quantity=
		( 	
			select max(Quantity)
            from orders
		);
	
-- Task 34: Find Minimum Quantity Orders
select `Order ID`,Quantity
from orders
where Quantity=
		( 	
			select min(Quantity)
            from orders
		);
-- Task 35: Count Above-Average Orders
select count(*) as order_above_average
from orders
where Quantity>
		(
			select avg(Quantity) 
            from orders
		);
-- Task 36: Find Above-Average Order Values    
select `Order ID`,(Quantity*`Unit Price (INR)`) as order_value
from orders
where (Quantity*`Unit Price (INR)`) >
		(
			select avg((Quantity*`Unit Price (INR)`))
            from orders
		);

-- Task 37: Find Below-Average Order Values
select `Order ID`,(Quantity*`Unit Price (INR)`) as order_value
from orders
where (Quantity*`Unit Price (INR)`) <
		(
			select avg((Quantity*`Unit Price (INR)`))
            from orders
		);

-- Task 38: Order Value Analysis
select `Order ID`,(Quantity*`Unit Price (INR)`) as Order_value
from orders
where (Quantity*`Unit Price (INR)`)=
	(
		select max(Quantity*`Unit Price (INR)`)
        from orders
	);
-- Task 39: Order Value Analysis
select `Order ID`,(Quantity*`Unit Price (INR)`) as Order_value
from orders
where (Quantity*`Unit Price (INR)`)=
	(
		select min(Quantity*`Unit Price (INR)`)
        from orders
	);

-- Task 40: Top 5 Orders Above Average Value
select `Order ID`,(Quantity*`Unit Price (INR)`) as Order_value
from orders
where (Quantity*`Unit Price (INR)`)>
	(
		select avg((Quantity*`Unit Price (INR)`) )
        from orders
	)
order by Order_value desc
limit 5;

-- Task 41: Count Above-Average Orders by City
select city,count(Quantity*`Unit Price (INR)`) as order_above_average
from orders
where (Quantity*`Unit Price (INR)`) >
	(	
		select avg((Quantity*`Unit Price (INR)`) )
        from orders
	)
group by city;

-- Task 42: Count Below-Average Orders by City
select city,count(Quantity*`Unit Price (INR)`) as order_below_average
from orders
where (Quantity*`Unit Price (INR)`) <
	(	
		select avg((Quantity*`Unit Price (INR)`) )
        from orders
	)
group by city;

-- Task 43: Above Quantity average analysis
select `Order ID`,City,Quantity
from orders
where `Order ID` in 
	(
		select `Order ID`
        from orders
        where Quantity>
        (
			select avg(Quantity)
            from orders
		)
	);

-- Task 44: Below Quantity average analysis
select `Order ID`,City,Quantity
from orders
where `Order ID` in 
	(
		select `Order ID`
        from orders
        where Quantity<
        (
			select avg(Quantity)
            from orders
		)
	);

-- Task 45: Above Average order value analysis
select `Order ID`,City,(Quantity*`Unit Price (INR)`) as above_average_order_value
from orders
where (Quantity*`Unit Price (INR)`)>
	(
		select avg((Quantity*`Unit Price (INR)`))
        from orders
	)
order by above_average_order_value desc
limit 5;

-- Task 46: Below average order value analysis
select `Order ID`,City,(Quantity*`Unit Price (INR)`) as order_value
from orders
where (Quantity*`Unit Price (INR)`)<
	(
		select avg((Quantity*`Unit Price (INR)`))
        from orders
	)
order by order_value asc, `Order ID` asc 
limit  5;

-- Task 47: Above Average Orders Count
select count(*) as above_average_orders
from orders
where (Quantity*`Unit Price (INR)`)>
	(
		select avg((Quantity*`Unit Price (INR)`))
        from orders
	);

-- Task 48: Below Average Orders Count 
select count(*) as below_average_orders
from orders
where (Quantity*`Unit Price (INR)`)<
	(
		select avg((Quantity*`Unit Price (INR)`))
        from orders
	);

-- Task 49: Average Order Value by city 
select City,round(avg(Quantity*`Unit Price (INR)`),2) as average_order_value
from orders
group by city
order by average_order_value desc;

-- Task 50: Count Orders by City
select City,count(*) as total_orders
from orders
group by City
order by total_orders desc;

-- Task 51: Total customers count
select count(`Customer ID`) as total_customers
from orders;

-- Task 52: Order Count by Customer
select `Customer ID`,count(*) as total_orders
from orders
group by `Customer ID`
order by total_orders desc 
limit 10;

-- Task 53: Top Customers by Total Spending
select `Customer ID`,sum(Quantity*`Unit Price (INR)`) as total_spending
from orders
group by `Customer ID`
order by total_spending desc
limit 10;

-- Task 54: Order Value Analysis
select `Customer ID`,round(avg(Quantity*`Unit Price (INR)`),2) as average_order_value
from orders
group by `Customer ID`
order by average_order_value desc
limit 10;

-- Task 55: Order Count by Customer who has more than 3 orders
select `Customer ID`,count(*) as total_orders
from orders
group by `Customer ID`
having total_orders>3
order by total_orders desc;

-- Task 56: Order count by customer 
select count(*) as repeated_customers
from (
		select `Customer ID`
        from orders
        group by `Customer ID`
        having count(*)>3
	  ) as customer_summary;

-- Task 57:	Classify Customers by Spending
select `Customer ID`,
	   sum(Quantity*`Unit Price (INR)`) as total_spending,
         case when sum(Quantity*`Unit Price (INR)`) >200000 
              then "High Spender"
         when sum(Quantity*`Unit Price (INR)`) >=100000
              then "Medium Spender"
		 else "Low Spender" end as spending_category
from orders
group by `Customer ID`
order by total_spending desc;

-- Task 58: Count Customers by Spending Category
select spending_category,COUNT(*) AS total_customers
from (
    select `Customer ID`,
	case when sum(Quantity * `Unit Price (INR)`) > 200000
		then 'High Spender'
	when sum(Quantity * `Unit Price (INR)`) >= 100000
		then 'Medium Spender'
	else 'Low Spender' end as spending_category
    from orders
    group by `Customer ID`
) as customer_summary
group by spending_category
order by total_customers desc;

-- Task 59: Rank Orders within Each Customer
select `Customer ID`,`Order ID`,
        Quantity * `Unit Price (INR)` as order_value,
        row_number() over (partition by `Customer ID`
        order by Quantity * `Unit Price (INR)` desc) as order_rank
from orders;

-- Task 60: CTE: Total Quantity for Chennai
with chennai_orders as (
    select City, Quantity
    from orders
    where City = 'Chennai')
select City, sum(Quantity) as total_quantity
from chennai_orders
group by City;

-- Task 61: Top Customers by Sales
with customer_sales as (
    select `Customer ID`,
	Quantity * `Unit Price (INR)` as order_value
    from orders)

select `Customer ID`,sum(order_value) as total_sales
from customer_sales
group by `Customer ID`
order by total_sales desc
limit 10;

-- Task 62: Rank Orders within Each Customer
with customer_order_ranking as (
  select  
    `Customer ID`,
    `Order ID`,
    Quantity * `Unit Price (INR)` AS order_value,
     row_number() over (
        partition by `Customer ID`
        order by Quantity * `Unit Price (INR)` desc
    ) as order_rank
from orders
)
select * from customer_order_ranking
where order_rank=1;

-- Task 63: Count of Rank Orders within Each Customer
with customer_order_ranking as (
    select
        `Customer ID`,
        `Order ID`,
        Quantity * `Unit Price (INR)` as order_value,
        row_number() over (
            partition by `Customer ID`
            order by Quantity * `Unit Price (INR)` desc
        ) as order_rank
    from orders
)
select count(*) as total_customers
from customer_order_ranking
where order_rank = 1;

-- Task 64: Order Value Analysis by region 
select
    Region,
    count(*) as total_orders,
    sum(Quantity) as total_quantity,
    sum(Quantity * `Unit Price (INR)`) as total_sales,
    round(avg(Quantity * `Unit Price (INR)`), 2) as average_order_value
from orders
group by  Region
order by total_sales desc;

-- Task 65: Order Value Analysis by sales channel
select
    `Sales Channel`,
    count(*) as total_orders,
    sum(Quantity) as total_quantity,
    sum(Quantity * `Unit Price (INR)`) as total_sales,
    round(avg(Quantity * `Unit Price (INR)`), 2) as average_order_value
from orders
group by `Sales Channel`
order by total_sales desc;

-- Task 66: Quantity Sold by Category
select Category,
    count(*) as total_orders,
    sum(Quantity) as total_quantity,
    sum(Quantity * `Unit Price (INR)`) as total_sales,
    round(avg(Quantity * `Unit Price (INR)`),2) as average_order_value
from orders
group by Category
order by total_sales desc;

-- Task 67: Category-wise sales analysis with rollup
select Category, count(*) as total_rows,
    sum(Quantity * `Unit Price (INR)`) as total_sales
from orders
group by Category with rollup;

-- Task 68: Category-wise total sales 
select Category, sum(Quantity * `Unit Price (INR)`) as total_sales
from orders
group by Category
order by Category;

-- Task 69: Total Sales analysis 
select
    sum(Quantity * `Unit Price (INR)`) as total_sales,
    sum(case when Category is null then Quantity * `Unit Price (INR)`
		else 0 end) as null_category_sales,
    count(*) as total_rows
from orders;

-- Task 70:  Category Sales Summary with ROLLUP
select
    Category,
    sum(Quantity * `Unit Price (INR)`) as total_sales,
    sum(Quantity) as total_quantity,
    count(*) as total_rows
from orders
group by Category with rollup;

-- Task 71: Sub-Category wise Sales
select `Sub-Category`,
    count(*) as total_orders,
    sum(Quantity * `Unit Price (INR)`) as total_sales
from orders
group by `Sub-Category`
order by total_sales desc;

-- Task 72: Lowest Sales Sub-category
select `Sub-Category`,
    sum(Quantity * `Unit Price (INR)`) as total_sales
from orders
group by `Sub-Category`
order by total_sales asc
limit 1;

-- Task 73: Sub-Category sales analysis
select `Sub-Category`,sum(Quantity) as total_quantity,
        sum(Quantity * `Unit Price (INR)`) as total_sales
from orders
group by `Sub-Category`
order by total_sales desc;

-- Task 74: Order Status Analysis
select`Order Status`, count(*) as total_orders,
       sum(Quantity) as total_quantity,
       sum(Quantity * `Unit Price (INR)`) as recorded_order_value
from orders
group by `Order Status`
order by total_orders desc;

-- Task 75: Completed Orders Analysis
select `Order Status`,count(*) as completed_orders,
       sum(Quantity*`Unit Price (INR)`) as completed_Sales,
       sum(Quantity) as completed_quantity,
       round(avg(Quantity*`Unit Price (INR)`),2) as average_completed_sales
from orders
where `Order Status`='Completed';

-- Task 76: Returned and cancelled orders analysis
select `Order Status`,count(*) as total_records,
       round(sum(Quantity*`Unit Price (INR)`),2) as recorded_order_value,
       sum(Quantity) as total_quantity
from orders
where `Order Status` in ('Returned','Cancelled')
group by `Order Status`
order by recorded_order_value desc;

-- Task 77: Monthly completed sales trend
select date_format(`Order Date`, '%Y-%m') as sales_month,
       count(*) as completed_orders,
       round(sum(Quantity * `Unit Price (INR)`),2) as total_sales
from orders
where `Order Status` = 'Completed'
group by date_format(`Order Date`, '%Y-%m')
order by sales_month;

-- Task 78: Top 5 months by completed sales
select 
    date_format(`Order Date`, '%Y-%m') as sales_month,
    count(*) as completed_orders,
    sum(Quantity * `Unit Price (INR)`) as total_sales,
    round(avg(Quantity * `Unit Price (INR)`),2) as average_order_value
from orders
where `Order Status` = 'Completed'
group by date_format(`Order Date`, '%Y-%m')
order by total_sales desc
limit 5;

-- Task 79: Top 10 Products by completed sales
select
    Product,sum(Quantity) as total_quantity_sold,
    count(*) as total_orders,
    sum(Quantity * `Unit Price (INR)`) as total_sales
from orders
where `Order Status` = 'Completed'
group by Product
order by total_sales desc
limit 10;

-- Task 80: Customer Segment Analysis for completed orders
select
    `Customer Segment`,
    count(*) as total_orders,
    sum(Quantity) as total_quantity,
    sum(Quantity * `Unit Price (INR)`) as total_sales,
    round(avg(Quantity * `Unit Price (INR)`),2) as average_order_value
from orders
where `Order Status` = 'Completed'
group by `Customer Segment`
order by total_sales desc;

-- Task 81: Discount category analysis for completed orders
select
    case
        when `Discount Rate` = 0 then 'No Discount'
        when `Discount Rate` <= 0.10 then 'Low Discount'
        else 'High Discount'
    end as discount_category,
    count(*) as total_orders,
    sum(Quantity * `Unit Price (INR)`) as total_sales,
    round(avg(Quantity * `Unit Price (INR)`),2) as average_order_value
from orders
where `Order Status` = 'Completed'
group by discount_category
order by total_sales desc;

-- Task 82: Estimated gross profit analysis for completed orders
select
    sum(Quantity * `Unit Price (INR)`) as total_sales,
    sum(Quantity * `Unit Cost (INR)`) as total_product_cost,
    sum(Quantity * (`Unit Price (INR)` - `Unit Cost (INR)`)) as estimated_gross_profit,
    round(sum(Quantity * (`Unit Price (INR)` - `Unit Cost (INR)`)) * 100.0 /
          sum(Quantity * `Unit Price (INR)`),2) as gross_margin_percent
from orders
where `Order Status` = 'Completed';

-- Task 83: Category-wise estimated gross profit and margin 
select Category,
       sum(Quantity * `Unit Price (INR)`) as total_sales,
       sum(Quantity * `Unit Cost (INR)`) as total_product_cost,
       sum(Quantity * (`Unit Price (INR)` - `Unit Cost (INR)`)) as estimated_gross_profit,
       round(sum(Quantity * (`Unit Price (INR)` - `Unit Cost (INR)`)) * 100.0 /
            sum(Quantity * `Unit Price (INR)`),2) as gross_margin_percent
from orders
where `Order Status` = 'Completed'
group by Category
order by estimated_gross_profit desc;

-- Task 84: Final Completed-sales Performance summary 
select 
    count(*) as completed_orders,
	round(sum(Quantity * `Unit Price (INR)`),2) as total_sales,
    sum(Quantity) as total_quantity,
    round(sum(Quantity *(`Unit Price (INR)` - `Unit Cost (INR)`)),2) AS estimated_gross_profit,
    round(sum(Quantity *(`Unit Price (INR)` - `Unit Cost (INR)`)) * 100.0 /SUM(Quantity * `Unit Price (INR)`),2) AS gross_margin_percent
from orders
where `Order Status` = 'Completed';

