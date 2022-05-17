# database.py
# Handles all the methods interacting with the database of the application.
# Students must implement their own methods here to meet the project requirements.

import os
import pymysql.cursors
from prettytable import PrettyTable

db_host = os.environ['DB_HOST']
db_username = os.environ['DB_USER']
db_password = os.environ['DB_PASSWORD']
db_name = os.environ['DB_NAME']

def connect():
    try:
        conn = pymysql.connect(host=db_host,
                               port=3306,
                               user=db_username,
                               password=db_password,
                               db=db_name,
                               charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor)
        print("Bot connected to database {}".format(db_name))
        return conn
    except:
        print("Bot failed to create a connection with your database because your secret environment variables " +
              "(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) are not set".format(db_name))
        print("\n")

# your code here
def format_data(headers, rows):
    table = PrettyTable()
    table.field_names = headers
    for header in headers:
      table.align[header] = "c"
    table.add_rows(rows)
    return table

def getResponse(msg):
    data = msg.split()
    errors = PrettyTable()
    errors.field_names = ["Error"]
    response = None
    command = data[0]
    hasErrors = False
    noArgErr = ["This command has no arguments!"]
    fewArgErr = ["You are missing an argument(s)!"]
    manyArgErr = ["Too many arguments!"]

    # --- COMMANDS: ---  
    #   1. *course_students <Course_code>
    if "*course_students" in command:
      # Checks if only the command is given without arguments
      if 2 > len(data):
        errors.add_row(fewArgErr)
        errors.add_row(["Missing <Course_code>"])
        hasErrors = True
      # Command + One argument, aka the correct structure
      elif len(data) == 2:
        code = data[1]
        response = course_students(code)
      # Checks if too many arguments are given
      elif len(data) > 2:
        errors.add_row(manyArgErr)
        hasErrors = True

    #   2. *drop_teacherless_enrollment
    elif "*drop_teacherless_enrollment" in command:
      if 2 > len(data):
        response = drop_teacherless_enrollment()
      else:
        errors.add_row(noArgErr)
        hasErrors = True

    #   3. *students_major <Major_name>
    elif "*students_major" in command:
      if 2 > len(data):
        errors.add_row(fewArgErr)
        errors.add_row(["Missing <Major_name>"])
        hasErrors = True
      else:
        major = data[1]
        if len(data) > 2:
          for x in range(2, len(data)):
            major = major + " " + data[x]
        response = students_major(major)

    #   4. *insert_faculty <Employee_name> + <Department_name>
    elif "*insert_faculty" in command:
      if 4 > len(data):
        errors.add_row(fewArgErr)
        errors.add_row(["Correct format is: <Employee_name> + <Department_name>"])
        hasErrors = True
      elif len(data) > 3:
        employee_name = ''
        department_name = ''
        found = False # Determines when to add to Employee or Department name
        # Separates and assigns Employee name and Department name based on '+' separator
        for x in range(1, len(data)):
          if data[x] == '+':
            found = True
          elif found == False:
            if employee_name == '':
              employee_name = data[x]
            else:
              employee_name = employee_name + ' ' + data[x]
          elif found == True:
            if department_name == '':
              department_name = data[x]
            else:
              department_name = department_name + ' ' + data[x]
        response = insert_faculty(employee_name, department_name)

    #   5. *college_visitors <College_name>
    elif "*college_visitors" in command:
      if 2 > len(data):
        errors.add_row(fewArgErr)
        errors.add_row(["Missing <College_name>"])
        hasErrors = True
      else:
        college_name = data[1]
        if len(data) > 2:
          for x in range(2, len(data)):
            college_name = college_name + " " + data[x]
        response = college_visitors(college_name.lower())

    #   6. *courses_in_building <Building_name>
    elif "*courses_in_building" in command:
      if 2 > len(data):
        errors.add_row(fewArgErr)
        errors.add_row(["Missing <Building_name>"])
        hasErrors = True
      else:
        building_name = data[1]
        if len(data) > 2:
          for x in range(2, len(data)):
            building_name = building_name + " " + data[x]
        response = courses_in_building(building_name.lower())

    #   7. *full_time_students_count
    elif "*full_time_students_count" in command:
      if 2 > len(data):
        response = full_time_students_count()
      else:
        errors.add_row(noArgErr)
        hasErrors = True

    #   8. *assign_teacher_to_faculty <Ssn>
    elif "*assign_teacher_to_faculty" in command:
      if 2 > len(data):
        errors.add_row(fewArgErr)
        errors.add_row(["Missing \<ssn>"])
        hasErrors = True
      elif len(data) == 2:
        inputSSN = data[1]
        response = assign_teacher_to_faculty(inputSSN)
      else:
        errors.add_row(manyArgErr)
        errors.add_row(["\<ssn> should be formatted as 123-45-6789"])
        hasErrors = True

    #   9. *sf_colleges
    elif "*sf_colleges" in command:
      if 2 > len(data):
        response = sf_colleges()
      else:
        errors.add_row(noArgErr)
        hasErrors = True
      
    
    #   10. *num_course_teachers
    elif "*num_course_teachers" in command:
      if 2 > len(data):
        response = num_course_teachers()
      else:
        errors.add_row(noArgErr)
        hasErrors = True
    
    #   11. *avg_grader_salary
    elif "*avg_grader_salary" in command:
      if 2 > len(data):
        response = avg_grader_salary()
      else:
        errors.add_row(noArgErr)
        hasErrors = True
    
    #   12. *supervisors
    elif "*supervisors" in command:
      if 2 > len(data):
        response = supervisors()
      else:
        errors.add_row(noArgErr)
        hasErrors = True
    
    #   13. *avg_teacher_salary
    elif "*avg_teacher_salary" in command:
      if 2 > len(data):
        response = avg_teacher_salary()
      else:
        errors.add_row(noArgErr)
        hasErrors = True
    
    #   14. *multi_major_students
    elif "*multi_major_students" in command:
      if 2 > len(data):
        response = multi_major_students()
      else:
        errors.add_row(noArgErr)
        hasErrors = True
    
    #   15. *num_campus_classes
    elif "*num_campus_classes" in command:
      if 2 > len(data):
        response = num_campus_classes()
      else:
        errors.add_row(noArgErr)
        hasErrors = True
    
    #   16. *college_stores <College_name>
    elif "*college_stores" in command:
      if 2 > len(data):
        errors.add_row(fewArgErr)
        errors.add_row(["Missing <College_name>"])
        hasErrors = True
      else:
        college_name = data[1]
        if len(data) > 2:
          for x in range(2, len(data)):
            college_name = college_name + " " + data[x]
        response = college_stores(college_name)
    
    #   17. *course_graders <Course_code>
    elif "*course_graders" in command:
      if 2 > len(data):
        errors.add_row(fewArgErr)
        errors.add_row(["Missing <Course_code>"])
        hasErrors = True
      elif len(data) == 2:
        course_code = data[1]
        response = course_graders(course_code)
      else:
        errors.add_row(manyArgErr)
        hasErrors = True
    
    #   18. *available_courses
    elif "*available_courses" in command:
      if 2 > len(data):
        response = available_courses()
      else:
        errors.add_row(noArgErr)
        hasErrors = True

    # SUPPLEMENTAL COMMANDS:
    # (To help with retrieving existing sample data from database to test required commands)
      
    # View all Colleges and their Campuses
    elif "*view_college_campus" in command:
      if 2 > len(data):
        response = view_college_campus()
      else:
        errors.add_row(noArgErr)
        hasErrors = True

    # Views all Buildings and relevant info
    elif "*view_buildings" in command:
      if 2 > len(data):
        response = view_buildings()
      else:
        errors.add_row(noArgErr)
        hasErrors = True

    # Views all Departments and relevant info
    elif "*view_departments" in command:
      if 2 > len(data):
        response = view_departments()
      else:
        errors.add_row(noArgErr)
        hasErrors = True

    # Views all Employees and relevant info
    elif "*view_employees" in command:
      if 2 > len(data):
        response = view_employees()
      else:
        errors.add_row(noArgErr)
        hasErrors = True

    # Views all Faculty Members and relevant info
    elif "*view_faculty" in command:
      if 2 > len(data):
        response = view_faculty()
      else:
        errors.add_row(noArgErr)
        hasErrors = True

    # Views all Students and relevant info
    elif "*view_students" in command:
      if 2 > len(data):
        response = view_students()
      else:
        errors.add_row(noArgErr)
        hasErrors = True

    # Views all Courses and relevant info
    elif "*view_courses" in command:
      if 2 > len(data):
        response = view_courses()
      else:
        errors.add_row(noArgErr)
        hasErrors = True

    # Views all Majors and relevant info
    elif "*view_majors" in command:
      if 2 > len(data):
        response = view_majors()
      else:
        errors.add_row(noArgErr)
        hasErrors = True
        
    # If there are errors, send the errors as a response.
    if hasErrors:
        errors = "`" + errors.get_string() + "`"
        return errors
    return response

