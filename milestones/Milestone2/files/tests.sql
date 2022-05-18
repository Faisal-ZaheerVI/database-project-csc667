-- Script name: tests.sql
-- Author:      Faisal Zaheer
-- Purpose:     Testing the integrity of the College Management Database System.

SET SQL_SAFE_UPDATES = 0; 

-- the database used to insert the data into.
USE collegemanagementdb;

-- 1. Testing College table
DELETE FROM College WHERE college_name = "San Jose State University";
UPDATE College SET college_id = 4 WHERE college_name = "San Francisco State University";

-- 2. Testing Department table
DELETE FROM Department WHERE department_name = "Mathematics";
UPDATE Department SET department_id = 2 WHERE department_name = "Biology";

-- 3. Testing Employee table
DELETE FROM Employee WHERE ssn = "433-45-6789";
UPDATE Employee SET salary = 90000 WHERE ssn = "333-45-6789";

-- 4. Testing Account table
DELETE FROM Account WHERE account_id = 15;
UPDATE Account SET account_id = 15 WHERE email = "jschmuck@sfsu.edu"; 

-- 5. Testing Faculty_Member table
DELETE FROM Faculty_Member WHERE account = 1;
UPDATE Faculty_Member SET account = 15 WHERE Faculty_id = 12;

-- 6. Testing Teacher table 
DELETE FROM Teacher WHERE teacher_id = 6;
-- Error here:
-- 18:41:10	UPDATE Teacher SET faculty = 12 WHERE teacher_id = 1	Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`collegemanagementdb`.`teacher`, CONSTRAINT `FK_faculty_teacher` FOREIGN KEY (`faculty`) REFERENCES `faculty_member` (`faculty_id`) ON DELETE CASCADE ON UPDATE CASCADE)	0.078 sec
-- UPDATE Teacher SET faculty = 12 WHERE teacher_id = 1;

-- 7. Testing Course table 
DELETE FROM Course WHERE title = "Data Structures";
UPDATE Course SET course_id = 3 WHERE code = "CSC631";

-- 8. Testing Lab table 
DELETE FROM Lab WHERE lab_id = 2;
UPDATE Lab SET course = 2 WHERE lab_id = 1;

-- 9. Testing Student table
DELETE FROM Student WHERE age = 25;
UPDATE Student SET student_id = 917567060 WHERE student_id = 917567059;

-- 10. Testing Researcher table 
DELETE FROM Researcher WHERE faculty = 7;
UPDATE Researcher SET faculty = 7 WHERE researcher_id = 2;

-- 11. Testing Professor table 
DELETE FROM Professor WHERE professor_id = 3;
-- Error here:
-- 18:41:39	UPDATE Professor SET teacher = 4 WHERE professor_id = 2	Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`collegemanagementdb`.`professor`, CONSTRAINT `FK_teacher_professor` FOREIGN KEY (`teacher`) REFERENCES `teacher` (`teacher_id`) ON DELETE CASCADE ON UPDATE CASCADE)	0.079 sec
-- UPDATE Professor SET teacher = 4 WHERE professor_id = 2;

-- 12. Testing Lecturer table 
DELETE FROM Lecturer WHERE lecturer_id = 3;
-- Error here:
-- 18:41:51	UPDATE Lecturer SET teacher = 6 WHERE lecturer_id = 1	Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`collegemanagementdb`.`lecturer`, CONSTRAINT `FK_teacher_lecturer` FOREIGN KEY (`teacher`) REFERENCES `teacher` (`teacher_id`) ON DELETE CASCADE ON UPDATE CASCADE)	0.062 sec
-- UPDATE Lecturer SET teacher = 6 WHERE lecturer_id = 1;

-- 13. Testing Paper table 
DELETE FROM Paper WHERE title = "How to Pass CSC675";
UPDATE Paper SET paper_id = 1 WHERE title = "The Best Paper You'll Ever Read";

-- 14. Testing Payment table 
DELETE FROM Payment WHERE amount = 1000;
UPDATE Payment SET student = 917567060 WHERE amount = 100;

-- 15. Testing Credit_Card table
DELETE FROM Credit_Card WHERE bank = "Gator Bank";
UPDATE Credit_Card SET ccv = 124 WHERE payment = 2;

-- 16. Testing Bank_Account table 
DELETE FROM Bank_Account WHERE bank = "Chased";
UPDATE Bank_Account SET acct_number = "5665987822" WHERE payment = 4;

-- 17. Testing Address table 
DELETE FROM Address WHERE city = "Berkeley";
UPDATE Address SET city = "San Francisco" WHERE city = "Daly City";

