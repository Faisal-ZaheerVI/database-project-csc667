-- Script name: inserts.sql
-- Author:      Faisal Zaheer
-- Purpose:     Inserting sample data to test the integrity of the College Management Database System.

SET SQL_SAFE_UPDATES = 0; 

-- the database used to insert the data into.
USE collegemanagementdb;

-- College table inserts
INSERT INTO College (college_id, college_name) VALUES (1, "San Francisco State University"), 
(2, "San Jose State University"), (3, "UC San Francisco");

-- Department table inserts
INSERT INTO Department (college, department_name) VALUES (1, "Computer Science"), 
(1, "Mathematics"), (1, "Science"), (1, "Engineering"), (2, "Computer Science"),  
(2, "Mathematics"), (2, "Science"), (2, "Engineering"),
(3, "Computer Science"),  (3, "Mathematics"), (3, "Science"), (3, "Engineering");

-- Employee table inserts
INSERT INTO Employee (ssn, is_supervisor, name, gender, age, salary, dob) VALUES ("123-45-6789", 0, "Joe Schmuck", "MALE", 40, 100000, '1982-01-16'),
("223-45-6789", 1, "Alice Supervisor", "FEMALE", 30, 120000, '1992-04-01'), ("323-45-6789", 0, "Jane Schmuck", "FEMALE", 35, 110000, '1987-02-18');
INSERT INTO Employee (ssn, is_supervisor, name, gender, age, salary, dob) VALUES ("423-45-6789", 0, "Robert Nofaculty", "MALE", 45, 100000, '1977-01-18'), 
("523-45-6789", 0, "Brad Lecturer", "MALE", 25, 90000, '1997-03-18'), ("623-45-6789", 0, "Lisa Researcher", "FEMALE", 29, 80000, '1992-12-12'); 
INSERT INTO Employee (ssn, is_supervisor, name, gender, age, salary, dob) VALUES ("723-45-6789", 1, "Dragutin Researcher", "MALE", 50, 120000, '1962-02-12'),
("823-45-6789", 0, "Jozo Researcher", "MALE", 60, 120000, '1952-01-01'), ("923-45-6789", 0, "Jose Professor", "MALE", 40, 110000, '1972-04-02');
INSERT INTO Employee (ssn, is_supervisor, name, gender, age, salary, dob) VALUES ("133-45-6789", 0, "Ilmi Professor", "FEMALE", 30, 120000, '1982-02-28'), 
("233-45-6789", 1, "Isabel Professor", "FEMALE", 31, 100000, '1981-03-16'), ("333-45-6789", 0, "Vera Lecturer", "FEMALE", 35, 80000, '1977-01-10'); 
INSERT INTO Employee (ssn, is_supervisor, name, gender, age, salary, dob) VALUES ("433-45-6789", 0, "ShahRukh Lecturer", "MALE", 40, 80000, '1972-02-04');

-- Account table inserts
INSERT INTO Account (email, phone, password, dob) VALUES ("jschmuck@sfsu.edu", "415-123-4567", "PASSWORD_JOE", '1982-01-16'),
("asupervisor@sfsu.edu", "415-223-4567", "PASSWORD_ALICE", '1992-04-01'), ("jschmuck1@sfsu.edu", "415-323-4567", "PASSWORD_JANE", '1987-02-18'),
("blecturer@sfsu.edu", "415-523-4567", "PASSWORD_BRAD", '1997-03-18'), ("lresearcher@sfsu.edu", "415-623-4567", "PASSWORD_LISA", '1992-12-12'),
("fzaheer@mail.sfsu.edu", "415-187-0949", "PASSWORD_FAISAL", '1999-06-27'), ("mstudent@mail.sfsu.edu", "415-756-7059", "PASSWORD_MARTIN", '2001-10-20'),
("sstudent@mail.sfsu.edu", "415-756-7060", "PASSWORD_SARAH", '1998-01-18'), ("dresearcher@sfsu.edu", "415-723-4567", "PASSWORD_DRAGUTIN", '1962-2-12'),
("jresearcher@sfsu.edu", "415-823-4567", "PASSWORD_JOZO", '1952-1-1'), ("jprofessor@sfsu.edu", "415-923-4567", "PASSWORD_JOSE", '1972-4-2'),
("iprofessor@sfsu.edu", "415-133-4567", "PASSWORD_ILMI", '1982-2-28'), ("iprofessor1@sfsu.edu", "415-233-4567", "PASSWORD_ISABEL", '1981-3-16'),
("vlecturer@sfsu.edu", "415-333-4567", "PASSWORD_VERA", '1977-1-10'), ("srlecturer@sfsu.edu", "415-433-4567", "PASSWORD_SHAHRUKH", '1972-02-04');

