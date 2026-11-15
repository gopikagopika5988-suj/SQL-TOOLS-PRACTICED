use shopeasy_db;
select * from products;
select * from orders;
-- 1. Marketing wants to know which cities our orders come from and which payment methods customers use. Give me each as a separate list.
select distinct city from orders;
select distinct payment_mode from orders ;
-- 2. The catalogue team needs a clean product list showing the product name, category and price, with proper headings.
select product_name as 'product name',category as 'category',price as 'price' from products;
-- 3. Finance is auditing the April to June 2026 quarter. Show me all delivered orders from Kochi or Chennai placed in that period.
select * from orders where order_status='delivered' and city in ('kochi','chennai')and order_date between '2026-04-01' and '2026-06-30';
-- 4. The payments team is reviewing card and net banking activity. Show me the orders paid by credit card or net banking where more than 2 units were bought and the order was not cancelled.
select * from orders where (payment_mode='credit card' or payment_mode='net banking') and quantity>2 and order_status<>'cancelled';
-- 5. Which products are priced between ₹1,000 and ₹5,000 and are not in the Electronics category?
select product_name,price,category from products where category<>'Electronics' and price between 1000 and 5000 ;
-- 6. The website search team is testing premium-sounding product names. Which products have "Pro" or "Max" in their name?
select product_name from products where product_name like '%Pro%' or '%max%';
-- 7. Marketing wants to send a message to customers whose names start with "S". Give me each such customer once.
select distinct customer_name from orders where customer_name like 'S%';
-- 8. Show me all cancelled or returned orders where we gave no discount.
select * from orders where order_status in ( 'cancelled','returned') and discount_percent is null;
-- 9. Which products launched in 2026 have not received a customer rating yet?
select * from products where launch_date >'2026-01-01' and rating is null;
-- 10. Who are our 5 most expensive products, and what do they cost?
select product_name,price from products order by price desc limit 5;
-- 11. Give me the full product list sorted by category from A to Z, and within each category with the most expensive product first.
select product_name,category,price from products order by category,price desc;
-- 12. Show me our 10 biggest delivered orders: who ordered, from which city, and how much they paid.
select customer_name,city,payment_mode,order_status,total_amount from orders where order_status='delivered' order by total_amount desc limit 10;
-- 13. Give management a one-line summary of all orders that were not cancelled: how many orders, total revenue, average order value, smallest order and largest order. Use readable headings.
select count(*) as 'Total orders',sum(total_amount) as 'Avg order value',min(total_amount) as ' smallest order',max(total_amount) as 'largest order' from orders where order_status<>'cancelled';
-- 14. How many orders do we have in total, how many of them had a discount, and how many different customers have ordered?
-- 15. For delivered orders, show each city with its number of orders and revenue, biggest revenue first.
select city,count(*) as 'Total orders',sum(total_amount) as 'Total revenue' from orders where order_status = 'deliverd' group by city order by 'Total revenue' desc;
-- 16. For orders that were not cancelled, show each payment method with its number of orders and average order value. Only include methods used on more than 12 orders.
select payment_mode,count(*) as 'Total orders',avg (total_amount) as 'avg order value' from orders where order_status<>'cancelled' group by payment_mode having count(*)>12;
-- 17. We want to reward loyal customers. Who has placed more than 4 orders (not counting cancelled ones)? Show their name, number of orders and total spend, and give me only the top 5 spenders.
-- 18. For each product category, show how many products we sell, their average price and the total units in stock. Leave out categories with 3 products or fewer.
select category,count(*) as 'Total products',avg(price) as 'Avg price',sum(stock_qty) as 'Total stock' from products group by category having count(*)>3;
-- 19. Operations wants to find slow cities. Among delivered orders, which cities take more than 6 days on average to deliver? Show the average, slowest first.
-- 20. Looking only at delivered orders placed on or after 1 April 2026, and leaving out Delhi, show the number of orders and revenue for each payment method. Only include methods with revenue above ₹15,000, and show just the top 2.
select payment_mode,count(*) as 'Total orders',sum(total_amount) as 'Total revenue' from orders where order_status='deliverd' and order_date>='2026-04-01' and city<> 'delhi' group by payment_mode;
