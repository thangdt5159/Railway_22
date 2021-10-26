USE testing_system;
-- 1. Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó

DROP PROCEDURE IF EXISTS 1_department_accounts;
DELIMITER //
CREATE PROCEDURE 1_department_accounts (IN in_department_name VARCHAR(50))
	BEGIN
		SELECT 	*
        FROM 	accounts a
        INNER JOIN	departments d
			ON	d.department_id = a.department_id
		WHERE	LOWER(d.department_name) = LOWER(in_department_name);
	END//
DELIMITER ;

CALL 1_department_accounts('marketing');

-- 2. Tạo store để in ra số lượng account trong mỗi group

DROP PROCEDURE IF EXISTS 2_so_group_account;
DELIMITER //
CREATE PROCEDURE 2_so_group_account ()
	BEGIN
		SELECT	g.group_name,
				COUNT(ga.account_id) so_account
        FROM	group_accounts ga
        RIGHT JOIN	`groups` g
			ON	ga.group_id = g.group_id
		GROUP BY	g.group_id
        ORDER BY	COUNT(ga.account_id) DESC;
	END//
DELIMITER ;
     
CALL 2_so_group_account;

-- 3. Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại

DROP PROCEDURE IF EXISTS 3_so_cau_hoi;
DELIMITER //
CREATE PROCEDURE 3_so_cau_hoi (IN loai_cau_hoi VARCHAR(20), OUT so_luong TINYINT)
	BEGIN
        SELECT	COUNT(q.question_id) INTO so_luong
		FROM	type_questions tq
        INNER JOIN	questions q
			ON	tq.type_id = q.type_id
		WHERE	MONTH(q.create_date) = MONTH(NOW()) AND YEAR(q.create_date) = YEAR(NOW())
		GROUP BY	tq.type_name;
	END//
DELIMITER ;

CALL 3_so_cau_hoi('essay', @so_luong);
SELECT @so_luong;

-- 4. Tạo store để trả ra id của type question có nhiều câu hỏi nhất

DROP PROCEDURE IF EXISTS 4_loai_cau_hoi_nhieu_nhat;
DELIMITER //
CREATE PROCEDURE 4_loai_cau_hoi_nhieu_nhat (OUT id_type_question TINYINT)
	BEGIN
		SELECT 	tq.type_id INTO id_type_question
        FROM	type_questions tq
        INNER JOIN	questions q
			ON	tq.type_id = q.type_id
        GROUP BY	tq.type_id
			HAVING 	COUNT(q.question_id) = (SELECT	COUNT(question_id)													
											FROM	questions
                                            GROUP BY	type_id
                                            ORDER BY	COUNT(question_id) DESC
                                            LIMIT 1);
	END//
DELIMITER ;

CALL 4_loai_cau_hoi_nhieu_nhat(@id_type_question);
SELECT @id_type_question;

-- 5. Sử dụng store ở question 4 để tìm ra tên của type question

SELECT 	type_name		
FROM	type_questions
WHERE	type_id = @id_type_question;

-- 6. Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên 
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào

DROP PROCEDURE IF EXISTS 6_tim_group_username;
DELIMITER //
CREATE PROCEDURE 6_tim_group_username (IN nhap_ten VARCHAR(50))
	BEGIN
		SELECT	'user' ten,
				username
        FROM	accounts
        WHERE	INSTR(username, nhap_ten)
        UNION
        SELECT	'group',
				group_name
        FROM	`groups`
        WHERE	INSTR(group_name, nhap_ten);
	END//
DELIMITER ;

CALL 6_tim_group_username ('an');

-- 7. Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:

-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ

-- Sau đó in ra kết quả tạo thành công

DROP PROCEDURE IF EXISTS 7_thong_tin;
DELIMITER //
CREATE PROCEDURE 7_thong_tin (IN ten_day_du VARCHAR(50), IN dia_chi_email VARCHAR(100))
	BEGIN
		CREATE TEMPORARY TABLE IF NOT EXISTS bang_tam
        (
			full_name		VARCHAR(50) NOT NULL,
            user_name		VARCHAR(50) NOT NULL,
            email			VARCHAR(100) NOT NULL,
            position_id		ENUM('DEV', 'Test', 'PM', 'Scrum Master') NOT NULL DEFAULT 'DEV',
            department_id	ENUM('phong cho') NOT NULL DEFAULT 'phong cho'
        );
		INSERT INTO bang_tam(full_name	, user_name										, email		, position_id, department_id)
		VALUES				(ten_day_du	, TRIM(TRAILING '@gmail.com' FROM dia_chi_email), dia_chi_email, 'DEV'	, 'phong cho');
        SELECT * FROM bang_tam;
	END//
