INSERT INTO khoa(makhoa	, tenkhoa				, dienthoai)
VALUES			('Geo'	, 'Dia ly va QLTN'		, 3855413),
				('Math'	, 'Toan'				, 3855411),
				('Bio'	, 'Cong nghe Sinh hoc'	, 3855412);
INSERT INTO giangvien (hotengv		, luong	, makhoa)
VALUES				('Thanh Binh'	, 700	, 'Geo'),    
					('Thu Huong'	, 500	, 'Math'),
					('Chu Vinh'		, 650	, 'Geo'),
					('Le Thi Ly'	, 500	, 'Bio'),
					('Tran Son'		, 900	, 'Math');
INSERT INTO sinhvien (hotensv			, makhoa, namsinh, quequan)
VALUES				('Le Van Son'		, 'Bio'	, 1990	, 'Nghe An'),
					('Nguyen Thi Mai'	, 'Geo'	, 1990	, 'Thanh Hoa'),
					('Bui Xuan Duc'		, 'Math', 1992	, 'Ha Noi'),
					('Nguyen Van Tung'	, 'Bio'	, NULL	, 'Ha Tinh'),
					('Le Khanh Linh'	, 'Bio'	, 1989	, 'Ha Nam'),
					('Tran Khac Trong'	, 'Geo'	, 1991	, 'Thanh Hoa'),
					('Le Thi Van'		, 'Math', NULL	, NULL),
					('Hoang Van Duc'	, 'Bio'	, 1992	, 'Nghe An');
INSERT INTO detai (madt, tendt			, kinhphi, noithuctap)
VALUES			('Dt01', 'GIS'			, 100	, 'Nghe An'),
				('Dt02', 'ARC GIS'		, 500	, 'Nam Dinh'),
				('Dt03', 'Spatial DB'	, 100	, 'Ha Tinh'),
				('Dt04', 'MAP'			, 300	, 'Quang Binh');
INSERT INTO huongdan (masv, madt, magv	, ketqua)
	VALUES			(1	, 'Dt01', 3	, 8),
					(2	, 'Dt03', 4	, 0),
					(3	, 'Dt03', 2	, 10),
					(5	, 'Dt04', 4	, 7),
					(6	, 'Dt01', 3	, Null),
					(7	, 'Dt04', 1	, 10),
					(8	, 'Dt03', 5	, 6);
                    

