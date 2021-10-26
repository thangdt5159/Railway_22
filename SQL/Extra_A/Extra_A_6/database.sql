DROP DATABASE IF EXISTS ky_thuat;
CREATE DATABASE IF NOT EXISTS ky_thuat;
USE ky_thuat;

CREATE TABLE employee
(
	employee_id				TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	employee_last_name		VARCHAR(50),
    employee_first_name		VARCHAR(50),
    employee_hire_date		DATE NOT NULL,
    employee_status			ENUM('active', 'deactive') DEFAULT 'active',
    supervisor_id			TINYINT UNSIGNED,
    social_security_number	CHAR(15) NOT NULL,
PRIMARY KEY (employee_id),
FOREIGN KEY (supervisor_id) REFERENCES employee(employee_id) ON DELETE CASCADE
);

CREATE TABLE projects
(
	project_id				TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    manager_id				TINYINT	UNSIGNED NOT NULL UNIQUE,
    project_name			VARCHAR(50) NOT NULL,
    project_start_date		DATE NOT NULL,
    project_description		TEXT,
    project_detail			TEXT,
    project_completed_on	DATE,
PRIMARY KEY (project_id),
FOREIGN KEY (manager_id) REFERENCES employee(employee_id) ON DELETE CASCADE
);

CREATE TABLE project_modules
(
	module_id					TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    project_id					TINYINT UNSIGNED NOT NULL,
    employee_Id					TINYINT UNSIGNED NOT NULL UNIQUE,
    project_module_date			DATE NOT NULL,
    project_module_completed_on	DATE,
    project_module_description	TEXT,
PRIMARY KEY (module_id),
FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE,
FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE
);

CREATE TABLE work_done
(
	work_done_id			TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    employee_id				TINYINT UNSIGNED NOT NULL,
    module_id				TINYINT UNSIGNED NOT NULL,
    work_done_date			DATE,
    work_done_description	TEXT NOT NULL,
    work_done_status		TEXT NOT NULL,
PRIMARY KEY (work_done_id),
FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE,
FOREIGN KEY (module_id) REFERENCES project_modules(module_id) ON DELETE CASCADE
);