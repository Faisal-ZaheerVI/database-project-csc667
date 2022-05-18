-- Script name: triggers.sql
-- Author:      Faisal Zaheer
-- Purpose:     Adding triggers to test the integrity of the College Management Database System.

SET SQL_SAFE_UPDATES = 0; 

-- the database used to insert the data into.
USE collegemanagementdb;

DROP TRIGGER IF EXISTS UPDATE_FACULTY_COUNT;
DROP TRIGGER IF EXISTS UPDATE_PRODUCT_ON_INSERT;
DROP TRIGGER IF EXISTS UPDATE_PRODUCT;

DELIMITER $$

-- Update faculty_count in Department.
CREATE TRIGGER UPDATE_FACULTY_COUNT AFTER INSERT ON faculty_member 
FOR EACH ROW
    BEGIN
		DECLARE new_faculty_count INT;
        SET new_faculty_count = (SELECT count(*) from faculty_member WHERE department = new.department);
        UPDATE Department SET faculty_count = new_faculty_count WHERE department_id = new.department;
	END$$
    
-- Checks to make sure Product is listed as an online product if it belongs to no store.
CREATE TRIGGER UPDATE_PRODUCT_ON_INSERT AFTER INSERT ON product 
FOR EACH ROW
    BEGIN
        IF (new.store = null && new.is_online = 0) THEN 
            UPDATE Product SET is_online = 1 WHERE product_id = new.product_id; 
		END IF;
	END$$
    
CREATE TRIGGER UPDATE_PRODUCT AFTER UPDATE ON product 
FOR EACH ROW
    BEGIN
        IF (new.store = null && new.is_online = 0) THEN 
            UPDATE Product SET is_online = 1 WHERE product_id = new.product_id; 
		END IF;
	END$$

DELIMITER ;