#   1. Find the number of Students that are taking a specific Course during the current semester.
#   1. *course_students <Course_code>
def course_students(code):
  try:
    conn = connect()
    rows = []
    headers = ['Student ID', 'Name', 'Course', 'Semester', 'Year']
    if conn:
      cursor = conn.cursor()
      query = """SELECT Student.student_id AS "Student ID", Student.name AS "Name", Course.code AS "Course", 
  Enrollment.semester AS "Semester", Enrollment.year AS "Year" FROM Student
  JOIN Enrollment ON Enrollment.student = Student.student_id
  JOIN Course ON Course.course_id = Enrollment.course
  WHERE Enrollment.semester = "SPRING" AND Enrollment.year = 2022 AND Course.code = %s
  ORDER BY Student.student_id ASC;"""
      course = code.upper()
      cursor.execute(query, course)
      data = cursor.fetchall()
      if data:
        for queryData in data:
          row = []
          column1 = queryData['Student ID']
          column2 = queryData['Name']
          column3 = queryData['Course']
          column4 = queryData['Semester']
          column5 = queryData['Year']
          row.append(column1)
          row.append(column2)
          row.append(column3)
          row.append(column4)
          row.append(column5)
          rows.append(row)
        output = format_data(headers, rows)
        output.title = 'Students enrolled in ' + code.upper()
        # Aligns output data by wrapping in code block with ``  
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

