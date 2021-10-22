SELECT * FROM detai;
SELECT * FROM giangvien;
SELECT * FROM huongdan;
SELECT * FROM khoa;
SELECT * FROM sinhvien;

-- 1.	Đưa ra thông tin gồm mã số, họ tên và tên khoa của tất cả các giảng viên

SELECT	g.magv,
		g.hotengv,
        k.tenkhoa
FROM	giangvien g
INNER JOIN	khoa k
	ON	g.makhoa = k.makhoa;

-- 2.	Đưa ra thông tin gồm mã số, họ tên và tên khoa của các giảng viên của khoa ‘DIA LY va QLTN’

SELECT	g.magv,
		g.hotengv,
        k.tenkhoa
FROM 	giangvien g
INNER JOIN	khoa k
	ON	g.makhoa = k.makhoa
WHERE	k.tenkhoa = 'DIA LY va QLTN';

-- 3.	Cho biết số sinh viên của khoa ‘CONG NGHE SINH HOC’

SELECT	COUNT(s.masv) AS 'So sinh vien'
FROM	sinhvien s
INNER JOIN	khoa k
	ON	s.makhoa = k.makhoa
WHERE	k.tenkhoa = 'CONG NGHE SINH HOC';

-- 4.	Đưa ra danh sách gồm mã số, họ tên và tuổi của các sinh viên khoa ‘TOAN’

SELECT	sv.masv,
		sv.hotensv,
        CASE
			WHEN 2021 - IFNULL(sv.namsinh, 0) = 2021 THEN 'khong co thong tin'
            ELSE 2021 - IFNULL(sv.namsinh, 0)
		END AS tuoi
FROM	khoa k
RIGHT JOIN	sinhvien sv
	ON	k.makhoa = sv.makhoa
WHERE	k.tenkhoa = 'TOAN';       

-- 5.	Cho biết số giảng viên của khoa ‘CONG NGHE SINH HOC’

SELECT	COUNT(gv.magv) so_giang_vien
FROM	giangvien gv
INNER JOIN	khoa k
	ON	gv.makhoa = k.makhoa
WHERE	k.tenkhoa = 'CONG NGHE SINH HOC';

-- 6.	Cho biết thông tin về sinh viên không tham gia thực tập

SELECT	sv.*
FROM	sinhvien sv
LEFT JOIN	huongdan hd
	ON	sv.masv = hd.masv
WHERE	hd.madt IS NULL;

-- 7.	Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa

SELECT	k.makhoa,
		k.tenkhoa,
		COUNT(gv.magv) so_giang_vien
FROM	khoa k
RIGHT JOIN	giangvien gv
	ON	k.makhoa = gv.makhoa
GROUP BY	k.makhoa;

-- 8.	Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học

SELECT	k.dienthoai, sv.hotensv
FROM	khoa k
INNER JOIN	sinhvien sv
	ON	k.makhoa = sv.makhoa
WHERE 	sv.hotensv = 'le van son';

-- 9.	Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn

SELECT	dt.madt,
		dt.tendt
FROM	detai dt
INNER JOIN	huongdan hd
	ON	dt.madt = hd.madt
INNER JOIN	giangvien gv
	ON	gv.magv = hd.magv
WHERE	gv.hotengv = 'tran son';

-- 10.	Cho biết tên đề tài không có sinh viên nào thực tập

SELECT	dt.*
FROM 	detai dt
LEFT JOIN	huongdan hd
	ON	dt.madt = hd.madt
WHERE	hd.madt IS NULL;

-- 11.	Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 2 sinh viên trở lên.

SELECT	gv.magv,
		gv.hotengv,
		gv.makhoa,
        COUNT(hd.masv) so_sv
FROM	giangvien gv
INNER JOIN	huongdan hd
	ON	gv.magv = hd.magv
GROUP BY	gv.magv
	HAVING	COUNT(hd.masv) >= 2;

-- 12.	Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất

SELECT	madt,
		tendt,
        kinhphi
FROM	detai dt
WHERE 	kinhphi = (SELECT MAX(kinhphi)
					FROM detai);

-- 13.	Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập

SELECT	dt.madt,
		dt.tendt
FROM	detai dt
INNER JOIN	huongdan hd
	ON	dt.madt = hd.madt
GROUP BY 	dt.madt
	HAVING	COUNT(hd.masv) > 2;

-- 14.	Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIALY và QLTN’

SELECT	sv.masv,
		sv.hotensv,
		hd.ketqua
FROM	sinhvien sv
INNER JOIN	huongdan hd
	ON	sv.masv = hd.masv
INNER JOIN	khoa k
	ON	sv.makhoa = k.makhoa
WHERE 	k.tenkhoa = 'dia ly va qltn';

-- 15.	Đưa ra tên khoa, số lượng sinh viên của mỗi khoa

SELECT	k.tenkhoa,
		COUNT(sv.masv) so_sv
FROM	khoa k
INNER JOIN	sinhvien sv
	ON	k.makhoa = sv.makhoa
GROUP BY	k.makhoa;

-- 16.	Cho biết thông tin về các sinh viên thực tập tại quê nhà

SELECT 	sv.*
FROM	sinhvien sv
INNER JOIN	huongdan hd
	ON	sv.masv = hd.masv
INNER JOIN	detai dt
	ON	hd.madt = dt.madt
WHERE dt.noithuctap = sv.quequan;

-- 17.	Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập

SELECT	sv.*
FROM	sinhvien sv
RIGHT JOIN	huongdan hd
	ON	sv.masv = hd.masv
WHERE	hd.ketqua IS NULL;

-- 18.	Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0

SELECT	sv.masv,
		sv.hotensv
FROM 	sinhvien sv
INNER JOIN	huongdan hd
	ON	sv.masv = hd.masv
WHERE	hd.ketqua = 0;
