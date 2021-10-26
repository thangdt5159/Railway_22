-- 1. Viết lệnh để lấy ra danh sách nhân viên (name) có skill Java (sử dụng UNION)

SELECT	et.employee_name,
		est.skill_code
FROM	employee_table et
INNER JOIN	employee_skill_table est
	ON	et.employee_number = est.employee_number
WHERE 	est.skill_code = 'Java';

-- 2. Viết lệnh để lấy ra danh sách các phòng ban có > 3 nhân viên

SELECT	d.*
FROM	department d
INNER JOIN	employee_table et
	ON	d.department_number = et.department_number
GROUP BY	et.department_number
	HAVING	COUNT(et.department_number) >= 2;

-- 3. Viết lệnh để lấy ra danh sách nhân viên của mỗi phòng ban (sử dụng GROUP BY)

SELECT	et.employee_number,
		et.employee_name,
		department_name
FROM	employee_table et
RIGHT JOIN	department d
	ON	et.department_number = d.department_number
GROUP BY	d.department_name;

-- 4. Viết lệnh để lấy ra danh sách nhân viên có > 1 skill (sử dụng DISTINCT)
                                
SELECT DISTINCT est.skill_code,
				et.*
FROM	employee_skill_table est
INNER JOIN	employee_table et
	ON	est.employee_number = et.employee_number