#   2. Drop any Enrollment listings of a Course that isn’t being taught by a Teacher.
#   2. *drop_teacherless_enrollment
def drop_teacherless_enrollment():
  try:
    conn = connect()
    rows = []
    headers = ['Course ID', 'Course Name', 'Student']
    if conn:
      cursor = conn.cursor()
      query = """SELECT Enrollment.course AS "Course ID", Course.title AS "Course Name", 
Student.name AS "Student" FROM Enrollment
JOIN Course ON Course.course_id = Enrollment.course
JOIN Student ON Student.student_id = Enrollment.student
WHERE Enrollment.course
NOT IN (SELECT Teaching_Courses.course FROM Teaching_Courses)
ORDER BY Enrollment.course ASC;"""
      cursor.execute(query)
      data = cursor.fetchall()
      if data:
        for queryData in data:
          row = []
          column1 = queryData['Course ID']
          column2 = queryData['Course Name']
          column3 = queryData['Student']
          row.append(column1)
          row.append(column2)
          row.append(column3)
          rows.append(row)
        output = format_data(headers, rows)
        output.title = 'Deleted Enrollment records'
        query = """DELETE FROM Enrollment WHERE Enrollment.course NOT IN (SELECT Teaching_Courses.course FROM Teaching_Courses);"""
        cursor.execute(query)
        conn.commit()
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
      else:
        return 'All untaught Enrollment records have already been dropped!'
  except Exception as error:
    print("Error:")
    print(error)
    output = -1
    return output

#   3. For each Major, find the number of Students assigned that specific Major.
#   3. *students_major <Major_name>
def students_major(major_name):
  try:
    conn = connect()
    rows = []
    headers = ['Student ID', 'Name', 'Major']
    if conn:
        cursor = conn.cursor()
        query = """SELECT Student_Major.student AS "Student ID", Student.name AS "Name", Major.major_name AS "Major" FROM Student_Major
  JOIN College_Major ON College_Major.college_major_id = Student_Major.student_major_id
  JOIN Major ON Major.major_id = College_Major.major
  JOIN Student ON Student.student_id = Student_Major.student
  WHERE Major.major_name = %s
  ORDER BY Student_Major.student ASC;"""
        major = major_name.lower()
        cursor.execute(query, major)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Student ID']
                column2 = queryData['Name']
                column3 = queryData['Major']
                row.append(column1)
                row.append(column2)
                row.append(column3)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = 'All ' + major_name.title() + ' Students'
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

