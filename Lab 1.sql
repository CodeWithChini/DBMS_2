----------------------------------------LAB 1--------------------------------------------

--------------------------------------Part – A -------------------------------------------


--1.	Retrieve all unique departments from the STUDENT table.

SELECT DISTINCT StuDepartment 
FROM STUDENT

--2.	Insert a new student record into the STUDENT table.
--(9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)

INSERT INTO STUDENT
VALUES(9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)

--3.	Change the Email of student 'Raj Patel' to 'raj.p@univ.edu'. (STUDENT table)

UPDATE STUDENT
SET STUEMAIL = 'raj.p@univ.edu'
WHERE STUNAME = 'RAJ PATEL'

--4.	Add a new column 'CGPA' with datatype DECIMAL(3,2) to the STUDENT table.

ALTER TABLE STUDENT
ADD CGPA DECIMAL(3,2)

--5.	Retrieve all courses whose CourseName starts with 'Data'. (COURSE table)

SELECT * FROM COURSE
WHERE CourseName LIKE 'DATA%'

--6.	Retrieve all students whose Name contains 'Shah'. (STUDENT table)

SELECT * FROM STUDENT
WHERE STUName LIKE '%SHAH%'

--7.	Display all Faculty Names in UPPERCASE. (FACULTY table)

SELECT UPPER (FacultyName)
FROM FACULTY

--8.	Find all faculty who joined after 2015. (FACULTY table)

SELECT * 
FROM FACULTY
WHERE FacultyJoiningDate > 2015

--9.	Find the SQUARE ROOT of Credits for the course 'Database Management Systems'. (COURSE table)

SELECT SQRT(CourseCredits) 
FROM COURSE
WHERE CourseName = 'Database Management Systems'

--10.	Find the Current Date using SQL Server in-built function.

SELECT GETDATE()

--11.	Find the top 3 students who enrolled earliest (by EnrollmentYear). (STUDENT table)

SELECT TOP 3 * FROM STUDENT
ORDER BY StuEnrollmentYear ASC;

--12.	Find all enrollments that were made in the year 2022. (ENROLLMENT table)

SELECT * FROM ENROLLMENT
WHERE YEAR(EnrollmentDate) = 2022;

--13.	Find the number of courses offered by each department. (COURSE table)

SELECT CourseDepartment, COUNT(*) AS CourseCount
FROM COURSE
GROUP BY CourseDepartment;

--14.	Retrieve the CourseID which has more than 2 enrollments. (ENROLLMENT table)

SELECT CourseID FROM ENROLLMENT
GROUP BY CourseID
HAVING COUNT(*) > 2;

--15.	Retrieve all the student name with their enrollment status. (STUDENT & ENROLLMENT table)

SELECT S.StuName, E.EnrollmentStatus
FROM STUDENT S
JOIN ENROLLMENT E 
ON S.StudentID = E.StudentID;

--16.	Select all student names with their enrolled course names. (STUDENT, COURSE, ENROLLMENT table)

SELECT S.StuName, C.CourseName
FROM STUDENT S
JOIN ENROLLMENT E ON S.StudentID = E.StudentID
JOIN COURSE C ON E.CourseID = C.CourseID;

--17.	Create a view called 'ActiveEnrollments' showing only active enrollments with student name and  course name. (STUDENT, COURSE, ENROLLMENT,  table)

CREATE VIEW ActiveEnrollments AS
SELECT S.StuName, C.CourseName, E.EnrollmentStatus
FROM STUDENT S
JOIN ENROLLMENT E ON S.StudentID = E.StudentID
JOIN COURSE C ON E.CourseID = C.CourseID
WHERE E.EnrollmentStatus = 'Active';

--18.	Retrieve the student’s name who is not enrol in any course using subquery. (STUDENT, ENROLLMENT TABLE)

SELECT StuName 
FROM STUDENT
WHERE StudentID NOT IN (SELECT StudentID FROM ENROLLMENT);

--19.	Display course name having second highest credit. (COURSE table)

SELECT TOP 1 CourseName 
FROM COURSE
WHERE CourseCredits < (SELECT MAX(CourseCredits) 
                       FROM COURSE)
ORDER BY CourseCredits DESC;



---------------------------------------Part – B--------------------------------------------



--20.	Retrieve all courses along with the total number of students enrolled. (COURSE, ENROLLMENT table)

SELECT C.CourseID, C.CourseName, COUNT(E.StudentID) AS EnrolledStudents
FROM COURSE C
LEFT JOIN ENROLLMENT E ON C.CourseID = E.CourseID
GROUP BY C.CourseID, C.CourseName;

--21.	Retrieve the total number of enrollments for each status, showing only statuses that have more than 2 enrollments. (ENROLLMENT table)

SELECT EnrollmentStatus, COUNT(*) AS TotalEnrollments
FROM ENROLLMENT
GROUP BY EnrollmentStatus
HAVING COUNT(*) > 2;

--22.	Retrieve all courses taught by 'Dr. Sheth' and order them by Credits. (FACULTY, COURSE, COURSE_ASSIGNMENT table)

SELECT C.CourseID, C.CourseName, C.CourseCredits
FROM FACULTY F
JOIN COURSE_ASSIGNMENT CA ON F.FacultyID = CA.FacultyID
JOIN COURSE C ON CA.CourseID = C.CourseID
WHERE F.FacultyName = 'Dr. Sheth'
ORDER BY C.CourseCredits;


---------------------------------------Part – C---------------------------------------------- 


--23.	List all students who are enrolled in more than 3 courses. (STUDENT, ENROLLMENT table)

SELECT S.StudentID, S.StuName, COUNT(E.EnrollmentID) AS CourseCount
FROM STUDENT S
JOIN ENROLLMENT E ON S.StudentID = E.StudentID
GROUP BY S.StudentID, S.StuName
HAVING COUNT(E.EnrollmentID) > 3;

--24.	Find students who have enrolled in both 'CS101' and 'CS201' Using Sub Query. (STUDENT, ENROLLMENT table)

SELECT StuName 
FROM STUDENT
WHERE StudentID IN (
    SELECT StudentID 
    FROM ENROLLMENT 
    WHERE CourseID = 'CS101'
    INTERSECT
    SELECT StudentID 
    FROM ENROLLMENT 
    WHERE CourseID = 'CS201'
);

--25.	Retrieve department-wise count of faculty members along with their average years of experience (calculate experience from JoiningDate). (Faculty table)

SELECT FacultyDepartment, COUNT(*) AS FACULTYCOUNT,
    AVG(DATEDIFF(YEAR, FacultyJoiningDate, GETDATE())) AS AVGYEAROFEXPERIENCE
FROM FACULTY
GROUP BY FacultyDepartment