-- Faculty_Member table inserts
INSERT INTO Faculty_Member (ssn, department, account, name, gender, age, salary) VALUES ("123-45-6789", 1, 1, "Joe Schmuck", "MALE", 40, 100000),
("223-45-6789", 1, 2, "Alice Supervisor", "FEMALE", 30, 120000), ("323-45-6789", 2, 3,"Jane Schmuck", "FEMALE", 35, 110000),
("523-45-6789", 1, 4, "Brad Lecturer", "MALE", 25, 90000), ("623-45-6789", 2, 5, "Lisa Researcher", "FEMALE", 29, 80000),
("723-45-6789", 1, 9, "Dragutin Researcher", "MALE", 50, 120000), ("823-45-6789", 1, 10, "Jozo Researcher", "MALE", 60, 120000),
("923-45-6789", 1, 11, "Jose Professor", "MALE", 40, 110000), ("133-45-6789", 1, 12, "Ilmi Professor", "FEMALE", 30, 120000),
("233-45-6789", 2, 13, "Isabel Professor", "FEMALE", 31, 100000), ("333-45-6789", 2, 14, "Vera Lecturer", "FEMALE", 30, 80000),
("433-45-6789", 1, 15, "ShahRukh Lecturer", "MALE", 40, 80000);

-- Teacher table inserts
INSERT INTO Teacher (faculty) VALUES (4), (8), (9), (10), (11), (12);

-- Course table inserts
INSERT INTO Course (code, section, title, description) VALUES ("CSC210", 1, "Introduction to Computer Programming", "Beginner CSC class."),
("CSC210", 2, "Introduction to Computer Programming", "Beginner CSC class."), ("CSC220", 1, "Data Structures", "Difficult CSC class."),
("CSC230", 1, "Discrete Mathematical Structures", "Aka the Math class."), ("CSC675", 1, "Introduction to Database Systems", "Helpful CSC course."),
("MATH226", 1, "Calculus 1", "Entry Calculus course."), ("MATH227", 1, "Calculus 2", "Intermediate Calculus course."),
("PHYS220", 1, "General Physics with Calculus I", "Intermediate Physics course."), ("CSC631", 1, "Multiplayer Game Development", "Fun CSC course."),
("CSC642", 1, "Human Computer Interaction", "UI/UX CSC course.");

-- Lab table inserts
INSERT INTO Lab (course, code, title, description) VALUES (1, "CSC211", "Introduction to Software Lab", "Beginner CSC Lab."),
(2, "CSC211", "Introduction to Software Lab", "Beginner CSC Lab."), (8, "PHYS222", "General Physics with Calculus I Laboratory", "Intermediate Physics Lab.");

-- Student table inserts (student_id not auto increment)
INSERT INTO Student (student_id, account, name, age, gender) VALUES (917567058, 6, "Faisal Zaheer", 22, "MALE"),
(917567059, 7, "Martin Student", 20, "MALE"), (917567060, 8, "Sarah Student", 25, "FEMALE");

-- Researcher table inserts
INSERT INTO Researcher (faculty) VALUES (5), (6), (7);

-- Professor table inserts
INSERT INTO Professor (teacher) VALUES (2), (3), (4);

-- Lecturer table inserts
INSERT INTO Lecturer (teacher) VALUES (1), (5), (6);

-- Paper table inserts
INSERT INTO Paper (title, conference) VALUES ("How to Pass CSC675", "CSC Conference"),
("Why Joining Clubs and Orgs are Important", "IEEE Conference"), ("The Best Paper You'll Ever Read", "Professional Conference"),
("Modern Agile Practices in the Classroom", "Software Engineering Conference");

-- Payment table inserts
INSERT INTO Payment (amount, student) VALUES (3683, 917567058), (100, 917567058), (453, 917567058),
(122, 917567059), (2965, 917567058), (1000, 917567060);

-- Credit_Card table inserts (make card_number not primary/unique key?? -> multiple payments can be made with multiple credit cards?)
INSERT INTO Credit_Card (card_number, payment, exp_date, ccv, bank) VALUES ("1122556644339988", 1, '2024-02-01', 123, "Gator Bank"),
("1122556644339988", 2, '2024-02-01', 123, "Gator Bank"), ("1122556644339988", 3, '2024-02-01', 123, "Gator Bank");

