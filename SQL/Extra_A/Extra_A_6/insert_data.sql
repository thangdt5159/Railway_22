INSERT INTO employee(employee_last_name, employee_first_name, employee_hire_date, employee_status, supervisor_id, social_security_number )
VALUES				('Thang'			, 'Do'				, '2017/7/23' 		, 'Active' 		, NULL			, '2468086431'),
					('Toan'				, 'Tran'			, '2020/11/12' 		, 'Active' 		, '1'			, '2986703576'),
                    ('Linh'				, 'Duong'			, '2021/1/2' 		, 'Active' 		, '2'			, '2985673576'),
                    ('Duong'			, 'Le' 				, '2015/5/5' 		, 'Deactive' 	, '2'			, '2658967743');
                    
INSERT INTO projects(manager_id, project_name, project_start_date, project_description, project_detail, project_completed_on)
VALUES				('1' 		, 'Sql' 	, '2021/6/20' 		, 'lam ve sql' 		, 'Sql trigger' , NULL 			),
					('2' 		, 'Java' 	, '2021/8/9' 		, 'lam ve java' 	, NULL 			, '2021/10/20' 	),
                    ('3' 		, 'Python' 	, '2021/4/17' 		, 'lam ve python' 	, NULL 			, NULL 		 	),
                    ('4' 		, 'C++' 	, '2021/7/19' 		, 'lam ve C++' 		, NULL 			, NULL 			);
                    
INSERT INTO project_modules(project_id, employee_id, project_module_date, project_module_completed_on, project_module_description)
VALUES						('1' 	, '1' 			, '2021/8/15' 		, '2021/8/22' 				, 'sql co ban' 		),
							('2' 	, '2' 			, '2021/9/1' 		, '2021/9/15' 				, 'java core' 		),
                            ('2' 	, '3' 			, '2021/10/5' 		, NULL 						, 'java script' 	),
							('3' 	, '4' 			, '2021/7/18' 		, '2021/7/10' 				, 'python co ban' 	);
                    
INSERT INTO work_done(employee_id, module_id, work_done_date, work_done_description 		, work_done_status)
VALUES				('2' 		, '1' 		, '2021/8/22' 	, 'hoan thanh phan sql co ban' 	, 'da hoan thanh'),
					('2' 		, '2' 		, '2021/9/15' 	, 'hoan thanh phan java core' 	, 'da hoan thanh'),
                    ('3' 		, '3' 		, NULL 			, 'hoan thanh duoc 3/4' 		, 'hoan thanh 76%'),
                    ('4' 		, '4' 		, '2021/7/10' 	, 'hoan thanh phan python co ban', 'da hoan thanh');