#   4. Update automatically the number of Faculty members in a Department every time a Faculty Member is inserted into the database.
#   4. *insert_faculty <Employee_name> + <Department_name>
def insert_faculty(employee_name, department_name):
  try:
    conn = connect()
    rows = []
    headers = ["Faculty ID", "Name", "Department"]
    if conn:
        cursor = conn.cursor()
        employee = employee_name.lower()
        department = department_name.lower()
        query = """SET @departmentId = (SELECT department_id FROM Department WHERE department_name = %s);"""
        cursor.execute(query, department)
        query = """SET @length = LENGTH(%s);"""
        cursor.execute(query, employee)
        query = """SET @position = POSITION(" " in %s) + 1;"""
        cursor.execute(query, employee)
        query = """SET @lname = SUBSTRING(%s, @position, @length);"""
        cursor.execute(query, employee)
        query = """SET @initial = SUBSTR(%s,1,1);"""
        cursor.execute(query, employee)
        query = """SET @username = LOWER(CONCAT(@initial, REPLACE(@lname, ' ', '')));"""
        cursor.execute(query)
        query = """SET @position1 = POSITION(" " in %s) - 1"""
        cursor.execute(query, employee)
        query = """SET @newPassword = UPPER(CONCAT('PASSWORD_', SUBSTRING(%s, 1, @position1)));"""
        cursor.execute(query, employee)
        query = """SET @count = (SELECT COUNT(Account.email) FROM Account WHERE Account.email LIKE CONCAT('%', @username, '%'));"""
        cursor.execute(query)
        query = """SET @dob = (SELECT Employee.dob FROM Employee WHERE Employee.name = %s);"""
        cursor.execute(query, employee)
        query = """SET @num = IF(@count != 0, @count, 0);"""
        cursor.execute(query)
        query = """SET @username = CONCAT(@username, @num);"""
        cursor.execute(query)
        query = """INSERT INTO Account (email, phone, password, dob) VALUES (CONCAT(@username, '@sfsu.edu'), '###-###-####', @newPassword, @dob);"""
        cursor.execute(query)
        conn.commit()
        query = """SET @accountId = %s;"""
        accountId = int(cursor.lastrowid)
        cursor.execute(query, accountId)
        query = """INSERT INTO Faculty_Member (ssn, department, account, name, gender, age, salary) SELECT ssn, @departmentId, @accountId, name, gender, age, salary FROM Employee WHERE Employee.name = %s;"""
        cursor.execute(query, employee)
        conn.commit()
        query = """SELECT Faculty_Member.faculty_id AS "Faculty ID", Faculty_Member.name AS "Name", Department.department_name AS "Department", Faculty_Member.account AS "Account ID", Faculty_Member.gender AS "Gender", Faculty_Member.Age AS "Age", Faculty_Member.salary AS "Salary" FROM Faculty_Member JOIN Department ON Department.department_id = Faculty_Member.department WHERE Faculty_Member.name = %s;"""
        cursor.execute(query, employee)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData["Faculty ID"]
                column2 = queryData["Name"]
                column3 = queryData["Department"]
                row.append(column1)
                row.append(column2)
                row.append(column3)
                rows.append(row)
        output = format_data(headers, rows)
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

#   5. Create a procedure to find all the Visitors that are visiting any campus for a specific College (College name passed in as a parameter).
#   *college_visitors <College_name>
def college_visitors(college):
  try:
    conn = connect()
    rows = []
    headers = ['Name', 'Campus', 'Visiting Date']
    if conn:
        cursor = conn.cursor()
        query = """SELECT Visitor.name AS "Name", Campus.campus_name AS "Campus", Visiting_List.date_visiting AS "Visiting Date" FROM Visiting_List JOIN Visitor ON Visitor.visitor_id = Visiting_List.visitor JOIN Campus ON Visiting_List.campus = Campus.campus_id JOIN College ON College.college_id = Campus.college WHERE College.college_name = %s;"""
        cursor.execute(query, college)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData["Name"]
                column2 = queryData["Campus"]
                column3 = queryData["Visiting Date"]
                row.append(column1)
                row.append(column2)
                row.append(column3)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = college.title() + ' Visitors'
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

