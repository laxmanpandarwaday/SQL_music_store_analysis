select * from employee
order by levels desc
limit 1;

select billing_country, count(*) as no_of_invoices from invoice
group by billing_country
order by no_of_invoices desc;

select * from invoice 
order by total desc
limit 3;

select billing_city, sum(total) from invoice
group by billing_city
order by 2 desc
limit 1;

select first_name, last_name, sum(total) from customer c
join invoice i
using(customer_id)
group by customer_id
order by 3 desc
limit 1;

with rock_genre as (select * from genre where name = 'Rock')
select distinct email, first_name, last_name, g.name from customer c
join invoice i using (customer_id)
join invoice_line il using (invoice_id)
join track t using (track_id)
join rock_genre g using (genre_id)
order by email;

select ar.name, count(*) from track t
join album2 al using (album_id)
join artist ar using (artist_id)
join genre g using (genre_id)
where g.name = 'Rock'
group by ar.artist_id
order by 2 desc
limit 10;

select name, milliseconds from track
where milliseconds > (select avg(milliseconds) from track)
order by 2 desc;

select customer_id, artist_id, sum(total) from customer
join invoice using (customer_id)
join invoice_line using (invoice_id)
join track using (track_id)
join album2 using (album_id)
join artist using (artist_id)
group by customer_id, artist_id
order by 1;

with cte as (select customer_id, first_name, last_name, billing_country, sum(total) as total_spent,
row_number() over(partition by billing_country order by sum(total) desc) as row_no 
from invoice i
join customer c using (customer_id)
group by 1,2,3,4
order by 4 asc,5 desc)
-- cte2 as (select *, row_number() over(partition by cte.country order by total_spent desc) as row_no from cte)
select * from cte where row_no <= 1;

