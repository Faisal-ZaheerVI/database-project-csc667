-- Script name: triggers.sql
-- Author:      Faisal Zaheer
-- Purpose:     Adding triggers to test the integrity of the College Management Database System.

SET SQL_SAFE_UPDATES = 0; 

-- the database used to insert the data into.
USE collegemanagementdb;

DROP TRIGGER IF EXISTS UPDATE_FACULTY_COUNT;
DROP TRIGGER IF EXISTS UPDATE_PRODUCT_ON_INSERT;
DROP TRIGGER IF EXISTS UPDATE_PRODUCT;
DROP TRIGGER IF EXISTS CREATE_FACULTY_ACCOUNT;
DROP PROCEDURE IF EXISTS COURSES_IN_BUILDING;
DROP FUNCTION IF EXISTS FULL_TIME_STUDENTS_COUNT;
DROP TRIGGER IF EXISTS ASSIGN_TEACHER;
DROP FUNCTION IF EXISTS AVG_GRADER_SALARY;
DROP FUNCTION IF EXISTS AVG_TEACHER_SALARY;
DROP PROCEDURE IF EXISTS COURSE_GRADERS;

DELIMITER $$

-- Update faculty_count in Department.
CREATE TRIGGER UPDATE_FACULTY_COUNT AFTER INSERT ON Faculty_Member 
FOR EACH ROW
    BEGIN
		DECLARE new_faculty_count INT;
        SET new_faculty_count = (SELECT count(*) from Faculty_Member WHERE department = new.department);
        UPDATE Department SET faculty_count = new_faculty_count WHERE department_id = new.department;
	END$$
    
-- Checks to make sure Product is listed as an online product if it belongs to no store.
CREATE TRIGGER UPDATE_PRODUCT_ON_INSERT AFTER INSERT ON Product 
FOR EACH ROW
    BEGIN
        IF (new.store = null && new.is_online = 0) THEN 
            UPDATE Product SET is_online = 1 WHERE product_id = new.product_id; 
		END IF;
	END$$
    
CREATE TRIGGER UPDATE_PRODUCT AFTER UPDATE ON Product 
FOR EACH ROW
    BEGIN
        IF (new.store = null && new.is_online = 0) THEN 
            UPDATE Product SET is_online = 1 WHERE product_id = new.product_id; 
		END IF;
	END$$

-- Automatically creates an Account for a newly added Faculty member.
CREATE TRIGGER CREATE_FACULTY_ACCOUNT BEFORE INSERT ON Faculty_Member
FOR EACH ROW
	BEGIN
		DECLARE username VARCHAR(45);
        DECLARE count INT;
        DECLARE num INT;
        DECLARE dob DATE;
        DECLARE newPassword VARCHAR(45);
        DECLARE accountId INT;
        -- Turns name like Faisal Zaheer into fzaheer
        SET username = LOWER(CONCAT(SUBSTR(new.name,1,1), REPLACE(SUBSTRING(new.name, POSITION(" " in new.name) + 1, LENGTH(new.name)), ' ', '')));
        SET newPassword = UPPER(CONCAT('PASSWORD_', SUBSTRING(new.name, 1, POSITION(" " in new.name) - 1)));
        SET count = (SELECT COUNT(Account.email) FROM Account WHERE Account.email LIKE CONCAT('%', username, '%'));
        SET dob = (SELECT Employee.dob FROM Employee WHERE Employee.name = new.name);
        -- Emails DO exist with username already
        IF (count != 0) THEN
			-- If an email exists with the same username (i.e. fzaheer@mail.sfsu.edu exists), do fzaheer1.
			SET num = 1;
            SET username = CONCAT(username, num);
            SET count = (SELECT COUNT(Account.email) FROM Account WHERE Account.email LIKE CONCAT('%', username, '%'));
            -- If fzaheer1 exists, do fzaheer2, or fzaheer3, and so forth until one exists.
            WHILE count != 0 DO
				SET num = num + 1;
                SET username = CONCAT(username, num);
                SET count = (SELECT COUNT(Account.email) FROM Account WHERE Account.email LIKE CONCAT('%', username, '%'));
			END WHILE;
        END IF;
        
		-- Insert a new Account (phone number to be set by user, auto generated password is strongly recommended to be changed by user).
		INSERT INTO Account (email, phone, password, dob) VALUES (CONCAT(username, '@sfsu.edu'), '###-###-####', newPassword, dob);
		SET accountId = (SELECT LAST_INSERT_ID());
        SET new.account = accountId;
    END$$

