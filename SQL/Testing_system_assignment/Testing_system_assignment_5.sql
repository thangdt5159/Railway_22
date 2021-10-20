USE	testing_system;
-- 1. Tạo view có chứa danh sách nhân viên thuộc phòng ban sale

CREATE VIEW sale_acc AS 
SELECT	*
FROM	accounts
WHERE	department_id = (SELECT	department_id
						FROM	departments
						WHERE	department_name = 'sale');

SELECT	*	FROM	sale_acc;

-- CREATE VIEW sale_acc_2 AS
-- SELECT	*
-- FROM	accounts a
-- LEFT JOIN	departments d
-- 	ON	a.department_id = d.department_id
-- WHERE	d.department_name = 'sale';

-- 2. Tạo view có chứa thông tin các account tham gia vào nhiều group nhất

CREATE VIEW so_acc AS
SELECT	a.account_id,
		ga.group_id,
        COUNT(ga.account_id) so_group
FROM	accounts a
LEFT JOIN	group_accounts ga
	ON	a.account_id = ga.account_id
GROUP BY	a.account_id
	HAVING	COUNT(ga.account_id) = (SELECT	COUNT(ga.account_id) so_group
									FROM	group_accounts ga
									RIGHT JOIN	accounts a
										ON	ga.account_id = a.account_id
									GROUP BY	ga.account_id
									ORDER BY	COUNT(ga.account_id) DESC
									LIMIT 1);
                                    
SELECT * FROM	so_acc;

-- 3. Tạo view có chứa câu hỏi có những content quá dài (content quá 17 từ được coi là quá dài) và xóa nó đi

CREATE VIEW content_dai AS
SELECT	LENGTH(content) 
FROM	questions
WHERE	LENGTH(content) > 17;

SELECT * FROM	content_dai;



-- 4. Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất

CREATE VIEW	dept_acc AS

SELECT	d.department_name,
		COUNT(a.account_id) so_nhan_vien
FROM	departments d
INNER JOIN	accounts a
	ON	d.department_id = a.department_id
GROUP BY	d.department_name
	HAVING	COUNT(a.account_id) = (	SELECT	COUNT(a.account_id) so_nhan_vien
									FROM	departments d
									INNER JOIN	accounts a
										ON	a.department_id = d.department_id
									GROUP BY	d.department_name
									ORDER BY	COUNT(a.account_id) DESC
									LIMIT 1);

SELECT * FROM	dept_acc;



-- 5. Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo

CREATE VIEW question_by_nguyen AS

SELECT	q.content, a.fullname
FROM	questions q
RIGHT JOIN	accounts a
	ON	q.creator_id = a.account_id
WHERE	a.fullname LIKE 'Nguyen%';

SELECT * FROM question_by_nguyen;