USE CSE_4B_369

-------- Lab-4 : UDF

--sp ma function call thai
--function ma sp call na thai
---------------------------------------------Part-A-------------------------------------------


--1. Write a scalar function to print "Welcome to DBMS Lab".

CREATE OR ALTER FUNCTION FN_HELLO()
RETURNS VARCHAR(30)
AS
BEGIN
	RETURN 'Welcome to DBMS Lab'
END

SELECT dbo.FN_HELLO()

--2. Write a scalar function to calculate simple interest.

CREATE OR ALTER FUNCTION FN_SI(@P INT, @R INT, @N INT)
RETURNS DECIMAL(8,2)
AS
BEGIN
	RETURN (@P * @R * @N)/100
END

SELECT dbo.FN_SI(10,10,10)

--3. Function to Get Difference in Days Between Two Given Dates

CREATE OR ALTER FUNCTION FN_DIFFDAY
(
    @START_DAY INT,
    @END_DAY INT
)
RETURNS INT
AS
BEGIN
    RETURN (@END_DAY - @START_DAY);
END

SELECT dbo.FN_DIFFDAY(1, 7)

--4. Write a scalar function which returns the sum of Credits for two given CourseIDs.

CREATE OR ALTER FUNCTION FN_SUMOFCREDIT
(
    @CID1 VARCHAR(20),
    @CID2 VARCHAR(20)
)
RETURNS VARCHAR(30)
AS
BEGIN
    DECLARE @SUM INT;
 
    SELECT @SUM = SUM(CourseCredits)
    FROM Course
    WHERE CourseID IN (@CID1, @CID2);
    
    RETURN @SUM;
END

SELECT dbo.FN_SUMOFCREDIT('CS101','CS201')

--5. Write a function to check whether the given number is ODD or EVEN.


CREATE OR ALTER FUNCTION FN_ODDEVEN
(
   @N INT
)
RETURNS VARCHAR(30)
AS
BEGIN
    RETURN CASE
    WHEN @N % 2 = 0 THEN 'EVEN'
    ELSE 'ODD'
    END;
END

SELECT dbo.FN_ODDEVEN(7)

--6. Write a function to print number from 1 to N. (Using while loop)


CREATE OR ALTER FUNCTION FN_1TON
(
   @N INT
)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @I INT
    DECLARE @ANS VARCHAR(30)
    SET @I = 1
    SET @ANS = ' '

    WHILE @I <= @N  
        BEGIN
            SET @ANS = CONCAT(@ANS, @I,' ')
            SET @I = @I + 1
        END
    RETURN @ANS
END

SELECT dbo.FN_1TON(7)


--7. Write a scalar function to calculate factorial of total credits for a given CourseID.

CREATE OR ALTER FUNCTION FN_FACTORIAL
(
   @CID VARCHAR(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @FACT INT , @CREDIT INT, @I INT
    SET @FACT = 1
    SET @I = 1

    SELECT @CREDIT =CourseCredits
    from COURSE
    WHERE COURSEID = @CID
    WHILE @I<=@CREDIT
        BEGIN
            SET @FACT = @FACT * @I
            SET @I = @I + 1
        END
    RETURN @FACT
END

SELECT dbo.FN_FACTORIAL(7)

--8. Write a scalar function to check whether a given EnrollmentYear is in the past, current or future (Case
--statement)


CREATE OR ALTER FUNCTION FN_YEAR
(
   @YEAR INT 
)
RETURNS VARCHAR(40)
AS
BEGIN
    RETURN CASE
        WHEN @YEAR<YEAR(GETDATE()) THEN 'PAST'
        WHEN @YEAR>YEAR(GETDATE()) THEN 'FUTURE'

    ELSE 'CURRENT'
    END
END

SELECT dbo.FN_YEAR('2006')


--9. Write a table-valued function that returns details of students whose names start with a given letter.


CREATE OR ALTER FUNCTION FN_DETAIL
(
   @LETTER VARCHAR(30)
)
RETURNS TABLE
AS

    RETURN
    SELECT * FROM STUDENT
    WHERE StuName LIKE @LETTER + '%'

SELECT * FROM dbo.FN_DETAIL('A')


--10. Write a table-valued function that returns unique department names from the STUDENT table.

CREATE OR ALTER FUNCTION FN_DEPT()
RETURNS TABLE
AS

    RETURN
    SELECT DISTINCT StuDepartment 
    from STUDENT

SELECT * FROM dbo.FN_DEPT()


-----------------------------------------Part-B----------------------------------------


--11. Write a scalar function that calculates age in years given a DateOfBirth.


CREATE OR ALTER FUNCTION FN_AGE
(
   @DOB DATE 
)
RETURNS INT
BEGIN
    RETURN DATEDIFF(YEAR, @DOB,GETDATE())
END

SELECT dbo.FN_AGE('2006-07-09')

--12. Write a scalar function to check whether given number is palindrome or not.



--13. Write a scalar function to calculate the sum of Credits for all courses in the 'CSE' department.
--14. Write a table-valued function that returns all courses taught by faculty with a specific designation.
--Part - C
--15. Write a scalar function that accepts StudentID and returns their total enrolled credits (sum of credits
--from all active enrollments).
--16. Write a scalar function that accepts two dates (joining date range) and returns the count of faculty who
--joined in that period.