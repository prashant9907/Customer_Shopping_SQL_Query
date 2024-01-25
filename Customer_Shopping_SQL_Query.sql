
------------------------------------ Customer Shopping Data Analysis ------------------------------------

select * 
from [Portfolio Project]..customer_shopping_data

---------------------------------------------------------------------------------------------------------

-- Date Formatting

--write query to change the date format

select *, CONVERT(Date,date)
from [Portfolio Project]..customer_shopping_data


-- write query to add the new column for updated date

Alter table [Portfolio Project]..customer_shopping_data
add Shopping_date Date;


-- write query to update the new date column

update [Portfolio Project]..customer_shopping_data
set Shopping_date = CONVERT(Date,date)


-- write query to drop of old date column

alter table [Portfolio Project]..customer_shopping_data
drop column date


select * 
from [Portfolio Project]..customer_shopping_data

---------------------------------------------------------------------------------------------------------

-- calculate the sales from quantity and unit price attribute

select *, quantity*price as sales
from [Portfolio Project]..customer_shopping_data


Alter table [Portfolio Project]..customer_shopping_data
add Sales float;


update [Portfolio Project]..customer_shopping_data
set Sales = quantity*price


select *, round(sales,0)
from [Portfolio Project]..customer_shopping_data


select * 
from [Portfolio Project]..customer_shopping_data

---------------------------------------------------------------------------------------------------------

-- age categorization

select
    age,
    case
        when age <= 9 then 'Child'
        when age > 9 and age <= 19 then 'Teen'
        when age > 19 and age <= 24 then 'Young'
        when age > 24 and age <= 59 then 'Adult'
        when age > 59 then 'Old'
    end as age_group
from [Portfolio Project]..customer_shopping_data


Alter table [Portfolio Project]..customer_shopping_data
add age_group nvarchar(255);


update [Portfolio Project]..customer_shopping_data
set age_group = case
					when age <= 9 then 'Child'
					when age > 9 and age <= 19 then 'Teen'
					when age > 19 and age <= 24 then 'Young'
					when age > 24 and age <= 59 then 'Adult'
					when age > 59 then 'Old'
				end as age_group


select *
from [Portfolio Project]..customer_shopping_data


---------------------------------------------------------------------------------------------------------

-- Identify the most popular payment modes

select payment_method, COUNT(payment_method) as Count_of_payment_mode
from [Portfolio Project]..customer_shopping_data
group by payment_method
order by Count_of_payment_mode desc


-- calculate the different category of items contain by the shopping malls

select category, count(category) as range_of_items
from [Portfolio Project]..customer_shopping_data
group by category
order by range_of_items desc


-- Explore sales based on gender

select gender, count(gender) as gender_sales
from [Portfolio Project]..customer_shopping_data
group by gender 
order by gender_sales desc


-- Understand which age groups contribute most to sales

select age_group, COUNT(age_group) as age_group_sales
from [Portfolio Project]..customer_shopping_data
group by age_group
order by age_group_sales desc


select * 
from [Portfolio Project]..customer_shopping_data


---------------------------------------------------------------------------------------------------------

-- Calculate the total sales across all malls

select Round(SUM(Sales),2) as TotalSales
from [Portfolio Project]..customer_shopping_data


-- Understand how sales are distributed across different shopping malls

select Shopping_mall, count(shopping_mall) as total_Sales_per_mall
from [Portfolio Project]..customer_shopping_data
group by shopping_mall
order by total_Sales_per_mall desc


-- Calculate the average sales per customer

select round(AVG(Sales),2) as Average_sale_per_customer
from [Portfolio Project]..customer_shopping_data


-- Analyze sales trends over time, e.g. yearly

select FORMAT(shopping_date, 'yyyy') as yearly, round(SUM(sales),2) as yearly_sales
from [Portfolio Project]..customer_shopping_data
group by FORMAT(shopping_date, 'yyyy')
order by yearly


-- Analyze sales trends over time, e.g. monthly

select MONTH(shopping_date) as monthly, ROUND(SUM(sales), 2) as monthly_sales
from [Portfolio Project]..customer_shopping_data
group by MONTH(shopping_date)
order by monthly


-- Check if sales vary significantly between weekdays and weekends

select DATENAME(dw, shopping_date) as day_of_week, ROUND(SUM(sales), 2) as daily_sales
from [Portfolio Project]..customer_shopping_data
group by DATENAME(dw, shopping_date)
order by daily_sales desc


-- Combine age group and gender for a more detailed analysis

SELECT age_group, gender, round(SUM(sales),2) AS age_gender_sales
FROM [Portfolio Project]..customer_shopping_data
GROUP BY age_group, gender
order by age_gender_sales desc


--Calculate the month-over-month sales growth

select FORMAT(shopping_date, 'yyyy-MM') as month, 
       round(SUM(sales),2) as monthly_sales,
       LAG(round(SUM(sales),2)) over (order by FORMAT(shopping_date, 'yyyy-MM')) as prev_month_sales
from [Portfolio Project]..customer_shopping_data
group by FORMAT(shopping_date, 'yyyy-MM')
order by month 


---------------------------------------------------------------------------------------------------------

select * 
from [Portfolio Project]..customer_shopping_data