#   6. Create a procedure to find all the Courses that are being taught in Rooms in a given Building (Building name passed in as a parameter).
#   6. *courses_in_building <Building_name>
def courses_in_building(building_name):
  try:
    conn = connect()
    rows = []
    headers = ['Course', 'Room', 'College']
    if conn:
        cursor = conn.cursor()
        query = """SELECT Course.code AS "Course", CONCAT(Building.building_name, " ", Room.room_number) AS "Room", College.college_name AS "College" FROM Class
		JOIN Room ON Room.room_id = Class.room
		JOIN Course ON Course.course_id = Class.course
		JOIN Building ON Building.building_id = Room.building
		JOIN Campus ON Campus.campus_id = Building.campus
		JOIN College ON College.college_id = Campus.college
		WHERE Building.building_name = %s;"""
        building = building_name.lower()
        cursor.execute(query, building)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Course']
                column2 = queryData['Room']
                column3 = queryData['College']
                row.append(column1)
                row.append(column2)
                row.append(column3)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = 'Courses in ' + building_name.title() + ' building'
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

#   7. Create a function that returns the number of Students that are taking more than 3 courses during the current semester (full time students).
#   7. *full_time_students_count
def full_time_students_count():
  try:
    conn = connect()
    rows = []
    headers = ['Full Time Students']
    if conn:
        cursor = conn.cursor()
        query = """SELECT CONCAT(COUNT(*), " ", "Students") AS "Full Time Students" FROM (SELECT Enrollment.student AS StudentId, Student.name AS "Student",
(SELECT COUNT(Enrollment.student) FROM Enrollment WHERE Enrollment.student = StudentId) AS "Courses"
FROM Enrollment
JOIN Student ON Student.student_id = Enrollment.student
GROUP BY Enrollment.student
HAVING COUNT(*) > 3) AS result;"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Full Time Students']
                row.append(column1)
                rows.append(row)
        output = format_data(headers, rows)
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

#   8. Update automatically the type of Teacher that the Faculty member is after an insert into the list of Teachers. If they are a Researcher that has published at least one paper, assign them as a Professor. If not, assign them as a Lecturer.
#   8. *assign_teacher_to_faculty <ssn>
def assign_teacher_to_faculty(ssn):
  try:
    conn = connect()
    rows = []
    headers = ['SSN', 'Name', 'Department']
    if conn:
        cursor = conn.cursor()
        query = """SET @isTeacher = (SELECT COUNT(*) FROM Teacher JOIN Faculty_Member ON Faculty_Member.faculty_id = Teacher.faculty WHERE Faculty_Member.ssn = %s);"""
        cursor.execute(query, ssn)
        query = """INSERT INTO Teacher (faculty) SELECT Faculty_Member.faculty_id FROM Faculty_Member WHERE Faculty_Member.ssn = %s  AND @isTeacher = 0;"""
        cursor.execute(query, ssn)
        conn.commit()
        # Searches if newly inserted Teacher is a Researcher with over 1 paper published.
        # paperCount is 0 if Teacher is not listed as a Researcher or if they are a Researcher with no recorded published papers.
        query = """SET @paperCount = (SELECT COUNT(*) FROM Publishing JOIN Researcher ON Researcher.researcher_id = Publishing.researcher JOIN Faculty_Member ON Faculty_Member.faculty_id = Researcher.faculty WHERE Faculty_Member.ssn = %s);"""
        cursor.execute(query, ssn)
        # Checks for existing entries in Professor/Lecturer Tables to avoid duplicate entries. Used as condition to do inserts.
        query = """SET @isProfessor = (SELECT COUNT(*) FROM Professor JOIN Teacher ON Teacher.teacher_id = Professor.teacher JOIN Faculty_Member ON Faculty_Member.faculty_id = Teacher.faculty WHERE Faculty_Member.ssn = %s);"""
        cursor.execute(query, ssn)
        query = """SET @isLecturer = (SELECT COUNT(*) FROM Lecturer JOIN Teacher ON Teacher.teacher_id = Lecturer.teacher JOIN Faculty_Member ON Faculty_Member.faculty_id = Teacher.faculty WHERE Faculty_Member.ssn = %s);"""
        cursor.execute(query, ssn)
        # If the newly inserted Teacher has a published paper count (paperCount) of 1 or more, they are inserted as a Professor.
        query = """INSERT INTO Professor (teacher) SELECT Teacher.teacher_id FROM Teacher JOIN Faculty_Member ON Faculty_Member.faculty_id = Teacher.faculty WHERE Faculty_Member.ssn = %s AND @paperCount > 0  AND @isProfessor = 0;"""
        cursor.execute(query, ssn)
        conn.commit()
        # If the newly inserted Teacher has a published paper count (paperCount) of 0, they are inserted as a Lecturer.
        query = """INSERT INTO Lecturer (teacher) SELECT Teacher.teacher_id FROM Teacher JOIN Faculty_Member ON Faculty_Member.faculty_id = Teacher.faculty WHERE Faculty_Member.ssn = %s AND @paperCount = 0  AND @isLecturer = 0;"""
        cursor.execute(query, ssn)
        conn.commit()
        # If newly inserted Teacher is a Professor, display new Professor record.
        query = """SELECT Employee.ssn AS "SSN", Faculty_Member.name AS "Name", Department.department_name AS "Department" FROM Professor JOIN Teacher ON Teacher.teacher_id = Professor.teacher JOIN Faculty_Member ON Faculty_Member.faculty_id = Teacher.faculty JOIN Employee ON Employee.ssn = Faculty_Member.ssn JOIN Department ON Department.department_id = Faculty_Member.department WHERE Faculty_Member.ssn = %s;"""
        cursor.execute(query, ssn)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['SSN']
                column2 = queryData['Name']
                column3 = queryData['Department']
                row.append(column1)
                row.append(column2)
                row.append(column3)
                rows.append(row)
                output = format_data(headers, rows)
                output.title = 'This Teacher is a Professor'
                conn.close()
                formatted = "`" + output.get_string() + "`"
                return formatted
        else:
          # Else if it isn't a Professor, if newly inserted Teacher is a Lecturer, display new Lecturer record.
          query = """SELECT Employee.ssn AS "SSN", Faculty_Member.name AS "Name", Department.department_name AS "Department" FROM Lecturer JOIN Teacher ON Teacher.teacher_id = Lecturer.teacher JOIN Faculty_Member ON Faculty_Member.faculty_id = Teacher.faculty JOIN Employee ON Employee.ssn = Faculty_Member.ssn JOIN Department ON Department.department_id = Faculty_Member.department WHERE Faculty_Member.ssn = %s;"""
          cursor.execute(query, ssn)
          data = cursor.fetchall()
          if data:
              for queryData in data:
                  row = []
                  column1 = queryData['SSN']
                  column2 = queryData['Name']
                  column3 = queryData['Department']
                  row.append(column1)
                  row.append(column2)
                  row.append(column3)
                  rows.append(row)
                  output = format_data(headers, rows)
                  output.title = 'This Teacher is a Lecturer'
                  conn.close()
                  formatted = "`" + output.get_string() + "`"
                  return formatted
          else:
            conn.close()
            return 'Already assigned this SSN to a Teacher role!'
  except Exception as error:
    print(error)
    output = -1
    return output

#   9. Find the number of college campuses that are located in San Francisco.
#   9. *sf_colleges
def sf_colleges():
  try:
    conn = connect()
    rows = []
    headers = ['Campus ID', 'College', 'Location']
    if conn:
        cursor = conn.cursor()
        query = """SELECT Campus.campus_id AS "Campus ID", College.college_name AS "College", CONCAT(Address.city, ", ", Address.state) AS "Location" FROM Campus JOIN College ON College.college_id = Campus.college JOIN Address ON Address.address_id = Campus.address WHERE Address.city = "San Francisco" ORDER BY College.college_name;"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Campus ID']
                column2 = queryData['College']
                column3 = queryData['Location']
                row.append(column1)
                row.append(column2)
                row.append(column3)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = 'College campuses in San Francisco'
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

