USE testing_system;
SELECT	*	FROM	positions;
SELECT	*	FROM	accounts;
SELECT	*	FROM	departments;

-- 1. Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ 

SELECT	a.fullname,
		d.department_id,
        d.department_name
FROM	accounts a
LEFT JOIN	departments d
	ON	a.department_id = d.department_id; 
    
-- 2. Viết lệnh để lấy ra thông tin các account được tạo sau ngày 8/4/2020  

SELECT	*
FROM 	accounts a
WHERE	create_date > '2020/4/8';

-- 3. Viết lệnh để lấy ra tất cả các developer  

SELECT	*
FROM	accounts a
INNER JOIN	positions p
	ON	p.position_id = a.position_id
WHERE	p.position_name = 'Dev';

-- 4. Viết lệnh để lấy ra danh sách các phòng ban có > 3 nhân viên 

SELECT	d.department_name
FROM	departments d
LEFT JOIN	accounts a
	ON	d.department_id = a.department_id
GROUP BY	d.department_id
	HAVING	COUNT(*) >= 3;
    
-- 5. Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất

SELECT	e.question_id,
		q.content
FROM	exam_questions e
INNER JOIN	questions q
	ON	e.question_id = q.question_id
GROUP BY	e.question_id
	HAVING	COUNT(e.question_id) = (SELECT	COUNT(question_id) 
									FROM	exam_questions
                                    GROUP BY	question_id
									ORDER BY	COUNT(question_id) DESC
                                    LIMIT	1);

-- 6. Thông kê mỗi category Question được sử dụng trong bao nhiêu Question

SELECT	c.category_name,
		c.category_id,
        COUNT(c.category_id) solan
FROM	category_questions c
LEFT JOIN	questions q
	ON	c.category_id = q.category_id
GROUP BY	c.category_id;

 
-- 7. Thông kê mỗi Question được sử dụng trong bao nhiêu Exam 

SELECT	q.question_id,
        COUNT(eq.question_id) solan,
        q.content
FROM	exam_questions eq
RIGHT JOIN	questions q
	ON	eq.question_id = q.question_id
GROUP BY	q.question_id;

-- 8. Lấy ra Question có nhiều câu trả lời nhất 

SELECT	q.content,
		COUNT(a.question_id) so_lan
FROM	questions q
LEFT JOIN	answers a
	ON	q.question_id = a.question_id
GROUP BY	q.question_id
	HAVING	COUNT(a.question_id) = (SELECT	COUNT(question_id)
									FROM	answers
									GROUP BY	question_id
									ORDER BY	COUNT(question_id) DESC
									LIMIT	1);

-- 9. Thống kê số lượng account trong mỗi group  
    
SELECT	g.group_name,
        COUNT(ga.group_id) so_accounts
FROM	group_accounts ga
RIGHT JOIN	`groups` g
	ON	ga.group_id = g.group_id
WHERE	ga.group_id IS NULL OR ga.group_id IS NOT NULL
GROUP BY	g.group_name
ORDER BY	COUNT(ga.group_id) DESC;

-- 10. Tìm chức vụ có ít người nhất  

SELECT	p.position_name,
		COUNT(p.position_id) so_nhan_vien
FROM	positions p
RIGHT JOIN	accounts a
	ON	p.position_id = a.position_id
GROUP BY	a.position_id
	HAVING	COUNT(p.position_id) = (SELECT	COUNT(position_id)
									FROM	accounts
									GROUP BY	position_id
									ORDER BY	COUNT(position_id)
									LIMIT 	1);

-- 11. Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM  

SELECT	d.department_name;
		

-- 12. Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
-- question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, … 

SELECT	q.question_id,
		q.content,
		q.type_id,
        q.create_date,
        q.category_id,
        cq.category_name,
        an.content,
        an.iscorrect,
        ac.username,
        ac.fullname,
        ac.email,
        ac.gender,
        ac.department_id,
        ac.position_id
FROM	questions q
LEFT JOIN	category_questions cq
	ON	q.category_id = cq.category_id
LEFT JOIN	answers an
	ON	q.question_id = an.question_id
LEFT JOIN	accounts ac
	ON	ac.account_id = q.creator_id;    

-- 13. Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm 

SELECT	tq.type_name,	
		COUNT(q.type_id) so_cau_hoi
FROM	questions q
LEFT JOIN	type_questions tq
	ON	q.type_id = tq.type_id
GROUP BY	tq.type_name;

-- 14.Lấy ra group không có account nào 

SELECT	g.group_name
FROM	`groups` g
LEFT JOIN	group_accounts ga
	ON	g.group_id = ga.group_id
WHERE	ga.group_id IS NULL;

-- 15. Lấy ra group không có account nào 
-- 16. Lấy ra question không có answer nào 

SELECT	q.content
FROM	questions q
LEFT JOIN	answers a
	ON	q.question_id = a.question_id
WHERE	a.question_id IS NULL;

