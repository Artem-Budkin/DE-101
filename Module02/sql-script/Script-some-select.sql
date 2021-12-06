select
	city,
	count(distinct order_id) as number_orders,
	sum(sales) as revenue
from orders as o
where category in ('Furniture', 'Technology')  -- in with text or category not in('smth')
and extract ('year' from order_date) = 2018 
group BY city
having sum(sales) > 10000
order by revenue  desc
limit 50


select
	count(*),
	count(distinct orders.order_id),
	sum(sales)
from orders
left join returns on orders.order_id = returns.order_id 


-- subquery
select
	count(*),
	count(distinct orders.order_id)
from orders
where order_id in (select
						distinct order_id
					from "returns")
					
					
-- time timestamp					
select date_trunc('day', now())