-- Add data Department
-- INSERT INTO departments(department_name)
-- VALUES
-- 						(N'Marketing'	),
-- 						(N'Sale'		),
-- 						(N'Bảo vệ'		),
-- 						(N'Nhân sự'		),
-- 						(N'Kỹ thuật'	),
-- 						(N'Tài chính'	),
-- 						(N'Phó giám đốc'),
-- 						(N'Giám đốc'	),
-- 						(N'Thư kí'		),
-- 						(N'Bán hàng'	);

-- -- Add data position
-- INSERT INTO positions(position_name) 
-- VALUES 					('Dev'			),
-- 						('Test'			),
-- 						('Scrum Master'	),
-- 						('PM'			); 

-- INSERT INTO `accounts`(email							, username			, fullname				, department_id	, position_id, create_date)
-- VALUES 				('haidang29productions@gmail.com'	, 'dangblack'		,'Nguyễn hải Đăng'		,   '5'			,   '1'		,'2020-03-05'),
-- 					('account1@gmail.com'				, 'quanganh'		,'Nguyen Chien Thang2'	,   '1'			,   '2'		,'2020-03-05'),
--                     ('account2@gmail.com'				, 'vanchien'		,'Nguyen Van Chien'		,   '2'			,   '3'		,'2020-03-07'),
--                     ('account3@gmail.com'				, 'cocoduongqua'	,'Duong Do'				,   '3'			,   '4'		,'2020-03-08'),
--                     ('account4@gmail.com'				, 'doccocaubai'		,'Nguyen Chien Thang1'	,   '4'			,   '4'		,'2020-03-10'),
--                     ('dapphatchetngay@gmail.com'		, 'khabanh'			,'Ngo Ba Kha'			,   '6'			,   '3'		,'2020-04-05'),
--                     ('songcodaoly@gmail.com'			, 'huanhoahong'		,'Bui Xuan Huan'		,   '7'			,   '2'		, NULL		),
--                     ('sontungmtp@gmail.com'				, 'tungnui'			,'Nguyen Thanh Tung'	,   '8'			,   '1'		,'2020-04-07'),
--                     ('duongghuu@gmail.com'				, 'duongghuu'		,'Duong Van Huu'		,   '9'			,   '2'		,'2020-04-07'),
--                     ('vtiaccademy@gmail.com'			, 'vtiaccademy'		,'Vi Ti Ai'				,   '10'		,   '1'		,'2020-04-09');

INSERT INTO exam_questions (exam_id, question_id)
VALUES 						(11		,	11),
							(12		,	12),
                            (13		,	13),
                            (14		,	14),
                            (15		,	15),
                            (16		,	16),
                            (17		,	17),
                            (18		,	18),
                            (19		,	19),
                            (20		,	20);

INSERT INTO departments (department_name)
VALUES					(N'Sale'),
						(N'Marketing'),
                        (N'Nhân sự'),
                        (N'Kế toán'),
                        (N'Giám đốc'),
                        (N'Bảo vệ'),
                        (N'Nhân viên'),
                        (N'Kỹ thuật'),
                        (N'Thực tập'),
                        (N'Tài chính');
        
INSERT INTO positions (position_name)
VALUES					('Dev'),
						('Test'),
                        ('Scrum Master'),
                        ('PM');
        
INSERT INTO accounts (email							, username			, fullname				, gender, department_id	, position_id	, create_date)
VALUES				('franecki.irving@example.net'	, 'reynold03'		, 'Kasey Erdman I'		, 1		, 9				, 2				, '2001-05-06'),
					('milford85@example.net'		, 'fkassulke'		, 'Doris Emmerich DVM'	, 1		, 6				, 1				, '2003-11-12'),
                    ('iadams@example.net'			, 'elian.batz'		, 'Doris Emmerich DVM'	, 0		, 4				, 4				, '2003-11-30'),
                    ('koelpin.brooklyn@example.net'	, 'kwaters'			, 'Taryn Waelchi'		, 0		, 3				, 3				, '2018-03-30'),
                    ('gprohaska@example.org'		, 'shilpert'		, 'Mr. Ruben Botsford'	, NULL	, 8				, 2				, '2013-03-26'),
                    ('nmccullough@example.net'		, 'joey.kunze'		, 'Wilson Maggio'		, 0		, 7				, 4				, '2004-04-03'),
                    ('name89@example.org'			, 'pdickens'		, 'Evan Roberts'		, 1		, 2				, 1				, '2000-03-09'),
                    ('nlind@example.org'			, 'ruecker.bryon'	, 'Malachi Smith I'		, 1		, 1				, 1				, '2004-04-14'),
                    ('kschultz@example.net'			, 'dax51'			, 'Alexa Koepp Sr.'		, 0		, 5				, 2				, '1997-04-26'),
                    ('tskiles@example.com'			, 'emery.ferry'		, 'Kelvin Von'			, NULL	, 10			, 4				, '2001-09-15');

INSERT INTO  category_questions (category_name)
VALUES							('ullam'		),
								('omnis'		),
                                ('ipsa'			),
                                ('et'			),
                                ('quaerat'		),
                                ('repellendus'	),
                                ('iste'			),
                                ('dolorum'		),
                                ('quis'			),
                                ('dolores'		);
					