-- 6. Create a procedure to find all the Courses that are being taught in Rooms in a given Building (Building name passed in as a parameter).
-- *courses_in_building <Building_name>
CREATE PROCEDURE COURSES_IN_BUILDING (IN BuildingName VARCHAR(45))
	BEGIN
		SELECT Course.code AS "Course", CONCAT(Building.building_name, " ", Room.room_number) AS "Room", College.college_name AS "College" FROM Class
		JOIN Room ON Room.room_id = Class.room
		JOIN Course ON Course.course_id = Class.course
		JOIN Building ON Building.building_id = Room.building
		JOIN Campus ON Campus.campus_id = Building.campus
		JOIN College ON College.college_id = Campus.college
		WHERE Building.building_name = BuildingName;
    END$$
 
-- 7. Create a function that returns the number of Students that are taking more than 
-- 3 courses during the current semester (full time students).
-- *full_time_students_count
CREATE FUNCTION FULL_TIME_STUDENTS_COUNT()
	RETURNS VARCHAR(45)
	DETERMINISTIC
	BEGIN
		DECLARE numStudents INT;
        CREATE TEMPORARY TABLE test
		SELECT Enrollment.student AS StudentId, Student.name AS "Student",
		(SELECT COUNT(Enrollment.student) FROM Enrollment WHERE Enrollment.student = StudentId) AS "Courses"
		FROM Enrollment
		JOIN Student ON Student.student_id = Enrollment.student
		GROUP BY Enrollment.student
		HAVING COUNT(*) > 3;
        SET numStudents = (SELECT COUNT(*) FROM test);
        DROP TEMPORARY TABLE test;
        IF numStudents = 1 THEN
			return CONCAT(numStudents, " ", "Student");
		ELSEIF numStudents > 1 THEN
			return CONCAT(numStudents, " ", "Students");
		END IF;
    END$$

-- 8. Update automatically the type of Teacher that the Faculty member is after an insert into the list of Teachers. 
-- If they are a Researcher that has published at least one paper, assign them as a Professor. If not, assign them as a Lecturer.
-- 8. *assign_teacher_to_faculty
CREATE TRIGGER ASSIGN_TEACHER AFTER INSERT ON Teacher
FOR EACH ROW
	BEGIN
		DECLARE paperCount INT;
        -- Searches if newly inserted Teacher is a Researcher with over 1 paper published.
        -- Returns 0 if Teacher is not listed as a Researcher or if they a Researcher one with no recorded published papers.
        SET paperCount = (SELECT COUNT(*) FROM Publishing
					JOIN Researcher ON Researcher.researcher_id = Publishing.researcher
					JOIN Faculty_Member ON Faculty_Member.faculty_id = Researcher.faculty
					WHERE Faculty_Member.faculty_id = new.faculty);
		-- If conditions are met, then the type of Teacher they are is a Professor, else a Lecturer.
		IF paperCount > 0 THEN
			INSERT INTO Professor (teacher) VALUES (new.teacher_id);
		ELSE
			INSERT INTO Lecturer (teacher) VALUES (new.teacher_id);
        END IF;
    END$$

-- 11. Create a function that returns the average salary of Graders.
-- 11. *avg_grader_salary
CREATE FUNCTION AVG_GRADER_SALARY()
	RETURNS VARCHAR(45)
	DETERMINISTIC
	BEGIN
		DECLARE avg_salary DECIMAL(10,2);
        DECLARE return_avg VARCHAR(45);
        SET avg_salary = (SELECT AVG (Grader.course_salary) AS "Average Grader Salary" FROM Grader);
        SET return_avg = CONCAT("$", avg_salary); 
        RETURN return_avg;
	END$$
    
CREATE FUNCTION AVG_TEACHER_SALARY()
	RETURNS VARCHAR(45)
	DETERMINISTIC
	BEGIN
		DECLARE avg_salary DECIMAL(10,2);
        DECLARE return_avg VARCHAR(45);
        SET avg_salary = (SELECT CAST(AVG(Faculty_Member.salary) AS DECIMAL(10,2)) 
						FROM Teacher JOIN Faculty_Member ON Faculty_Member.faculty_id = Teacher.faculty);		
        SET return_avg = CONCAT("$",FORMAT(avg_salary, 2));
        RETURN return_avg;
	END$$

-- 17. Create a procedure that returns the number of Graders for a particular course. 
-- (Course code passed in as parameter)
-- 17. *course_graders <Course_code>
CREATE PROCEDURE COURSE_GRADERS (IN CourseCode VARCHAR(8))
	BEGIN
		SELECT Student.name AS "Student", 
		CONCAT(Grader.semester, " ", Grader.year) AS "Semester" FROM Grader
		JOIN Student ON Student.student_id = Grader.student 
		JOIN Course ON Course.course_id = Grader.course
		WHERE Course.code = CourseCode
		ORDER BY Grader.year DESC;
    END$$

DELIMITER ;