DELIMITER ;

CALL 7_thong_tin ('Duong Van B', 'DVB.2021@gmail.com');
DROP TABLE bang_tam;

-- 8. Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất

DROP PROCEDURE IF EXISTS 8_long_content;
DELIMITER //
CREATE PROCEDURE 8_long_content (IN kieu_cau_hoi ENUM('essay', 'multiple_choice'))
	BEGIN
		SELECT 	q.content 
        FROM 	questions q
        INNER JOIN	type_questions tq
			ON	q.type_id = tq.type_id
		WHERE LENGTH(q.content) = (SELECT	MAX(LENGTH(q.content)) 
									FROM	questions q
                                    INNER JOIN type_questions tq
										ON	q.type_id = tq.type_id
                                    WHERE	tq.type_name = kieu_cau_hoi);
	END//
DELIMITER ;

CALL 8_long_content ('essay');
CALL 8_long_content ('multiple_choice');

-- 9. Viết 1 store cho phép người dùng xóa exam dựa vào ID

DROP PROCEDURE IF EXISTS 9_xoa_exam;
DELIMITER //
CREATE PROCEDURE 9_xoa_exam (IN id_de_thi INT)
	BEGIN
		SELECT	`code`
        FROM	exams
        WHERE	exam_id = id_de_thi;
		DELETE FROM	exam_questions
        WHERE	exam_id = id_de_thi;
        DELETE FROM exams
        WHERE 	exam_id = id_de_thi;
	END//
DELIMITER ;

CALL 9_xoa_exam (6);

-- 10. Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing

DROP PROCEDURE IF EXISTS 10_xoa_exam;
DELIMITER //
CREATE PROCEDURE 10_xoa_exam (OUT removed_records TINYINT)
	BEGIN
		DECLARE ma_can_xoa INT DEFAULT 0;
		SELECT 	exam_id INTO ma_can_xoa
        FROM	exams
        WHERE	YEAR(createdate) <= YEAR(NOW()) - 1;
        SELECT 	COUNT(*) INTO removed_records
        FROM 	exams 
        WHERE 	YEAR(createdate) <= YEAR(NOW()) - 1;
        CALL	9_xoa_exam (ma_can_xoa);
	END//
DELIMITER ;

SELECT	exam_id
FROM	exams
WHERE	YEAR(createdate) <= YEAR(NOW()) - 1;


CALL 10_xoa_exam (@removed_records);

-- 11. Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc

DROP PROCEDURE IF EXISTS 11_xoa_phong_ban;
DELIMITER //
CREATE PROCEDURE 11_xoa_phong_ban (IN para_name_1 INT)
	BEGIN
		SELECT 	
        FROM
        WHERE
	END//
DELIMITER ;

CALL name_1 ();

-- 12. Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay

DROP PROCEDURE IF EXISTS 12_cau_hoi_moi_thang;
DELIMITER //
CREATE PROCEDURE 12_cau_hoi_moi_thang ()
	BEGIN
		SELECT 	COUNT(question_id) so_cau_hoi,
				MONTHNAME(create_date)
        FROM	questions
        WHERE	MONTH(create_date) BETWEEN 1 AND 12 AND YEAR(create_date) = YEAR(NOW())
        GROUP BY	MONTH(create_date);
	END//
DELIMITER ;

CALL 12_cau_hoi_moi_thang;

-- 13. Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6
-- tháng gần đây nhất (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")

DROP PROCEDURE IF EXISTS 13_so_cau_hoi_trong_6_thang;
DELIMITER //
CREATE PROCEDURE 13_so_cau_hoi_trong_6_thang ()
	BEGIN
		SELECT 	COUNT(question_id) so_cau_hoi,
				
        FROM	questions
        WHERE	MONTH(create_date) BETWEEN MONTH(NOW()) - 6 AND MONTH(NOW()) AND YEAR(create_date) = YEAR(NOW())
        GROUP BY	MONTH(create_date);
	END//
DELIMITER ;

CALL 13_so_cau_hoi_trong_6_thang;