#   10. For each course code (i.e. CSC675), find the number of teachers that are currently teaching that course.
#   10. *num_course_teachers
def num_course_teachers():
  try:
    conn = connect()
    rows = []
    headers = ['Course', 'Teachers']
    if conn:
        cursor = conn.cursor()
        query = """SELECT cid AS "Course", CONCAT(teacherCount, " ", IF(teacherCount > 1, "Teachers", "Teacher")) AS "Teachers" FROM  (SELECT DISTINCT Course.code AS cid, (SELECT COUNT(*) FROM Teaching_Courses JOIN Course ON Course.course_id = Teaching_Courses.course WHERE Course.code = cid) AS teacherCount FROM Teaching_Courses JOIN Course ON Course.course_id = Teaching_Courses.course JOIN Teacher ON Teacher.teacher_id = Teaching_Courses.teacher JOIN Faculty_Member ON Faculty_Member.faculty_id = Teacher.faculty) AS subquery ORDER BY cid;"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Course']
                column2 = queryData['Teachers']
                row.append(column1)
                row.append(column2)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = '# of Teachers teaching per Course'
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

#   11. Create a function that returns the average salary of Graders.
#   11. *avg_grader_salary
def avg_grader_salary():
  try:
    conn = connect()
    rows = []
    headers = ['Average Grader Salary']
    if conn:
        cursor = conn.cursor()
        query = """SELECT CONCAT("$", CAST(AVG (course_salary) AS DECIMAL(10,2))) AS "Average Grader Salary" FROM Grader;"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Average Grader Salary']
                row.append(column1)
                rows.append(row)
        output = format_data(headers, rows)
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