-- Bank_Account table inserts
INSERT INTO Bank_Account (acct_number, payment, routing, bank) VALUES ("3142567890", 4, "321654987", "Capital Two"),
("5665987822", 5, "977983381", "Bank of Americas"), ("123498765445", 6, "987612345", "Chased");

-- Address table inserts
INSERT INTO Address (country, state, city, street, zipcode) VALUES ("USA", "CA", "San Francisco", "100 Taylor St.", 94102),
("USA", "CA", "San Francisco", "200 Lombard St.", 94103), ("USA", "CA", "San Francisco", "300 Haight St.", 94133),
("USA", "CA", "San Francisco", "400 Castro St.", 94108), ("USA", "CA", "San Francisco", "500 Market St.", 94109),
("USA", "CA", "San Francisco", "600 Valencia St.", 94129), ("USA", "CA", "San Francisco", "700 Embarcadero St.", 94123),
("USA", "CA", "Daly City", "800 Grant Ave.", 94114), ("USA", "CA", "Daly City", "900 Student St.", 94121),
("USA", "CA", "Daly City", "150 Student Street", 94122), ("USA", "CA", "Daly City", "250 Student St.", 94122),
("USA", "CA", "San Francisco", "1600 Holloway Ave.", 94132), ("USA", "CA", "San Jose", "1000 Campus Ave.", 94088),
("USA", "CA", "San Francisco", "500 City Campus Ave.", 94103), ("USA", "CA", "San Francisco", "2600 Holloway Ave.", 94132),
("USA", "CA", "San Francisco", "786 Jose St.", 94133), ("USA", "CA", "Berkeley", "123 Ilmi Ave.", 94101),
("USA", "CA", "Oakland", "342 Isabel St.", 94122), ("USA", "CA", "Richmond", "620 Vera Ave.", 94201),
("USA", "CA", "Richmond", "950 Rukh Ave.", 94202);

-- Major table inserts
INSERT INTO Major (major_name) VALUES ("Computer Science"), ("Computer Engineering"), ("Mathematics"),
("Biology"), ("Psycology"), ("Business");

-- Minor table inserts
INSERT INTO Minor (minor_name) VALUES ("Business"), ("Computer Science"), ("French"), 
("Humanities"), ("Linguistics"), ("Psycology");

-- Campus table inserts
INSERT INTO Campus (college, address, campus_name) VALUES (1, 12, "SFSU Main Campus"), (2, 13, "SJSU Main Campus"), 
(3, 14, "UCSF Main Campus"), (1, 15, "SFSU Downtown Campus");

-- Building table inserts
INSERT INTO Building (campus, building_name) VALUES (1, "Thornton"), (1, "Hensill Hall"),
(1, "HSS"), (1, "Burk Hall"), (1, "Science"), (1, "Humanities"), 
(2, "SAN JOSE Math Bldg"), (2, "SAN JOSE Business Bldg"), (2, "SAN JOSE Creative Arts Bldg"),
(3, "USSF Engineering"), (3, "USSF Mathematics"), (3, "USSF Arts"), (3, "UCSF Business"),
(4, "SFSU Smaller Campus Bldg");

-- Room table inserts
INSERT INTO Room (building, room_number) VALUES (1, 422), (1, 801), (1, 802), (1, 803),
(2, 333), (2, 433), (2, 533), 
(3, 101), (3, 202), (3, 303);

-- Office table inserts (room can be null)
INSERT INTO Office (room, faculty) VALUES (7, 8), (2,6), (3,7), (null,9);

-- Class table inserts (room can be null)
INSERT INTO Class (room, course) VALUES (7, 5), (1,3), (6, 8), (null, 1), (null, 2);

-- Visitor table inserts
INSERT INTO Visitor (name) VALUES ("Harry Visitor"), ("Hermione Visitor"), ("Ron Visitor"),
("Draco Visitor"), ("Lucius Visitor"), ("Hagrid Visitor");

-- Store table inserts (campus can be null)
INSERT INTO Store (campus, store_name) VALUES (1, "SFSU Bookstore"), (1, "GatorTrade"),
(2, "San Jose Supplies Hub"), (3, "UCSF Store"), (4, "SFSU Supplies");

-- Product table inserts (store can be null)
INSERT INTO Product (store, product_name, price, is_online) VALUES (1, "Lab coat", 20, 0),
(1, "PHYS220 Workbook", 10, 0), (null, "Gator Grad Outfit", 100, 1), (2, "Gator hoodie", 40, 1),
(3, "SJSU pride shirt", 15, 1), (4, "UCSF pride shirt", 15, 1);

