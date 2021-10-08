CREATE DATABASE test_system_assigment_1;

USE test_system_assigment_1;

CREATE TABLE department
(
	department_id 		INT AUTO_INCREMENT,
    department_name 	VARCHAR(50) NOT NULL,
PRIMARY KEY (department_id)
);

CREATE TABLE position
(
	position_id 		INT 			AUTO_INCREMENT,
    position_name 		VARCHAR(50) 	NOT NULL,
PRIMARY KEY (position_id)
);

CREATE TABLE `account`
(
	account_id 			INT 			AUTO_INCREMENT,
    email 				VARCHAR(50) 	NOT NULL,
    user_name 			VARCHAR(50) 	NOT NULL,
    full_name 			VARCHAR(50) 	NOT NULL,
    department_id 		INT 			NOT NULL,
    position_id 		VARCHAR(50) 	NOT NULL,
    create_date 		DATE 			NOT NULL,
PRIMARY KEY(account_id)
);

CREATE TABLE `group`
(
	group_id 			INT 			AUTO_INCREMENT,
    group_name 			VARCHAR(50) 	NOT NULL,
    creator_id 			INT 			NOT NULL,
    create_date 		DATE 			NOT NULL,
PRIMARY KEY (group_id)
);

CREATE TABLE group_account
(
	group_id 			INT 			NOT NULL,
    account_id 			INT 			NOT NULL,
    join_date 			DATE 			NOT NULL,
PRIMARY KEY (group_id)
);

CREATE TABLE type_question
(
	type_id 			INT 			AUTO_INCREMENT,
    type_name 			VARCHAR(50) 	NOT NULL,
PRIMARY KEY (type_id)
);

CREATE TABLE category_question
(
	category_id 		INT 			AUTO_INCREMENT,
    category_name 		VARCHAR(50) 	NOT NULL,
PRIMARY KEY (category_id)
);

CREATE TABLE question
(
	question_id 		INT 			AUTO_INCREMENT,
    content 			VARCHAR(50),
    category_Id 		INT 			NOT NULL,
    type_id 			INT 			NOT NULL,
    creator_id 			INT 			NOT NULL,
    create_date 		DATE 			NOT NULL,
PRIMARY KEY (question_id)
);

CREATE TABLE answer
(
	answer_id 			INT 			AUTO_INCREMENT,
    content 			VARCHAR(50),
    question_id 		INT 			NOT NULL,
    is_correct 			ENUM('Đúng', 'Sai'),
PRIMARY KEY (answer_id)
);

CREATE TABLE exam
(
	exam_id 			INT 			AUTO_INCREMENT,
    code_ 				INT,
    title 				VARCHAR(50),
    category_id 		INT 			NOT NULL,
    duration 			TIMESTAMP 		NOT NULL,
    creator_id 			INT 			NOT NULL,
    create_date 		DATE 			NOT NULL,
PRIMARY KEY (exam_id)
);

CREATE TABLE exam_question
(
	exam_id 			INT 			NOT NULL,
    question_id 		INT 			NOT NULL,
PRIMARY KEY (exam_id)
);