-- 18. Testing Major table 
DELETE FROM Major WHERE major_name = "Mathematics";
UPDATE Major SET major_id = 3 WHERE major_name = "Business";

-- 19. Testing Minor table 
DELETE FROM Minor WHERE minor_name = "French";
UPDATE Minor SET minor_id = 3 WHERE minor_name = "Psycology";

-- 20. Testing Campus table 
DELETE FROM Campus WHERE college != 1;
UPDATE Campus SET campus_id = 2 WHERE address = 15;

-- 21. Testing Building table 
DELETE FROM Building WHERE campus = 2;
UPDATE Building SET building_name = "Science and Engineering" WHERE building_name = "Science";

-- 22. Testing Room table 
DELETE FROM Room WHERE room_number = 801;
UPDATE Room SET room_number = 522 WHERE room_number = 422;

-- 23. Testing Office table (room can be null)
DELETE FROM Office WHERE faculty = 9;
UPDATE Office SET room = null WHERE room = 3;

-- 24. Testing Class table (room can be null)
DELETE FROM Class WHERE course = 2;
UPDATE Class SET room = null WHERE room = 1;

-- 25. Testing Visitor table 
DELETE FROM Visitor WHERE name = "Lucius Visitor";
UPDATE Visitor SET visitor_id = 5 WHERE name = "Hagrid Visitor";

-- 26. Testing Store table (campus can be null)
DELETE FROM Store WHERE store_name = "GatorTrade";
UPDATE Store SET store_name = "Gator Bookstore" WHERE campus = 1;

-- 27. Testing Product table (store can be null)
DELETE FROM Product WHERE store = null;
UPDATE Product SET store = null WHERE product_name = "PHYS220 Workbook";

-- 28. Testing Wellness_center table 
DELETE FROM Wellness_center WHERE wellness_name = "SAN JOSE Wellness Center";
UPDATE Wellness_center SET wellness_center_id = 3 WHERE wellness_name = "UCSF Wellness Center";

-- 29. Testing Janitor table 
DELETE FROM Janitor WHERE janitor_id = 3;
UPDATE Janitor SET janitor_id = 3 WHERE janitor_name = "Terry Janitor";

-- 30. Testing Activities table 
DELETE FROM Activities WHERE activity_id = 4;
UPDATE Activities SET activity_id = 3 WHERE activity_name = "Yoga Training";

-- 31. Testing Assigned_cleaning table 
DELETE FROM Assigned_cleaning WHERE janitor = 3;
UPDATE Assigned_cleaning SET campus = 1 WHERE janitor = 2;

-- 32. Testing College_major table 
DELETE FROM College_major WHERE college != 4;
UPDATE College_major SET college = 3 WHERE major = 6;

-- 33. Testing College_minor table 
DELETE FROM College_minor WHERE college != 4;
UPDATE College_minor SET college = 3 WHERE minor = 6;

-- 34. Testing Employee_address table 
DELETE FROM Employee_address WHERE employee = "223-45-6789";
UPDATE Employee_address SET employee_address_id = 2 WHERE address = 1;

-- 35. Testing Enrollment table 
DELETE FROM Enrollment WHERE course = 5;
UPDATE Enrollment SET semester = "FALL" WHERE course = 10;

-- 36. Testing Grader table 
DELETE FROM Grader WHERE course_salary = 900;
UPDATE Grader SET course_salary = 1300 WHERE year = 2022;

-- 37. Testing Publishing table 
DELETE FROM Publishing WHERE paper = 2;
UPDATE Publishing SET paper = 2 WHERE researcher = 3;

-- 38. Testing Student_address table 
DELETE FROM Student_address WHERE student = 917567060;
UPDATE Student_address SET student = 917567060 WHERE address = 10;

-- 39. Testing Student_major table 
DELETE FROM Student_major WHERE college_major = 3;
UPDATE Student_major SET college_major = 3 WHERE student = 917567060;

-- 40. Testing Student_minor table 
DELETE FROM Student_minor WHERE student = 917567060;
UPDATE Student_minor SET student = 917567060 WHERE college_minor = 2;

-- 41. Testing Supervisors table (both are from employee_id, employee is PK/FK)
DELETE FROM Supervisors WHERE employee = "123-45-6789";
UPDATE Supervisors SET supervisor = "723-45-6789" WHERE employee = "333-45-6789";

-- 42. Testing Teaching_courses table 
DELETE FROM Teaching_courses WHERE teacher = 1;
UPDATE Teaching_courses SET teacher = 1 WHERE course = 5;

-- 43. Testing Visiting_list table
DELETE FROM Visiting_list WHERE visitor = 2;
UPDATE Visiting_list SET date_visiting = '2022-01-18 01:30:00' WHERE visitor = 1;