#   12. For each Supervisor, find the number of Employees that they supervise.
#   12. *supervisors
def supervisors():
  try:
    conn = connect()
    rows = []
    headers = ['Supervisor', '# of Employees']
    if conn:
        cursor = conn.cursor()
        query = """SELECT e_name AS "Supervisor", CONCAT(e_supervised, " ", IF(e_supervised > 1, "Employees", "Employee")) AS "# of Employees" FROM (SELECT DISTINCT Employee.name AS e_name, Employee.ssn AS e_ssn, (SELECT COUNT(*) FROM Supervisors WHERE Supervisors.supervisor = e_ssn) AS e_supervised FROM Supervisors JOIN Employee ON Employee.ssn = Supervisors.supervisor WHERE Employee.is_supervisor = 1) AS subquery ORDER BY e_name;"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Supervisor']
                column2 = queryData['# of Employees']
                row.append(column1)
                row.append(column2)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = '# of Employees supervised by Supervisors'
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

#   13. Display the average salaries of Lecturers and Professors.
#   13. *avg_teacher_salary
def avg_teacher_salary():
  try:
    conn = connect()
    rows = []
    headers = ['Average Teacher Salary']
    if conn:
        cursor = conn.cursor()
        query = """SELECT CONCAT("$",FORMAT(CAST(AVG(Faculty_Member.salary) AS DECIMAL(10,2)), 'C')) AS "Average Teacher Salary" FROM Teacher JOIN Faculty_Member ON Faculty_Member.faculty_id = Teacher.faculty;"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Average Teacher Salary']
                row.append(column1)
                rows.append(row)
        output = format_data(headers, rows)
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

#   14. Find the number of students that have been assigned two majors or more.
#   14. *multi_major_students
def multi_major_students():
  try:
    conn = connect()
    rows = []
    headers = ['Student ID', 'Name', '# Majors']
    if conn:
        cursor = conn.cursor()
        query = """SELECT s_id AS "Student ID", s_name AS "Name", m_count AS "# Majors" FROM (SELECT DISTINCT Student.name AS s_name, Student.student_id AS s_id,  (SELECT COUNT(*) FROM Student_Major WHERE Student_Major.student = s_id) AS m_count
FROM Student_Major JOIN Student ON Student.student_id = Student_Major.student JOIN College_Major ON College_Major.college_major_id = Student_Major.college_major JOIN Major ON Major.major_id = College_Major.major
ORDER BY Student.name ASC) AS subquery WHERE m_count > 1;"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Student ID']
                column2 = queryData['Name']
                column3 = queryData['# Majors']
                row.append(column1)
                row.append(column2)
                row.append(column3)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = 'Multi Major Students'
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

#   15. For each college campus, find the number of classes that are offered.
#   15. *num_campus_classes
def num_campus_classes():
  try:
    conn = connect()
    rows = []
    headers = ['Course', 'Campus', 'College']
    if conn:
        cursor = conn.cursor()
        query = """SELECT Course.code AS "Course", Campus.campus_name AS "Campus", College.college_name AS "College" FROM Class JOIN Course ON Course.course_id = Class.course JOIN Room ON Room.room_id = Class.room JOIN Building ON Building.building_id = Room.building JOIN Campus ON Campus.campus_id = Building.campus JOIN College ON College.college_id = Campus.college ORDER BY College.college_name ASC;"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Course']
                column2 = queryData['Campus']
                column3 = queryData['College']
                row.append(column1)
                row.append(column2)
                row.append(column3)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = 'Classes offered at College Campuses'
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