INSERT INTO exams (`code`	, title														, category_id	, duration	, creator_id	, createdate)
VALUES				('wqek'	, 'Nisi ut repudiandae voluptatem eligendi.'				, 5				, 90		, 11				, '2002-09-25'),
					('tnwy'	, 'Aperiam voluptates atque quasi aspernatur quia aut non.'	, 3				, 90		, 15				, '2010-06-17'),
                    ('zxyp'	, 'Repellendus unde quidem ipsum atque.'					, 4				, 90		, 16				, '2021-01-04'),
                    ('ujna'	, 'Ducimus qui itaque impedit numquam.'						, 6				, 90		, 17				, '1978-10-21'),
                    ('rshk'	, 'Ipsum laboriosam earum quo est eaque.'					, 8				, 90		, 15				, '2003-10-22'),
                    ('lrle'	, 'Aut ipsum beatae reprehenderit error odit.'				, 10			, 90		, 18				, '2011-06-04'),
                    ('kzfk'	, 'Enim est voluptas ex aliquam nobis optio voluptates.'	, 1				, 90		, 12				, '2021-08-03'),
                    ('ukzb'	, 'Aperiam facilis totam praesentium molestias assumenda.'	, 9				, 90		, 19				, '1987-04-19'),
                    ('bfzm'	, 'Aspernatur deserunt aut sit perferendis qui et debitis.'	, 2				, 90		, 17				, '1982-06-30'),
                    ('xswa'	, 'Sequi aliquam sit cupiditate dolor.'						, 7				, 90		, 14				, '1983-04-24');

INSERT INTO group_accounts (account_id	, join_date		, group_id)
VALUES						(11			, '1971-05-07'	, 11),
							(12			, '2000-08-16'	, 12),
                            (13			, '1980-07-18'	, 13),
                            (14			, '1973-02-06'	, 14),
                            (15			, '1970-09-18'	, 15),
                            (16			, '1998-10-24'	, 16),
                            (17			, '2008-08-22'	, 17),
                            (18			, '1993-09-01'	, 18),
                            (19			, '2000-12-19'	, 19),
                            (20			, '2018-11-24'	, 20);

INSERT INTO `groups` (group_name, creator_id, create_date)
VALUES				('nulla'	, 12			, '2008-10-11'),
					('sint'		, 15			, '1981-12-14'),
                    ('culpa'	, 12			, '1995-11-20'),
                    ('est'		, 11			, '2000-09-16'),
                    ('aut'		, 17			, '1993-10-30'),
                    ('quo'		, 18			, '1993-09-18'),
                    ('maxime'	, 20			, '1984-05-13'),
                    ('aliquid'	, 15			, '2001-08-02'),
                    ('unde'		, 14			, '2009-11-14'),
                    ('facilis'	, 16			, '1990-10-29');
                    
INSERT INTO questions (content, category_id, type_id, creator_id, create_date)
VALUES				('Pariatur sint sunt tenetur dolores. Asperiores vero rerum et doloremque. Atque quibusdam qui aliquid ad repudiandae ratione. Rerum aut et tenetur aut. Quidem qui eos voluptas ducimus nobis rerum ab.'	, 5		, 8		, 15		, '1979-11-13'),
					('Harum perspiciatis id ut porro ex. Ipsa est voluptatum odio quidem quia velit rerum consequatur.'																											, 7		, 2		, 17		, '1986-06-26'),
                    ('Illum sed aut ducimus excepturi autem. Ut eum id voluptatem laboriosam. Quo nobis tempora architecto.'																									, 2		, 10	, 14		, '2018-09-12'),
                    ('Enim qui nesciunt reprehenderit esse. Ex error delectus eos rerum. At fugiat facilis necessitatibus qui. Vel dicta dolorem exercitationem vel cumque debitis.'											, 5		, 4		, 12		, '2015-11-21'),
                    ('Dignissimos amet laboriosam sequi aliquid itaque et quod ipsum. Recusandae totam eos aspernatur quae optio rem. Incidunt voluptas ab reprehenderit nisi.'													, 1		, 3		, 19		, '2017-03-22'),
                    ('Fuga consequuntur alias voluptas quia nulla ratione nam. Voluptatum non distinctio rerum sapiente nemo blanditiis. Aut dolores dolores inventore in soluta velit.'										, 9		, 7		, 12		, '2013-12-01'),
                    ('Nesciunt recusandae mollitia quas nihil perspiciatis nulla. Aut nesciunt perspiciatis mollitia. Quae non delectus nihil dolores ea. Nihil omnis quis dignissimos magni.'									, 3		, 5		, 11		, '2008-11-14'),
                    ('Velit asperiores qui impedit sed corrupti ut nostrum. Harum cum a est est et. Accusantium et nostrum omnis dolorum. Dolor optio omnis architecto.'														, 10	, 7		, 16		, '1982-11-11'),
                    ('Recusandae maiores a eos aliquam. Laboriosam quis aperiam ut sapiente esse. Sed quas et sit.'																												, 8		, 9		, 12		, '2011-10-03'),
                    ('Sed cum dolores repellat natus ut aperiam illum aspernatur. Quibusdam reprehenderit rerum dolores est optio. Sequi quod aliquam qui similique amet. Dolorem qui ut nobis.'								, 4		, 3		, 18		, '1971-12-20');
                    
INSERT INTO type_questions (type_name)
VALUES						('essay'),
							('essay'),
                            ('multiple_choice'),
                            ('essay'),
                            ('essay'),
                            ('multiple_choice'),
                            ('essay'),
                            ('essay'),
                            ('multiple_choice'),
                            ('multiple_choice');






















