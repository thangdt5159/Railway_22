-- 1. Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo trước 1 năm trước

DELIMITER //
CREATE TRIGGER 1_create_date
	BEFORE INSERT
    ON `groups` FOR EACH ROW
		BEGIN
			IF NEW.create_date < DATE_SUB(NOW(), INTERVAL 1 YEAR) THEN 
            SIGNAL SQLSTATE '11223'
            SET MESSAGE_TEXT = 'loi insert';
            END IF;
        END//
DELIMITER ;

-- 2. Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào department "Sale" nữa, khi thêm thì hiện ra thông báo "Department "Sale" cannot add more user"

DELIMITER //
CREATE TRIGGER 2_cant_add
	BEFORE INSERT
    ON accounts FOR EACH ROW
		BEGIN
			DECLARE id_sale INT;
            SELECT 	department_id INTO id_sale
            FROM 	departments
            WHERE 	department_name = 'sale';
            IF 	NEW.department_id = id_sale THEN
			SIGNAL SQLSTATE '22334'
            SET MESSAGE_TEXT = 'Department "Sale" cannot add more user';
            END IF;
		END//
DELIMITER ;

-- 3. Cấu hình 1 group có nhiều nhất là 5 user

DELIMITER //
CREATE TRIGGER 3_user_max
BEFORE INSERT
ON group_accounts FOR EACH ROW
	BEGIN            
		IF (SELECT COUNT(account_id) FROM group_accounts WHERE NEW.group_id = group_id) >= 5  THEN
			SIGNAL SQLSTATE '33445'
			SET MESSAGE_TEXT = 'Cannot insert more user';
		END IF;
    END//
DELIMITER ;

-- 4. Cấu hình 1 bài thi có nhiều nhất là 10 Question

DELIMITER //
CREATE TRIGGER 4_question_max
BEFORE INSERT
ON exam_questions FOR EACH ROW
	BEGIN
		IF (SELECT COUNT(question_id) FROM exam_questions WHERE NEW.exam_id = exam_id) > 10 THEN
        SIGNAL SQLSTATE '33446'
		SET MESSAGE_TEXT = 'Cannot insert more user';
        END IF;
    END//
DELIMITER ;

-- 5. Tạo trigger không cho phép người dùng xóa tài khoản có email là admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông tin liên quan tới user đó

DELIMITER //
CREATE TRIGGER 5_delete_account
BEFORE DELETE
ON accounts FOR EACH ROW
	BEGIN
		IF OLD.email = 'admin@gmail.com' THEN
		SIGNAL SQLSTATE '33447'
		SET MESSAGE_TEXT = 'Đây là tài khoản admin, không cho phép xóa';
        END IF;
    END//
DELIMITER ;

-- 6 Không sử dụng cấu hình default cho field DepartmentID của table Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào departmentID thì sẽ được phân vào phòng ban "waiting Department"

INSERT INTO departments (department_id, department_name)
VALUES					(99, 'Waiting Department');

DROP TRIGGER IF EXISTS 6_waiting_department;
DELIMITER //
CREATE TRIGGER 6_waiting_department
BEFORE INSERT
ON accounts FOR EACH ROW
	BEGIN
		DECLARE waiting_id INT;
        SELECT 	department_id INTO waiting_id
        FROM 	departments
        WHERE 	department_name = 'waiting department';
		IF NEW.department_id IS NULL THEN 
        SET NEW.department_id = waiting_id;
        END IF;
    END//
DELIMITER ;

INSERT INTO accounts (email, username, fullname, gender, position_id, create_date)
VALUES				('bca@gmail.com', 'Thang', 'duong', 1, 1, '2021/10/20');

-- 7 Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi question, trong đó có tối đa 2 đáp án đúng.

DROP TRIGGER IF EXISTS 7_answer_max;
DELIMITER //
CREATE TRIGGER 7_answer_max
BEFORE INSERT
ON answers FOR EACH ROW
	BEGIN
		DECLARE count_answer INT;
        DECLARE count_iscorrect INT;
        SELECT 	COUNT(answer_id) INTO count_answer
        FROM 	answers
        WHERE 	NEW.question_id = question_id;
        SELECT 	COUNT(iscorrect) INTO count_iscorrect
        FROM 	answers
        WHERE 	NEW.question_id = question_id;
        IF 	count_answer > 4 OR count_iscorrect > 2 THEN
			SIGNAL SQLSTATE '33448'
            SET MESSAGE_TEXT = 'Khong the them cau tra loi cho cau hoi nay';
		END IF;
    END//
DELIMITER ;

-- 8. Viết trigger sửa lại dữ liệu cho đúng: Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
-- Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database

DELIMITER //
CREATE TRIGGER 8_gender_correction
BEFORE INSERT
ON accounts FOR EACH ROW
	BEGIN
		IF NEW.gender = 'nam' THEN 
			SET NEW.gender = 'M';
		ELSEIF NEW.gender = N'nữ' THEN
			SET NEW.gender = 'F';
		ELSE SET NEW.gender = 'U';
        END IF;
    END//
DELIMITER ;

-- 9. Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày

DROP TRIGGER IF EXISTS 9_delete_exam;
DELIMITER //
CREATE TRIGGER 9_delete_exam
BEFORE DELETE
ON exams FOR EACH ROW
	BEGIN
		IF OLD.createdate > DATE_SUB(NOW(), INTERVAL 2 DAY) THEN
			SIGNAL SQLSTATE '33451'
            SET MESSAGE_TEXT = 'Khong the xoa bai thi moi tao duoc 2 ngay';
		END IF;
    END//
DELIMITER ;

-- 10. Viết trigger chỉ cho phép người dùng chỉ được update, delete các question khi question đó chưa nằm trong exam nào

DELIMITER //
CREATE TRIGGER 10_chi_update_delete
BEFORE INSERT
ON questions FOR EACH ROW 
	BEGIN
		DECLARE q_id INT;
        SELECT 	q.question_id INTO q_id
        FROM 	questions q
        LEFT JOIN 	exam_questions eq
			ON q.question_id = eq.question_id
		WHERE 	eq.question_id IS NULL;
        IF NEW.question_id = q_id THEN
			SIGNAL SQLSTATE '33452'
            SET MESSAGE_TEXT = 'Khong the INSERT, chi duoc UPDATE OR DELETE';
		END IF;
    END//
DELIMITER ;

-- 11. Lấy ra thông tin exam trong đó:

-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- Duration > 60 thì sẽ đổi thành giá trị "Long time"

SELECT 	*,
		CASE
			WHEN duration <= 30 THEN 'Short time'
            WHEN duration > 30 AND duration <= 60 THEN 'Medium time'
            WHEN duration > 60 THEN 'Long time'
		END AS duration_time
FROM 	exams;

-- 12. Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên là the_number_user_amount và mang giá trị được quy định như sau:

-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher

SELECT 	group_id,
		COUNT(account_id) so_account,
		CASE
			WHEN COUNT(account_id) <= 5 THEN 'few'
            WHEN COUNT(account_id) <= 20 THEN 'normal'
            WHEN COUNT(account_id) > 20 THEN 'higher'
		END AS the_number_user_amount
FROM group_accounts
GROUP BY group_id;


-- 13. Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào không có user thì sẽ thay đổi giá trị 0 thành "Không có User"

SELECT 	d.*, 
		CASE
			WHEN COUNT(a.account_id) = 0 THEN 'Khong co user'
            ELSE COUNT(a.account_id)
		END AS so_user
FROM 	accounts a
RIGHT JOIN 	departments d
	ON 	a.department_id = d.department_id
GROUP BY 	d.department_id;

