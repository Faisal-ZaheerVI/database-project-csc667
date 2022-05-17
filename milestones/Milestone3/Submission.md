# College Department Database Management System

## Student Info
**Name**: Faisal Zaheer  
**Student ID#**: 917567058

## Milestone 3 Files Changes
- Modified inserts.sql
- Modified triggers.sql
- Modified EER.mwb (Added campus_name field to Campus table)
- Modified databasemodel.sql

## Discord Server Link
https://discord.gg/Y4w6C2RG5E  

## Repl Invite Link
https://replit.com/join/zkwirqlwbk-faisal-zaheervi  

## Commands

1. *course_students <Course_code>

2. *drop_teacherless_enrollment

3. *students_major <Major_name>

4. *insert_faculty <Employee_name> + <Department_name>

5. *college_visitors <College_name>

6. *courses_in_building <Building_name>

7. *full_time_students_count

8. *assign_teacher_to_faculty \<ssn>

9. *sf_colleges

10. *num_course_teachers

11. *avg_grader_salary

12. *supervisors

13. *avg_teacher_salary

14. *multi_major_students

15. *num_campus_classes

16. *college_stores <College_name>

17. *course_graders <Course_code>

18. *available_courses

## Business Rules
1. Find the number of Students that are taking a specific Course during the current semester.

2. Drop any Enrollment listings of a Course that isn’t being taught by a Teacher.

3. For each Major, find the number of Students assigned that specific Major.

4. Update automatically the number of Faculty members in a Department every time a Faculty Member is inserted into the database.

5. Create a procedure to find all the Visitors that are visiting any campus for a specific College (College name passed in as a parameter).

6. Create a procedure to find all the Courses that are being taught in Rooms in a given Building (Building name passed in as a parameter).

7. Create a function that returns the number of Students that are taking more than 3 courses during the current semester (full time students).

8. Update automatically the type of Teacher that the Faculty member is after an insert into the list of Teachers. If they are a Researcher that has published at least one paper, assign them as a Professor. If not, assign them as a Lecturer.

9. Find the number of college campuses that are located in San Francisco.

10. For each course code (i.e. CSC675), find the number of teachers that are currently teaching that course.

11. Create a function that returns the average salary of Graders.

12. For each Supervisor, find the number of Employees that they supervise.

13. Display the average salaries of Lecturers and Professors.

14. Find the number of students that have been assigned two majors or more.

15. For each college campus, find the number of classes that are offered.

16. Find the number of stores that are assigned to a specific College.

17. Create a procedure that returns the number of Graders for a particular course. (Course code passed in as parameter)

18. Find the number of courses this semester that have less than 30 Students currently enrolled in it.