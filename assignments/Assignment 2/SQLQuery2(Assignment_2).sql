use pubs

--Query 1 (Authors in California)

select au_fname,
       au_lname, state
from authors
	where state = 'CA'

--Query 2(List of titles and author names)

select titles.title,
	   authors.au_fname,
	   authors.au_lname
from  titleauthor
	inner join authors
	on titleauthor.au_id= authors.au_id
		inner join titles
		on titles.title_id = titleauthor.title_id


--Query 3(All employees and their jobs)

select emp_id, fname, lname
from jobs
	inner join employee
	on jobs.job_id=employee.job_id



--Query 4(List the titles by total sales price)

select titles.title,
	   titles.price * sales.qty as total_sales
from titles
	inner join sales
	on titles.title_id = sales.title_id




--Query 5(Find the sales for stores in California)

select stor_name, sum(qty) as total_qty
from stores
	inner join sales 
	on sales.stor_id = stores.stor_id
		where state = 'CA'
		group by stores.stor_name


--Query 6(Use SSMS to generate a script to create the authors table describe what the script does)

USE [pubs]
GO

/****** Object:  Table [dbo].[authors]    Script Date: 21/09/2019 21:25:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

sele

CREATE TABLE [dbo].[authors1](
	[au_id] [dbo].[id] NOT NULL,
	[au_lname] [varchar](40) NOT NULL,
	[au_fname] [varchar](20) NOT NULL,
	[phone] [char](12) NOT NULL,
	[address] [varchar](40) NULL,
	[city] [varchar](20) NULL,
	[state] [char](2) NULL,
	[zip] [char](5) NULL,
	[contract] [bit] NOT NULL,
 CONSTRAINT [UPKCL_auidind1] PRIMARY KEY CLUSTERED 
(
	[au_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[authors1] ADD  DEFAULT ('UNKNOWN') FOR [phone]
GO

ALTER TABLE [dbo].[authors1]  WITH CHECK ADD CHECK  (([au_id] like '[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]'))
GO

ALTER TABLE [dbo].[authors1]  WITH CHECK ADD CHECK  (([zip] like '[0-9][0-9][0-9][0-9][0-9]'))
GO


--Query 7(Describe what the au_id is using for a data type)

select au_id from authors

--au_id is of the datatype id 


--Query 8(List the store name, title title name and quantity for all stores that have net 30 payterms)

select stores.stor_name,
	   sales.qty ,
	   sales.payterms,
	   titles.title
from stores
		inner join sales
		on stores.stor_id = sales.stor_id

		inner join titles on titles.title_id = sales.title_id
		where payterms = 'Net 30'


--Query 9 (Find the titles that do not have any sales show the name of the title)


select  title from titles
	where (ytd_sales is null) or (ytd_sales <= 0)


--Query 10 (Alternate Method)

select * from titles
select * from sales

select distinct titles.title
from titles 
	LEFT OUTER JOIN sales
	on titles.title_id = sales.title_id 

except

select distinct titles.title
from titles 
	RIGHT OUTER JOIN sales
	ON titles.title_id = sales.title_id 



