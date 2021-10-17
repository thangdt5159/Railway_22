USE testing_system;
SELECT *
FROM `groups`;

-- 1. lay ra tat ca cac phong ban

SELECT department_name
FROM departments;

-- 2. lay ra id cua phong ban sale

SELECT department_id
FROM departments
Where department_name = 'sale';

-- 3. lay ra thong tin account co full name dai nhat

SELECT *
FROM accounts
ORDER BY LENGTH(fullname) DESC
LIMIT 1;

-- 4. lay ra thong tin account co full name dai nhat va thuoc phong ban co id = 3

SELECT *
FROM accounts
GROUP BY department_id 
	HAVING department_id = 3
ORDER BY LENGTH(fullname) DESC
LIMIT 1;


-- 5. lay ra ten group da tham gia truoc ngay 6/4/2019

SELECT group_name, create_date
FROM `groups`
WHERE create_date < '2020/4/6';

-- 6. lay ra id cua question co >= 4 cau tra loi

SELECT 	question_id,
		COUNT(question_id) AS tong
FROM answers a
GROUP BY question_id
	HAVING COUNT(question_id) >= 4;

-- 7. lay ra cac ma de thi co thoi gian thi >= 60 phut va duoc tao truoc ngay 8/4/2019

SELECT 	`code`
FROM 	exams
WHERE duration >= 60 AND createdate < '2019/4/8';

-- 8. lay ra 5 group duoc tao gan day nhat

SELECT	* -- group_name
FROM	`groups`
ORDER BY	create_date DESC
LIMIT 5;

-- 9. dem so nhan vien thuoc department co id = 2

SELECT	COUNT(account_id) AS 'so nhan vien'
FROM	accounts
GROUP BY	department_id
	HAVING	department_id = 2;

-- 10. lay ra nhan vien co ten bat dau bang chu 'D' va ket thuc bang chu 'o'

SELECT	fullname
FROM	accounts
WHERE	fullname LIKE 'D%o';
-- WHERE	SUBSTRING_INDEX(fullname, ' ', -1) LIKE 'D%o';

-- 11. xoa tat ca cac exam duoc tao truoc ngay 8/4/2019

DELETE FROM	exams
WHERE		createdate < '2019/4/8';

-- 12. xoa tat ca cac question co noi dung bat dau bang tu 'cau hoi'

DELETE FROM	questions
WHERE		SUBSTRING_INDEX(content, ' ', 2) LIKE 'cau hoi';

-- 13. update thong tin cua account co id = 5 thanh ten 'Nguyen Ba Loc' va email thanh locnguyenba@vti.com.vn

UPDATE	accounts
SET		fullname = 'Nguyen Ba Loc', email = 'locnguyenba@vti.com.vn'
WHERE	account_id = 5;

-- 14. update account co id = 5 se thuoc group id = 4

UPDATE	group_accounts
SET		group_id = 4
WHERE	account_id = 5;