-- Wellness_center table inserts
INSERT INTO Wellness_Center (wellness_name) VALUES ("Mashouf Wellness Center"),
("Gator Wellness Center"), ("SAN JOSE Wellness Center"), ("UCSF Wellness Center");

-- Janitor table inserts
INSERT INTO Janitor (janitor_name) VALUES ("Terry Janitor"),
("Maddy Janitor"), ("Zachary Janitor"), ("Gator Janitor");

-- Activities table inserts
INSERT INTO Activities (campus, wellness, activity_name) VALUES (1, 1, "Yoga Training"),
(1, 2, "Running away from Responsibilities!"), (2, 3, "San Jose Practice Running"),
(3, 4, "UCSF Stretching the Stress Away");

-- Assigned_Cleaning table inserts
INSERT INTO Assigned_Cleaning (janitor, campus) VALUES (1, 1), (2, 2), (3, 3), (4, 1);

-- College_Major table inserts
INSERT INTO College_Major (major, college) VALUES (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1),
(3, 2), (4, 2), (5, 2), (6, 2),
(1, 3), (4, 3), (6, 3);

-- College_Minor table inserts
INSERT INTO College_Minor (minor, college) VALUES (1, 1), (2, 1), (6, 1),
(1, 2), (3, 2), (4, 2), (6, 2),
(1, 3), (2, 3), (3, 3), (4, 3), (5, 3), (6, 3);

-- Employee_Address table inserts
INSERT INTO Employee_Address (address, employee) VALUES (1, "123-45-6789"),
(2, "223-45-6789"), (3, "323-45-6789"), (4, "423-45-6789"), (5, "523-45-6789"), 
(6, "623-45-6789"), (7, "723-45-6789"), (8, "823-45-6789"), (16, "923-45-6789"),
(17, "133-45-6789"), (18, "233-45-6789"), (19, "333-45-6789"), (20, "433-45-6789");

-- Enrollment table inserts
INSERT INTO Enrollment (student, course, semester, year, section) VALUES (917567058, 5, "SPRING", 2022, 1),
(917567058, 9, "SPRING", 2022, 1), (917567058, 10, "SPRING", 2022, 1), (917567059, 4, "SPRING", 2022, 1),
(917567059, 5, "SPRING", 2022, 1), (917567059, 7, "SPRING", 2022, 1), (917567059, 8, "SPRING", 2022, 1),
(917567060, 4, "SPRING", 2022, 1), (917567060, 7, "SPRING", 2022, 1);

-- Grader table inserts
INSERT INTO Grader (student, course, semester, year, section, course_salary) VALUES (917567058, 1, "FALL", 2021, 1, 1000),
(917567058, 3, "SPRING", 2022, 1, 1200), (917567059, 6, "SPRING", 2022, 1, 900);

-- Publishing table inserts
INSERT INTO Publishing (paper, researcher) VALUES (1, 1), (2, 2), (3, 3), (4, 2);

-- Student_Address table inserts
INSERT INTO Student_Address (address, student) VALUES (9, 917567058),
(10, 917567059), (11, 917567060);

-- Student_Major table inserts
INSERT INTO Student_Major (college_major, student) VALUES (1, 917567058),
(3, 917567059), (13, 917567060), (2, 917567058), (3, 917567058), (6, 917567059);

-- Student_Minor table inserts
INSERT INTO Student_Minor (college_minor, student) VALUES (1, 917567058),
(2, 917567059), (9, 917567060);

-- Supervisors table inserts (both are from employee_id, employee is PK/FK)
INSERT INTO Supervisors (employee, supervisor) VALUES ("623-45-6789", "723-45-6789"),
("823-45-6789", "723-45-6789"), ("123-45-6789", "223-45-6789"), ("333-45-6789", "233-45-6789");

-- Teaching_Courses table inserts
INSERT INTO Teaching_Courses (course, teacher) VALUES (5, 2), (1, 1), (2, 1), (9, 3),
(6, 4), (7, 5), (10,6);

-- Visiting_List table inserts (date_visiting is DATETIME)
INSERT INTO Visiting_List (visitor, campus, date_visiting) VALUES (1, 1, '2022-01-18 12:30:00'),
(2, 1, '2022-01-18 12:30:00'), (3, 1, '2022-01-19 12:30:00'), (4, 2, '2022-02-01 12:30:00'),
(5, 2, '2022-04-18 12:30:00'), (6, 3, '2022-1-18 01:30:00');
