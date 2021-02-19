--Query 7

CREATE OR ALTER FUNCTION toggleCase(@input VARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN

DECLARE @counts INT = 1 
WHILE @counts <= LEN(@input)

BEGIN
    SET @input = STUFF(@input, @counts, 1,
           CASE 
              WHEN ASCII(SUBSTRING(@input,@counts,1)) BETWEEN 97 AND 122 THEN UPPER(SUBSTRING(@input,@counts,1))
              WHEN ASCII(SUBSTRING(@input,@counts,1)) BETWEEN 65 AND 90 THEN LOWER(SUBSTRING(@input,@counts,1))
				ELSE ' '
		   END)	  
    SET @counts = @counts + 1
END
RETURN @input
END


select dbo.toggleCase('This is A TEST String')


--Query 8

CREATE or Alter FUNCTION determineGender(@input varchar(10))
RETURNS VARCHAR(10)
AS
BEGIN

RETURN CASE
WHEN right(@input,1) like '%M' then  'Male'
WHEN right(@input,1) like '%F' then  'Female'
END

END

SELECT dbo.determineGender('12eww1F')




--Query 9

CREATE or ALTER FUNCTION GenderTable()
RETURNS TABLE 
AS RETURN (SELECT  emp_id, fname, lname, dbo.determineGender(emp_id) AS gender
FROM employee )

SELECT * FROM dbo.GenderTable()


--Query 10

	CREATE or ALTER FUNCTION agebydob(@age DATETIME)
	RETURNS INT
	BEGIN
	DECLARE @Now DATETIME
	SELECT @Now = getdate()
	RETURN (SELECT 
	 (CONVERT(INT,CONVERT(CHAR(8),@Now,112))-CONVERT(CHAR(8),@age,112))/10000 AS AgeIntYears)
	END

SELECT	dbo.agebydob('1997-06-02') AS Age
	

--Query 11

--Validations will check if the previos job Desc exists if present it will not let data enter\
--Validation will also check no entry made is EMPTY or NULL

CREATE or ALTER PROCEDURE InsertJob @job_desc VARCHAR(50), @min_lvl INT, @max_lvl INT
AS
IF exists (SELECT * FROM jobs 
	  	   WHERE job_desc = @job_desc)
		   PRINT 'Job is already present'
		   ELSE IF (len(@job_desc)= 0 or @job_desc is null or
					len(@min_lvl)= 0 or @min_lvl is null or
					len(@max_lvl)=0 or @max_lvl is null)
		   PRINT 'No feild can be NULL'
ELSE
INSERT INTO jobs(job_desc, min_lvl, max_lvl)

		VALUES(@job_desc, @min_lvl, @max_lvl)
GO

EXEC dbo.InsertJob 'Publisher', 32, 100
-- show error as Publisher Exists

EXEC dbo.InsertJob 'T', null, 100
--Shows error as null value passed

EXEC dbo.InsertJob 'Data Engineer', 80, 100
-- Accepts input

SELECT * FROM jobs






