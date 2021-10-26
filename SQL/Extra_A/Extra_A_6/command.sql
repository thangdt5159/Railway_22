-- 1. Tạo table với các ràng buộc và kiểu dữ liệu và thêm ít nhất 3 bản ghi vào mỗi table trên

-- 2. Viết stored procedure (không có parameter) để Remove tất cả thông tin project đã hoàn thành sau 3 tháng kể từ ngày hiện tai. 
-- In số lượng record đã remove từ các table liên quan trong khi removing (dùng lệnh print)

-- DROP PROCEDURE IF EXISTS remove_project;
DELIMITER //
CREATE PROCEDURE remove_project ()
	BEGIN
		SELECT 	COUNT(*)
        FROM 	projects
        WHERE 	project_completed_on < ADDDATE(NOW(), INTERVAL -3 MONTH);
        DELETE FROM 	projects
        WHERE 	project_completed_on < ADDDATE(NOW(), INTERVAL -3 MONTH);
	END//
DELIMITER ;

CALL remove_project ();

-- 3. Viết stored procedure (có parameter) để in ra các module đang được thực hiện)

-- DROP PROCEDURE IF EXISTS module_in_progress;
DELIMITER //
CREATE PROCEDURE module_in_progress (OUT module_info INT)
	BEGIN
		SELECT 	module_id INTO module_info
        FROM 	project_modules
        WHERE 	project_module_completed_on IS NULL;
	END//
DELIMITER ;

CALL module_in_progress (@module_info);
SELECT @module_info;

-- 4. Viết hàm (có parameter) trả về thông tin 1 nhân viên đã tham gia làm mặc dù không ai giao việc cho nhân viên đó (trong bảng Works)  
-- Nhập vào employee_id trả về thông tin module mà nó tham gia nhưng ko đc giao làm

-- DROP FUNCTION IF EXISTS employee_work_check;
DELIMITER //
CREATE FUNCTION employee_work_check (employee_check INT)
RETURNS VARCHAR(50) DETERMINISTIC
	BEGIN
        DECLARE	module_info VARCHAR(50) DEFAULT 'khong co module nao';
        SELECT 	pm.module_id INTO module_info
        FROM	project_modules pm
        LEFT JOIN	work_done wd
			ON	pm.module_id = wd.module_id
        WHERE 	pm.employee_id = employee_check AND wd.employee_id != employee_check;
        RETURN 	module_info;
	END//
DELIMITER ;

SELECT employee_work_check(1);
                  
                    
                    
                    