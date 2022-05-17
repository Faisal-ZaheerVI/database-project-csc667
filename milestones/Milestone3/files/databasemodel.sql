-- Script name: databasemodel.sql
-- Author:      Faisal Zaheer
-- Purpose:     Creating the College Management Database System schema and its tables.

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SET SQL_SAFE_UPDATES = 0; 
-- -----------------------------------------------------
-- Schema CollegeManagementDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `CollegeManagementDB`;
CREATE SCHEMA IF NOT EXISTS `CollegeManagementDB` DEFAULT CHARACTER SET utf8 ;
USE `CollegeManagementDB` ;

-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`College`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`College` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`College` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Department` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `college` INT NOT NULL,
  `department_name` VARCHAR(45) NOT NULL,
  `faculty_count` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`department_id`),
  INDEX `FK_college_department_idx` (`college` ASC) VISIBLE,
  CONSTRAINT `FK_college_department`
    FOREIGN KEY (`college`)
    REFERENCES `CollegeManagementDB`.`College` (`college_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Employee` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Employee` (
  `ssn` VARCHAR(11) NOT NULL,
  `is_supervisor` BIT(1) NOT NULL DEFAULT 0,
  `name` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `salary` INT NOT NULL,
  `dob` DATE NOT NULL,
  PRIMARY KEY (`ssn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Account` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Account` (
  `account_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(12) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `dob` DATE NOT NULL,
  PRIMARY KEY (`account_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Faculty_Member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Faculty_Member` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Faculty_Member` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `ssn` VARCHAR(11) NOT NULL,
  `department` INT NOT NULL,
  `account` INT NULL,
  `name` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `age` TINYINT(3) NOT NULL,
  `salary` INT NOT NULL,
  PRIMARY KEY (`faculty_id`),
  INDEX `FK_employee_facultymember_idx` (`ssn` ASC) VISIBLE,
  INDEX `FK_department_facultymember_idx` (`department` ASC) VISIBLE,
  INDEX `FK_account_facultymember_idx` (`account` ASC) VISIBLE,
  CONSTRAINT `FK_employee_facultymember`
    FOREIGN KEY (`ssn`)
    REFERENCES `CollegeManagementDB`.`Employee` (`ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_department_facultymember`
    FOREIGN KEY (`department`)
    REFERENCES `CollegeManagementDB`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_account_facultymember`
    FOREIGN KEY (`account`)
    REFERENCES `CollegeManagementDB`.`Account` (`account_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Teacher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Teacher` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Teacher` (
  `teacher_id` INT NOT NULL AUTO_INCREMENT,
  `faculty` INT NOT NULL,
  PRIMARY KEY (`teacher_id`),
  INDEX `FK_faculty_teacher_idx` (`faculty` ASC) VISIBLE,
  CONSTRAINT `FK_faculty_teacher`
    FOREIGN KEY (`faculty`)
    REFERENCES `CollegeManagementDB`.`Faculty_Member` (`faculty_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Course` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(8) NOT NULL,
  `section` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`course_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Lab`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Lab` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Lab` (
  `lab_id` INT NOT NULL AUTO_INCREMENT,
  `course` INT NOT NULL,
  `code` VARCHAR(8) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`lab_id`),
  INDEX `FK_course_lab_idx` (`course` ASC) VISIBLE,
  CONSTRAINT `FK_course_lab`
    FOREIGN KEY (`course`)
    REFERENCES `CollegeManagementDB`.`Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Student` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Student` (
  `student_id` INT NOT NULL,
  `account` INT NULL,
  `name` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`student_id`),
  INDEX `FK_account_student_idx` (`account` ASC) VISIBLE,
  CONSTRAINT `FK_account_student`
    FOREIGN KEY (`account`)
    REFERENCES `CollegeManagementDB`.`Account` (`account_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Researcher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Researcher` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Researcher` (
  `researcher_id` INT NOT NULL AUTO_INCREMENT,
  `faculty` INT NULL,
  PRIMARY KEY (`researcher_id`),
  INDEX `FK_faculty_researcher_idx` (`faculty` ASC) VISIBLE,
  CONSTRAINT `FK_faculty_researcher`
    FOREIGN KEY (`faculty`)
    REFERENCES `CollegeManagementDB`.`Faculty_Member` (`faculty_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Professor` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Professor` (
  `professor_id` INT NOT NULL AUTO_INCREMENT,
  `teacher` INT NOT NULL,
  PRIMARY KEY (`professor_id`),
  INDEX `FK_teacher_professor_idx` (`teacher` ASC) VISIBLE,
  CONSTRAINT `FK_teacher_professor`
    FOREIGN KEY (`teacher`)
    REFERENCES `CollegeManagementDB`.`Teacher` (`teacher_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Lecturer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Lecturer` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Lecturer` (
  `lecturer_id` INT NOT NULL AUTO_INCREMENT,
  `teacher` INT NOT NULL,
  PRIMARY KEY (`lecturer_id`),
  INDEX `FK_teacher_lecturer_idx` (`teacher` ASC) VISIBLE,
  CONSTRAINT `FK_teacher_lecturer`
    FOREIGN KEY (`teacher`)
    REFERENCES `CollegeManagementDB`.`Teacher` (`teacher_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Paper`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Paper` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Paper` (
  `paper_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `conference` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`paper_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Payment` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `amount` INT NOT NULL,
  `student` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `FK_student_payment_idx` (`student` ASC) VISIBLE,
  CONSTRAINT `FK_student_payment`
    FOREIGN KEY (`student`)
    REFERENCES `CollegeManagementDB`.`Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Credit_Card`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Credit_Card` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Credit_Card` (
  `card_number` VARCHAR(16) NOT NULL,
  `payment` INT NOT NULL,
  `exp_date` DATE NOT NULL,
  `ccv` INT NOT NULL,
  `bank` VARCHAR(45) NOT NULL,
  INDEX `FK_payment_creditcard_idx` (`payment` ASC) VISIBLE,
  PRIMARY KEY (`payment`),
  CONSTRAINT `FK_payment_creditcard`
    FOREIGN KEY (`payment`)
    REFERENCES `CollegeManagementDB`.`Payment` (`payment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Bank_Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Bank_Account` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Bank_Account` (
  `acct_number` VARCHAR(12) NOT NULL,
  `payment` INT NOT NULL,
  `routing` VARCHAR(9) NOT NULL,
  `bank` VARCHAR(45) NOT NULL,
  INDEX `FK_payment_bankaccount_idx` (`payment` ASC) VISIBLE,
  PRIMARY KEY (`payment`),
  CONSTRAINT `FK_payment_bankaccount`
    FOREIGN KEY (`payment`)
    REFERENCES `CollegeManagementDB`.`Payment` (`payment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Address` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `zipcode` INT NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Teaching_Courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Teaching_Courses` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Teaching_Courses` (
  `teach_course_id` INT NOT NULL AUTO_INCREMENT,
  `course` INT NOT NULL,
  `teacher` INT NOT NULL,
  PRIMARY KEY (`teach_course_id`),
  INDEX `FK_teacher_teachingcourses_idx` (`teacher` ASC) VISIBLE,
  INDEX `FK_course_teachingcourses_idx` (`course` ASC) VISIBLE,
  CONSTRAINT `FK_teacher_teachingcourses`
    FOREIGN KEY (`teacher`)
    REFERENCES `CollegeManagementDB`.`Teacher` (`teacher_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_course_teachingcourses`
    FOREIGN KEY (`course`)
    REFERENCES `CollegeManagementDB`.`Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Enrollment` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Enrollment` (
  `enrollment_id` INT NOT NULL AUTO_INCREMENT,
  `student` INT NOT NULL,
  `course` INT NOT NULL,
  `semester` VARCHAR(45) NOT NULL,
  `year` INT NOT NULL,
  `section` INT NOT NULL,
  PRIMARY KEY (`enrollment_id`),
  INDEX `FK_student_enrollment_idx` (`student` ASC) VISIBLE,
  INDEX `FK_course_enrollment_idx` (`course` ASC) VISIBLE,
  CONSTRAINT `FK_student_enrollment`
    FOREIGN KEY (`student`)
    REFERENCES `CollegeManagementDB`.`Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_course_enrollment`
    FOREIGN KEY (`course`)
    REFERENCES `CollegeManagementDB`.`Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Grader`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Grader` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Grader` (
  `grader_id` INT NOT NULL AUTO_INCREMENT,
  `student` INT NOT NULL,
  `course` INT NOT NULL,
  `semester` VARCHAR(45) NOT NULL,
  `year` INT NOT NULL,
  `section` INT NOT NULL,
  `course_salary` INT NOT NULL,
  PRIMARY KEY (`grader_id`),
  INDEX `FK_student_grader_idx` (`student` ASC) VISIBLE,
  INDEX `FK_course_grader_idx` (`course` ASC) VISIBLE,
  CONSTRAINT `FK_student_grader`
    FOREIGN KEY (`student`)
    REFERENCES `CollegeManagementDB`.`Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_course_grader`
    FOREIGN KEY (`course`)
    REFERENCES `CollegeManagementDB`.`Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Employee_Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Employee_Address` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Employee_Address` (
  `employee_address_id` INT NOT NULL AUTO_INCREMENT,
  `address` INT NOT NULL,
  `employee` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`employee_address_id`),
  INDEX `FK_address_employeeaddress_idx` (`address` ASC) VISIBLE,
  INDEX `FK_employee_emplyeeaddress_idx` (`employee` ASC) VISIBLE,
  CONSTRAINT `FK_address_employeeaddress`
    FOREIGN KEY (`address`)
    REFERENCES `CollegeManagementDB`.`Address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_employee_emplyeeaddress`
    FOREIGN KEY (`employee`)
    REFERENCES `CollegeManagementDB`.`Employee` (`ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Student_Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Student_Address` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Student_Address` (
  `student_address_id` INT NOT NULL AUTO_INCREMENT,
  `address` INT NOT NULL,
  `student` INT NOT NULL,
  PRIMARY KEY (`student_address_id`),
  INDEX `FK_address_studentaddress_idx` (`address` ASC) VISIBLE,
  INDEX `FK_student_studentaddress_idx` (`student` ASC) VISIBLE,
  CONSTRAINT `FK_address_studentaddress`
    FOREIGN KEY (`address`)
    REFERENCES `CollegeManagementDB`.`Address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_student_studentaddress`
    FOREIGN KEY (`student`)
    REFERENCES `CollegeManagementDB`.`Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Publishing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Publishing` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Publishing` (
  `publishing_id` INT NOT NULL AUTO_INCREMENT,
  `paper` INT NOT NULL,
  `researcher` INT NOT NULL,
  PRIMARY KEY (`publishing_id`),
  INDEX `FK_researcher_publishing_idx` (`researcher` ASC) VISIBLE,
  INDEX `FK_paper_publishing_idx` (`paper` ASC) VISIBLE,
  CONSTRAINT `FK_researcher_publishing`
    FOREIGN KEY (`researcher`)
    REFERENCES `CollegeManagementDB`.`Researcher` (`researcher_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_paper_publishing`
    FOREIGN KEY (`paper`)
    REFERENCES `CollegeManagementDB`.`Paper` (`paper_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Major`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Major` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Major` (
  `major_id` INT NOT NULL AUTO_INCREMENT,
  `major_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`major_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Minor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Minor` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Minor` (
  `minor_id` INT NOT NULL AUTO_INCREMENT,
  `minor_name` VARCHAR(45) NULL,
  PRIMARY KEY (`minor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`College_Major`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`College_Major` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`College_Major` (
  `college_major_id` INT NOT NULL AUTO_INCREMENT,
  `major` INT NOT NULL,
  `college` INT NOT NULL,
  PRIMARY KEY (`college_major_id`),
  INDEX `FK_major_collegemajor_idx` (`major` ASC) VISIBLE,
  INDEX `FK_college_collegemajor_idx` (`college` ASC) VISIBLE,
  CONSTRAINT `FK_major_collegemajor`
    FOREIGN KEY (`major`)
    REFERENCES `CollegeManagementDB`.`Major` (`major_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_college_collegemajor`
    FOREIGN KEY (`college`)
    REFERENCES `CollegeManagementDB`.`College` (`college_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`College_Minor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`College_Minor` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`College_Minor` (
  `college_minor_id` INT NOT NULL AUTO_INCREMENT,
  `minor` INT NOT NULL,
  `college` INT NOT NULL,
  PRIMARY KEY (`college_minor_id`),
  INDEX `FK_minor_collegeminor_idx` (`minor` ASC) VISIBLE,
  INDEX `FK_college_collegeminor_idx` (`college` ASC) VISIBLE,
  CONSTRAINT `FK_minor_collegeminor`
    FOREIGN KEY (`minor`)
    REFERENCES `CollegeManagementDB`.`Minor` (`minor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_college_collegeminor`
    FOREIGN KEY (`college`)
    REFERENCES `CollegeManagementDB`.`College` (`college_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Student_Major`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Student_Major` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Student_Major` (
  `student_major_id` INT NOT NULL AUTO_INCREMENT,
  `college_major` INT NOT NULL,
  `student` INT NOT NULL,
  PRIMARY KEY (`student_major_id`),
  INDEX `FK_collegemajor_studentmajor_idx` (`college_major` ASC) VISIBLE,
  INDEX `FK_student_studentmajor_idx` (`student` ASC) VISIBLE,
  CONSTRAINT `FK_collegemajor_studentmajor`
    FOREIGN KEY (`college_major`)
    REFERENCES `CollegeManagementDB`.`College_Major` (`college_major_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_student_studentmajor`
    FOREIGN KEY (`student`)
    REFERENCES `CollegeManagementDB`.`Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Student_Minor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Student_Minor` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Student_Minor` (
  `student_minor_id` INT NOT NULL AUTO_INCREMENT,
  `college_minor` INT NOT NULL,
  `student` INT NOT NULL,
  PRIMARY KEY (`student_minor_id`),
  INDEX `FK_collegeminor_studentminor_idx` (`college_minor` ASC) VISIBLE,
  INDEX `FK_student_studentminor_idx` (`student` ASC) VISIBLE,
  CONSTRAINT `FK_collegeminor_studentminor`
    FOREIGN KEY (`college_minor`)
    REFERENCES `CollegeManagementDB`.`College_Minor` (`college_minor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_student_studentminor`
    FOREIGN KEY (`student`)
    REFERENCES `CollegeManagementDB`.`Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Campus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Campus` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Campus` (
  `campus_id` INT NOT NULL AUTO_INCREMENT,
  `college` INT NOT NULL,
  `address` INT NOT NULL,
  `campus_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`campus_id`),
  INDEX `FK_college_campus_idx` (`college` ASC) VISIBLE,
  INDEX `FK_address_campus_idx` (`address` ASC) VISIBLE,
  CONSTRAINT `FK_college_campus`
    FOREIGN KEY (`college`)
    REFERENCES `CollegeManagementDB`.`College` (`college_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_address_campus`
    FOREIGN KEY (`address`)
    REFERENCES `CollegeManagementDB`.`Address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Building`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Building` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Building` (
  `building_id` INT NOT NULL AUTO_INCREMENT,
  `campus` INT NULL,
  `building_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`building_id`),
  INDEX `FK_campus_building_idx` (`campus` ASC) VISIBLE,
  CONSTRAINT `FK_campus_building`
    FOREIGN KEY (`campus`)
    REFERENCES `CollegeManagementDB`.`Campus` (`campus_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Room` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Room` (
  `room_id` INT NOT NULL AUTO_INCREMENT,
  `building` INT NOT NULL,
  `room_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`room_id`),
  INDEX `FK_building_room_idx` (`building` ASC) VISIBLE,
  CONSTRAINT `FK_building_room`
    FOREIGN KEY (`building`)
    REFERENCES `CollegeManagementDB`.`Building` (`building_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Supervisors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Supervisors` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Supervisors` (
  `employee` VARCHAR(11) NOT NULL,
  `supervisor` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`employee`),
  INDEX `FK_employee_supervisors_idx` (`supervisor` ASC) VISIBLE,
  CONSTRAINT `FK_employee_supervisors`
    FOREIGN KEY (`supervisor`)
    REFERENCES `CollegeManagementDB`.`Employee` (`ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_supervisor_supervisors`
    FOREIGN KEY (`employee`)
    REFERENCES `CollegeManagementDB`.`Employee` (`ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Visitor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Visitor` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Visitor` (
  `visitor_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`visitor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Visiting_List`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Visiting_List` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Visiting_List` (
  `visiting_list_id` INT NOT NULL AUTO_INCREMENT,
  `visitor` INT NOT NULL,
  `campus` INT NOT NULL,
  `date_visiting` DATETIME NOT NULL,
  PRIMARY KEY (`visiting_list_id`),
  INDEX `FK_visitor_visitinglist_idx` (`visitor` ASC) VISIBLE,
  INDEX `FK_campus_visitinglist_idx` (`campus` ASC) VISIBLE,
  CONSTRAINT `FK_visitor_visitinglist`
    FOREIGN KEY (`visitor`)
    REFERENCES `CollegeManagementDB`.`Visitor` (`visitor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_campus_visitinglist`
    FOREIGN KEY (`campus`)
    REFERENCES `CollegeManagementDB`.`Campus` (`campus_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Store`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Store` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Store` (
  `store_id` INT NOT NULL AUTO_INCREMENT,
  `campus` INT NULL,
  `store_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`store_id`),
  INDEX `FK_campus_store_idx` (`campus` ASC) VISIBLE,
  CONSTRAINT `FK_campus_store`
    FOREIGN KEY (`campus`)
    REFERENCES `CollegeManagementDB`.`Campus` (`campus_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Product` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `store` INT NULL,
  `product_name` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  `is_online` BIT(1) NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `FK_store_product_idx` (`store` ASC) VISIBLE,
  CONSTRAINT `FK_store_product`
    FOREIGN KEY (`store`)
    REFERENCES `CollegeManagementDB`.`Store` (`store_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Office`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Office` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Office` (
  `office_id` INT NOT NULL AUTO_INCREMENT,
  `room` INT NULL,
  `faculty` INT NOT NULL,
  PRIMARY KEY (`office_id`),
  INDEX `FK_room_office_idx` (`room` ASC) VISIBLE,
  INDEX `FK_faculty_office_idx` (`faculty` ASC) VISIBLE,
  CONSTRAINT `FK_room_office`
    FOREIGN KEY (`room`)
    REFERENCES `CollegeManagementDB`.`Room` (`room_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_faculty_office`
    FOREIGN KEY (`faculty`)
    REFERENCES `CollegeManagementDB`.`Faculty_Member` (`faculty_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Class`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Class` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Class` (
  `class_id` INT NOT NULL AUTO_INCREMENT,
  `room` INT NULL,
  `course` INT NOT NULL,
  PRIMARY KEY (`class_id`),
  INDEX `FK_room_class_idx` (`room` ASC) VISIBLE,
  INDEX `FK_course_class_idx` (`course` ASC) VISIBLE,
  CONSTRAINT `FK_room_class`
    FOREIGN KEY (`room`)
    REFERENCES `CollegeManagementDB`.`Room` (`room_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_course_class`
    FOREIGN KEY (`course`)
    REFERENCES `CollegeManagementDB`.`Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Wellness_Center`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Wellness_Center` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Wellness_Center` (
  `wellness_center_id` INT NOT NULL AUTO_INCREMENT,
  `wellness_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`wellness_center_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Activities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Activities` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Activities` (
  `activity_id` INT NOT NULL AUTO_INCREMENT,
  `campus` INT NOT NULL,
  `wellness` INT NOT NULL,
  `activity_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`activity_id`),
  INDEX `FK_campus_activities_idx` (`campus` ASC) VISIBLE,
  INDEX `FK_wellness_activities_idx` (`wellness` ASC) VISIBLE,
  CONSTRAINT `FK_campus_activities`
    FOREIGN KEY (`campus`)
    REFERENCES `CollegeManagementDB`.`Campus` (`campus_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_wellness_activities`
    FOREIGN KEY (`wellness`)
    REFERENCES `CollegeManagementDB`.`Wellness_Center` (`wellness_center_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Janitor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Janitor` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Janitor` (
  `janitor_id` INT NOT NULL AUTO_INCREMENT,
  `janitor_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`janitor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CollegeManagementDB`.`Assigned_Cleaning`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CollegeManagementDB`.`Assigned_Cleaning` ;

CREATE TABLE IF NOT EXISTS `CollegeManagementDB`.`Assigned_Cleaning` (
  `janitor` INT NOT NULL,
  `campus` INT NOT NULL,
  PRIMARY KEY (`janitor`, `campus`),
  INDEX `FK_campus_assignedcleaning_idx` (`campus` ASC) VISIBLE,
  CONSTRAINT `FK_janitor_assignedcleaning`
    FOREIGN KEY (`janitor`)
    REFERENCES `CollegeManagementDB`.`Janitor` (`janitor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_campus_assignedcleaning`
    FOREIGN KEY (`campus`)
    REFERENCES `CollegeManagementDB`.`Campus` (`campus_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
