DROP TABLE IF EXISTS nhan_vien;
CREATE DATABASE IF NOT EXISTS nhan_vien;
USE nhan_vien;

CREATE TABLE department
(
	department_number	TINYINT UNSIGNED AUTO_INCREMENT,
    department_name		VARCHAR(50),
PRIMARY KEY (department_number)
);

CREATE TABLE employee_table
(
	employee_number		TINYINT UNSIGNED AUTO_INCREMENT,
    employee_name		VARCHAR(50),
    department_number	TINYINT UNSIGNED,
PRIMARY KEY (employee_number)
);

CREATE TABLE employee_skill_table
(
	employee_number		TINYINT UNSIGNED,
    skill_code			CHAR(10),
    date_registered		DATE,
FOREIGN KEY (employee_number) REFERENCES employee_table(employee_number)
);