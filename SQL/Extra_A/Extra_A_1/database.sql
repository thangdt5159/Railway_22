DROP DATABASE IF EXISTS thuctap;
CREATE DATABASE IF NOT EXISTS thuctap;
USE thuctap;

CREATE TABLE khoa
(
	makhoa		CHAR(10),
    tenkhoa		CHAR(30),
    dienthoai	CHAR(10),
PRIMARY KEY (makhoa)
);

CREATE TABLE giangvien
(
	magv	INT UNSIGNED AUTO_INCREMENT,
	hotengv	CHAR(30),
    luong	DECIMAL(5,2),
    makhoa	CHAR(10),
PRIMARY KEY (magv),
FOREIGN KEY (makhoa) REFERENCES khoa(makhoa) ON DELETE CASCADE
);

CREATE TABLE sinhvien
(
	masv	INT UNSIGNED AUTO_INCREMENT,
    hotensv	CHAR(30),
    makhoa	CHAR(10),
    namsinh	INT,
    quequan	CHAR(30),
PRIMARY KEY (masv),
FOREIGN KEY (makhoa) REFERENCES khoa(makhoa) ON DELETE CASCADE
);

CREATE TABLE detai
(
	madt		CHAR(10),
    tendt		CHAR(30),
    kinhphi		INT,
    noithuctap	CHAR(30),
PRIMARY KEY (madt)
);

CREATE TABLE huongdan
(
	masv	INT UNSIGNED,
    madt	CHAR(10),
    magv	INT UNSIGNED,
    ketqua	DECIMAL(5.2),
PRIMARY KEY (masv),
FOREIGN KEY (masv) REFERENCES sinhvien(masv) ON DELETE CASCADE,
FOREIGN KEY (madt) REFERENCES detai(madt) ON DELETE CASCADE,
FOREIGN KEY (magv) REFERENCES giangvien(magv) ON DELETE CASCADE
);