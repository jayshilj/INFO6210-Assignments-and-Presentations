use pubs

----Query 1: List the titles in order of total sale. Totals sales is determined by reading the qty from sales 
----and calculating the sales price based on the price of the book in the titles table


 select distinct title_id from sales

select titles.title,
	   sum(titles.price * sales.qty) as total_sales
from titles
	inner join sales
	on titles.title_id = sales.title_id
	group by title
	order by total_sales desc
	

-- Query 2: Add the store name to the query above

select titles.title,
	   stores.stor_name,
	   titles.price * sales.qty as total_sales
from titles
	inner join sales
	on titles.title_id = sales.title_id
	inner join stores
	on sales.stor_id = stores.stor_id
	order by total_sales desc

-- Query 3:  List all the titles and list the royalty schedule

select titles.title, roysched.royalty 
from roysched 
inner join titles
on titles.title_id = roysched.title_id

-- Query 4: List the stores that have orders with more than one title on the order


select (ord_num), count(stor_id) as number_of_recurrence
from sales
	group by (ord_num)
	having count(ord_num) > 1


-- Query 5: Using the last position of the employee id to determine gender generate a count of the number of males and females

select (select count(emp_id) 
from employee
	where emp_id like '%M') as Males,

(select count(emp_id)
from employee
	where emp_id like '%F') as Females
 

 ---- Query 6: Produce a report firstname, lastname and gender. 
 ---- Show gender as Male or Female based on last position in the employee id


 -- Query to update the Employee Table
alter table employee add Gender varchar(10)

update employee set Gender = 
(
select case when emp_id like '%M' then 'MALE'
            when emp_id like '%F' then 'FEMALE' 
			end
)

-- Query to select from Employee Table

select * from employee

select emp_id, fname, lname, 
	(case 
	when right(emp_id,1)  like '%M' then 'MALE'
    when right(emp_id,1)  like '%F' then 'FEMALE'  
	end) as Gender
from employee
order by fname