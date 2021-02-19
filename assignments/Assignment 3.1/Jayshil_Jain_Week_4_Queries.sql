
-- 1 Using AdventureWorks - List all the employees show name and department

use AdventureWorks2017

select  FirstName,
		LastName, 
		Department 
from HumanResources.vEmployeeDepartment



-- 2 Using AdventureWorks - Show the employees and their current and prior departments


select vEmployeeDepartment.FirstName, vEmployeeDepartment.LastName, vEmployeeDepartment.Department as Current_Department, vEmployeeDepartmentHistory.Department as Prior_Department
from HumanResources.vEmployeeDepartment
	inner join HumanResources.vEmployeeDepartmentHistory
	on HumanResources.vEmployeeDepartment.BusinessEntityID = HumanResources.vEmployeeDepartmentHistory.BusinessEntityID
	--where vEmployeeDepartment.FirstName ='Sheela'
--Condition to get the individuals who have switched Depts

where vEmployeeDepartment.Department != vEmployeeDepartmentHistory.Department


select vEmployeeDepartment.FirstName, vEmployeeDepartment.LastName, vEmployeeDepartment.Department as Current_Department, vEmployeeDepartmentHistory.Department as Prior_Department
from HumanResources.vEmployeeDepartment
	inner join HumanResources.vEmployeeDepartmentHistory
	on HumanResources.vEmployeeDepartment.BusinessEntityID = HumanResources.vEmployeeDepartmentHistory.BusinessEntityID


-- 3 Using AdventureWorks - Break apart the employee login id so that you have the domain (before the /) in one column and the login id (after the /) 
--   in two columns

select  substring(LoginId, 1, 15) as Domain,
		RTRIM(substring(LoginId, 17, 100)) as Login_Id
from HumanResources.Employee


-- 4 Using AdventureWorks - Build a new column in a copy of the employee table that is the employee email address in the form login_id@domain.com, populate the column

select  concat((RTRIM(SUBSTRING(LoginId, 17, 100))),
		'@adventure-works.com') as Login_Id
from HumanResources.Employee


-- 5 Using AdventureWorks - Calculate the age of an employee in years - Does it work if the birthday hasn't happened yet if not fix it


declare @todayDay Date = getDate()
SELECT NationalIDNumber, 
	   floor(DATEDIFF(DAY, BirthDate, @todayDay) / 365.25)
	   as Birthday_Age
from HumanResources.Employee


-- 6 Using Pubs - List a titles prior year sales, define the current year as the max year in the sales (use a subquery).

use Pubs

declare @today Date = getDate() 
select (titles.title), sum(qty*price) as Total
from sales
	join titles
	on (sales.title_id = titles.title_id)
	where year(sales.ord_date) < (select year(@today))
group by titles.title, titles.title_id