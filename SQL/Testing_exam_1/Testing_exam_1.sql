-- 1. Tạo table với các ràng buộc và kiểu dữ liệu. Thêm ít nhất 5 bản ghi vào table.

CREATE DATABASE IF NOT EXISTS sale;
USE sale;

CREATE TABLE customers
(
	customer_id		TINYINT UNSIGNED AUTO_INCREMENT,
    `name`			VARCHAR(50),
    phone			CHAR(15),
    email			VARCHAR(50),
    address			VARCHAR(100),
    note			TEXT,
PRIMARY KEY	(customer_id)
);

CREATE TABLE cars
(
	car_id			TINYINT,
    maker			ENUM('HONDA', 'TOYOTA', 'NISSAN'),
    model			CHAR(10),
    `year`			YEAR,
    color			VARCHAR(10),
    note			TEXT,
PRIMARY KEY (car_id)
);

CREATE TABLE car_orders
(
	order_id			TINYINT UNSIGNED AUTO_INCREMENT,
    customer_id			TINYINT UNSIGNED,
    car_id				TINYINT,
    amount				TINYINT	DEFAULT 1,
    sale_price			DECIMAL(8,2),
    order_date			DATE,
    delivery_date		DATE,
    delivery_address	VARCHAR(150),
    `status`			ENUM('0', '1', '2') DEFAULT '0',
    note 				TEXT,
PRIMARY KEY (order_id),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (car_id) REFERENCES cars(car_id)
);

-- Insert data

INSERT INTO customers (`name`	, phone		, email							, address		, note)
VALUES				('alex'		, 3344556677, 'franecki.irving@example.net'	, 'Ha Noi'		, 'thieu gia'),
					('brie'		, 3456765432, 'milford85@example.net'		, 'TP.Ho Chi Minh', 'mua xe de kinh doanh'),
                    ('john'		, 3567864321, 'iadams@example.net'			, 'Da Nang'		, 'thieu gia'),
                    ('thompson'	, 3145673412, 'koelpin.brooklyn@example.net', 'Thanh Hoa'	, 'giao hang som'),
                    ('vanessa'	, 3863532621, 'gprohaska@example.org'		, 'Can Tho'		, 'dai gia');
                    
INSERT INTO cars (car_id, maker		, model	, `year`, color		, note)
VALUES			(1		, 'HONDA'	, 'H001', 2017	, 'black'	, 'xe dien 4 cho'),
				(2		, 'NISSAN'	, 'N001', 2019	, 'white'	, 'xe 7 cho'),
                (3		, 'TOYOTA'	, 'T001', 2020	, 'white'	, 'xe ban tai'),
                (4		, 'NISSAN'	, 'N002', 2013	, 'gray'	, 'xe 4 cho'),
                (5		, 'TOYOTA'	, 'T001', 2012	, 'yellow'	, 'xe the thao');

INSERT INTO car_orders (customer_id	, car_id, amount, sale_price, order_date	, delivery_date	, delivery_address	, `status`	, note)
VALUES					(1			, 5		, 2		, 10000.50	, '2020-10-13'	, '2020-11-12'	, 'Ha Noi'			, '1'			, 'da nhan hang'),
						(2			, 5		, 1		, 12500.00	, '2021-06-26'	, '2021-07-25'	, 'TP.Ho Chi Minh'	, '1'			, 'da nhan hang'),
						(4			, 3		, 1		, 15000.50	, '2020-09-12'	, NULL			, 'Da Nang'			, '0'			, 'chua giao hang'),
						(4			, 2		, 2		, 7500.00	, '2021-01-21'	, '2021-02-20'	, 'Thanh Hoa'		, '1'			, 'da nhan hang'),
						(5			, 4		, 3		, 6000.5	, '2020-03-22'	, NULL			, 'Can Tho'			, '2'			, 'da huy dat hang');
                        

-- 2. Viết lệnh lấy ra thông tin của khách hàng: tên, số lượng oto khách hàng đã
-- mua và sắp sếp tăng dần theo số lượng oto đã mua.

SELECT	cu.`name`,
        SUM(co.amount) so_oto_da_mua
FROM	customers cu
INNER JOIN	car_orders co
	ON	cu.customer_id = co.customer_id
WHERE	co.delivery_date IS NOT NULL
GROUP BY	cu.`name`
ORDER BY	SUM(co.amount);

-- 3. Viết hàm (không có parameter) trả về tên hãng sản xuất đã bán được nhiều
-- oto nhất trong năm nay.

DELIMITER //
CREATE FUNCTION ban_hang () RETURNS CHAR(10) DETERMINISTIC
	BEGIN    
		DECLARE	hang_xe CHAR(10);
        SELECT 	ca.maker INTO hang_xe               
		FROM	cars ca
        INNER JOIN	car_orders co
			ON	ca.car_id = co.car_id
		WHERE	co.delivery_date IS NOT NULL AND YEAR(co.delivery_date) = YEAR(NOW())
        GROUP BY	ca.maker
			HAVING	SUM(co.amount) = (SELECT SUM(amount)
									FROM	car_orders
                                    WHERE	delivery_date IS NOT NULL AND YEAR(delivery_date) = YEAR(NOW())
                                    GROUP BY	car_id
                                    ORDER BY	SUM(amount) DESC
                                    LIMIT 1);
		RETURN	hang_xe;
	END//
DELIMITER ;

SELECT	ban_hang();
        
-- 4. Viết 1 thủ tục (không có parameter) để xóa các đơn hàng đã bị hủy của
-- những năm trước. In ra số lượng bản ghi đã bị xóa.

DROP PROCEDURE IF EXISTS xoa_don_hang;
DELIMITER //
CREATE PROCEDURE xoa_don_hang ()
	BEGIN
		SELECT COUNT(*) FROM car_orders WHERE `status` = '2' AND YEAR(order_date) < YEAR(NOW());
        DELETE FROM	car_orders WHERE `status` = '2' AND YEAR(order_date) < YEAR(NOW());
	END//
DELIMITER ;

CALL xoa_don_hang();

-- 5. Viết 1 thủ tục (có CustomerID parameter) để in ra thông tin của các đơn
-- hàng đã đặt hàng bao gồm: tên của khách hàng, mã đơn hàng, số lượng oto và tên hãng sản xuất.   
                     
DROP PROCEDURE IF EXISTS don_hang_da_dat;
DELIMITER //
CREATE PROCEDURE don_hang_da_dat (IN id_khach_hang INT)
	BEGIN
		SELECT 	cu.`name`,
				co.order_id,
                co.amount,
                ca.maker
		FROM	customers cu
		INNER JOIN	car_orders co
			ON	cu.customer_id = co.customer_id
		INNER JOIN	cars ca
			ON	ca.car_id = co.car_id
		WHERE 	cu.customer_id = id_khach_hang AND co.`status` = '0';
	END//
DELIMITER ;

CALL don_hang_da_dat(4);