#   16. Find the number of stores that are assigned to a specific College.
#   16. *college_stores <College_name>
def college_stores(College_name):
  try:
    conn = connect()
    rows = []
    headers = ['Store', 'Campus']
    if conn:
        cursor = conn.cursor()
        query = """SELECT Store.store_name AS "Store", Campus.campus_name AS "Campus" FROM Campus JOIN Store ON Store.campus = Campus.campus_id JOIN College ON College.college_id = Campus.college WHERE College.college_name = %s ORDER BY Campus.campus_name;"""
        cursor.execute(query, College_name.lower())
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Store']
                column2 = queryData['Campus']
                row.append(column1)
                row.append(column2)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = College_name.title() + ' Stores'
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

#   17. Create a procedure that returns the number of Graders for a particular course. (Course code passed in as parameter)
#   17. *course_graders <Course_code>
def course_graders(course_code):
  try:
    conn = connect()
    rows = []
    headers = ['Student', 'Semester']
    if conn:
        cursor = conn.cursor()
        query = """SELECT Student.name AS "Student", CONCAT(Grader.semester, " ", Grader.year) AS "Semester" FROM Grader JOIN Student ON Student.student_id = Grader.student JOIN Course ON Course.course_id = Grader.course WHERE Course.code = %s ORDER BY Grader.year DESC;"""
        cursor.execute(query, course_code.upper())
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Student']
                column2 = queryData['Semester']
                row.append(column1)
                row.append(column2)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = 'Number of ' + course_code.upper() + ' Graders'
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

#   18. Find the number of courses this semester that have less than 30 Students currently enrolled in it.
#   18. *available_courses
def available_courses():
  try:
    conn = connect()
    rows = []
    headers = ['Course', 'Title', 'Open Seats']
    if conn:
        cursor = conn.cursor()
        query = """SELECT c_code AS "Course", c_title AS "Title", (30 - s_count) AS "Open Seats" FROM (SELECT DISTINCT Course.code AS c_code, Course.title AS c_title, (SELECT COUNT(*) FROM Enrollment JOIN Course ON Course.course_id = Enrollment.course WHERE Course.code = c_code) AS s_count FROM Enrollment JOIN Course ON Course.course_id = Enrollment.course) AS subquery WHERE s_count < 30;"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Course']
                column2 = queryData['Title']
                column3 = queryData['Open Seats']
                row.append(column1)
                row.append(column2)
                row.append(column3)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = 'Spring 2022 Available Courses'
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

# SUPPLEMENTAL COMMANDS

# View all Colleges and their Campuses
# *view_college_campus
def view_college_campus():
  try:
    conn = connect()
    rows = []
    headers = ['']
    if conn:
        cursor = conn.cursor()
        query = """"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['']
                row.append(column1)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = ''
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

# Views all Buildings and relevant info
# *view_buildings
def view_buildings():
  try:
    conn = connect()
    rows = []
    headers = ['']
    if conn:
        cursor = conn.cursor()
        query = """"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['']
                row.append(column1)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = ''
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

# Views all Departments and relevant info
# *view_departments
def view_departments():
  try:
    conn = connect()
    rows = []
    headers = ['']
    if conn:
        cursor = conn.cursor()
        query = """"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['']
                row.append(column1)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = ''
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

# Views all Employees and relevant info
# *view_employees
def view_employees():
  try:
    conn = connect()
    rows = []
    headers = ['']
    if conn:
        cursor = conn.cursor()
        query = """"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['']
                row.append(column1)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = ''
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

# Views all Faculty Members and relevant info
# *view_faculty
def view_faculty():
  try:
    conn = connect()
    rows = []
    headers = ['']
    if conn:
        cursor = conn.cursor()
        query = """"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['']
                row.append(column1)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = ''
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

# Views all Courses and relevant info
# *view_courses
def view_courses():
  try:
    conn = connect()
    rows = []
    headers = ['']
    if conn:
        cursor = conn.cursor()
        query = """"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['']
                row.append(column1)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = ''
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

# Views all Students and relevant info
# *view_students
def view_students():
  try:
    conn = connect()
    rows = []
    headers = ['']
    if conn:
        cursor = conn.cursor()
        query = """"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['']
                row.append(column1)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = ''
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output

# Views all Majors and relevant info
# *view_majors
def view_majors():
  try:
    conn = connect()
    rows = []
    headers = ['']
    if conn:
        cursor = conn.cursor()
        query = """"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['']
                row.append(column1)
                rows.append(row)
        output = format_data(headers, rows)
        output.title = ''
        conn.close()
        formatted = "`" + output.get_string() + "`"
        return formatted
  except Exception as error:
    print(error)
    output = -1
    return output