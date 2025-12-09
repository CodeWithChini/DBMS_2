------Lab-2	Stored Procedure

--	Part – A 

--1.INSERT Procedures: Create stored procedures to insert records into STUDENT tables (SP_INSERT_STUDENT)
--StuID	Name	Email	Phone	Department	DOB	EnrollmentYear
--10	Harsh Parmar	harsh@univ.edu	9876543218	CSE	2005-09-18	2023
--20	Om Patel	om@univ.edu	9876543211	IT	2002-08-22	2022

CREATE OR ALTER PROC PR_INSERT_STUDENT
 @StudentID INT ,
 @StuName VARCHAR(100) ,
 @StuEmail VARCHAR(100) ,
 @StuPhone VARCHAR(15) ,
 @StuDept VARCHAR(50),
 @DOB DATE ,
 @StuEnrollmentYear INT 
 AS 
 BEGIN
	INSERT INTO STUDENT (StudentID,StuName,StuEmail,StuPhone,StuDepartment,StuDateOfBirth,StuEnrollmentYear)
	VALUES(@StudentID,@StuName,@StuEmail,@StuPhone,@StuDept,@DOB,@StuEnrollmentYear)
 END

 EXEC PR_INSERT_STUDENT 10	,'Harsh Parmar', 'harsh@univ.edu', '9876543218', 'CSE','2005-09-18',2023;
 EXEC PR_INSERT_STUDENT 20	,'Om Patel', 'om@univ.edu', '9876543211', 'IT','2002-08-22',2022;

 SELECT * FROM STUDENT

--2.	INSERT Procedures: Create stored procedures to insert records into COURSE tables 
--(SP_INSERT_COURSE)

CREATE OR ALTER PROC PR_INSERT_COURSE
@CourseID VARCHAR(10),
@CourseName VARCHAR(100),
@CourseCredits INT ,
@CourseDepartment VARCHAR(50),
@CourseSemester INT 
AS 
BEGIN
	INSERT INTO COURSE(CourseID,CourseName,CourseCredits,CourseDepartment,CourseSemester)
	VALUES(@CourseID,@CourseName,@CourseCredits ,@CourseDepartment,@CourseSemester)
END

EXEC PR_INSERT_COURSE 'CS330','Computer Networks',4, 'CSE', 5
EXEC PR_INSERT_COURSE 'EC120','Electronic Circuits',3, 'ECE', 2

SELECT * FROM COURSE

--3.	UPDATE Procedures: Create stored procedure SP_UPDATE_STUDENT to update Email and Phone in STUDENT table. (Update using studentID)

CREATE OR ALTER PROC PR_UPDATE_STUDENT
 @StudentID INT ,
 @StuEmail VARCHAR(100) ,
 @StuPhone VARCHAR(15) 
 AS 
 BEGIN
	UPDATE STUDENT
	SET StuEmail = @StuEmail,
		StuPhone = @StuPhone
	WHERE StudentID = @StudentID
 END

 
EXEC PR_UPDATE_STUDENT

--4.	DELETE Procedures: Create stored procedure SP_DELETE_STUDENT to delete records from STUDENT where Student Name is Om Patel.

CREATE OR ALTER PROC PR_DELETE_STUDENT
 @StuName VARCHAR(100) 
 AS 
 BEGIN
	DELETE
	FROM STUDENT
	WHERE StuName = @StuName
 END

EXEC PR_DELETE_STUDENT 'Om Patel';
SELECT * FROM STUDENT

--5.SELECT BY PRIMARY KEY: Create stored procedures to select records by primary key (SP_SELECT_STUDENT_BY_ID) from Student table.

CREATE OR ALTER PROC PR_SELECT_STUDENT_BY_ID
 @StudentID INT 
 AS 
 BEGIN
	SELECT *
	FROM STUDENT
	WHERE StudentID = @StudentID
 END

EXEC PR_SELECT_STUDENT_BY_ID ;
SELECT * FROM STUDENT

--6.	Create a stored procedure that shows details of the first 5 students ordered by EnrollmentYear.

CREATE OR ALTER PROC PR_TOP5_STUDENTS_BY_ENROLLMENT
AS 
BEGIN
    SELECT TOP 5 *
    FROM STUDENT
    ORDER BY StuEnrollmentYear
END

EXEC PR_TOP5_STUDENTS_BY_ENROLLMENT



--	  Part – B


--7.	Create a stored procedure which displays faculty designation-wise count.

CREATE OR ALTER PROC PR_FACULTY_DESIGNATION_COUNT
@FacultyID INT ,
@FacultyName VARCHAR(100),
@FacultyDepartment VARCHAR(50) ,
@FacultyDesignation VARCHAR(50)
AS 
BEGIN 
	SELECT FacultyDesignation, COUNT(*) AS FACULTY_COUNT
	FROM FACULTY
	GROUP BY FacultyDesignation
END

EXEC PR_FACULTY_DESIGNATION_COUNT

--8.	Create a stored procedure that takes department name as input and returns all students in that department.

CREATE OR ALTER PROC PR_GET_STUDENTS_BY_DEPARTMENT
   @DepartmentName VARCHAR(50)
AS 
BEGIN
    SELECT *
    FROM STUDENT
    WHERE StuDepartment = @DepartmentName
    ORDER BY StuName
END

EXEC PR_GET_STUDENTS_BY_DEPARTMENT 'CSE'

--	  Part – C 


--9.	Create a stored procedure which displays department-wise maximum, minimum, and average credits of courses.

CREATE OR ALTER PROC PR_DEPT_WISE_CREDITS_COURSE
AS 
BEGIN
	SELECT 
		MAX(CourseCredits) AS MAXCREDITS,
		MIN(CourseCredits) AS MINCREDITS,
		AVG(CourseCredits) AS AVGCREDITS,
		CourseDepartment
	FROM COURSE
	GROUP BY CourseDepartment
END

EXEC PR_DEPT_WISE_CREDITS_COURSE


--10.Create a stored procedure that accepts StudentID as parameter and returns all courses the student is enrolled in with their grades.

CREATE OR ALTER PROC PR_GET_STUDENT_COURSES_GRADES
    @StudentID INT
AS 
BEGIN
    SELECT CourseName, Grade
    FROM STUDENT S
    INNER JOIN ENROLLMENT E 
		ON S.StudentID = E.StudentID
    INNER JOIN COURSE C 
		ON E.CourseID = C.CourseID
    WHERE S.StudentID = @StudentID
    ORDER BY C.CourseName
END

EXEC PR_GET_STUDENT_COURSES_GRADES 5
