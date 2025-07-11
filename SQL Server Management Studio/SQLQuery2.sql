CREATE TABLE Product (
id INT IDENTITY(1,1) PRIMARY KEY,
-- ID tự động tăng, khóa chính
name NVARCHAR(255) NOT NULL,
price DECIMAL(10,2) NOT NULL, 
description NVARCHAR(500),

stock INT NOT NULL DEFAULT 0, 
import_date DATETIME DEFAULT
GETDATE() 
);

INSERT INTO Product (name, price,
description, stock) VALUES
(N'Laptop Dell XPS 13', 1500.00,
N'Máy tính xách tay Dell hiệu suất
cao', 10),
(N'Laptop MacBook Pro 14', 2200.00,
N'Máy tính xách tay Apple với chip
M2', 15),
(N'Smartphone iPhone 14', 999.99,
N'Điện thoại Apple iPhone 14 mới
nhất', 20),
(N'Smartphone Samsung Galaxy S23',
899.99, N'Điện thoại Samsung
flagship', 25),
(N'Tai nghe Sony WH-1000XM5', 349.99,
N'Tai nghe chống ồn cao cấp', 30),
(N'Tai nghe AirPods Pro 2', 249.99,
N'Tai nghe không dây của Apple', 18),
(N'Màn hình LG UltraFine 5K',
1299.99, N'Màn hình 5K dành cho thiết
kế'
, 8),

(N'Màn hình Dell UltraSharp 32"',
999.99, N'Màn hình 4K với màu sắc
chính xác', 12),
(N'Bàn phím cơ Keychron K6', 99.99,
N'Bàn phím cơ không dây có đèn nền',
50),
(N'Chuột Logitech MX Master 3',
119.99, N'Chuột không dây dành cho
dân văn phòng', 40),
(N'Ổ cứng SSD Samsung 1TB', 150.00,
N'Ổ SSD NVMe tốc độ cao', 35),
(N'Ổ cứng HDD Seagate 4TB', 100.00,
N'Ổ cứng lưu trữ dung lượng lớn',
28),
(N'Camera GoPro Hero 11', 499.99,
N'Camera hành trình 4K chống nước',
22),
(N'Máy ảnh Sony A7 IV', 2500.00,
N'Máy ảnh mirrorless chuyên nghiệp',
5),
(N'Micro Rode NT1-A', 229.99, N'Micro
thu âm chất lượng cao', 17),
(N'Bộ phát WiFi TP-Link AX3000',
129.99, N'Router WiFi 6 tốc độ cao',
20),
(N'Pin sạc dự phòng Anker 20000mAh'
,
49.99, N'Pin sạc nhanh dung lượng
lớn', 60),

(N'Loa Bluetooth JBL Charge 5',
149.99, N'Loa không dây chống nước',
32),
(N'Máy chơi game PlayStation 5',
499.99, N'Console PS5 phiên bản tiêu
chuẩn', 10),
(N'Bộ điều khiển Xbox Series X',
59.99, N'Tay cầm chơi game không
dây', 45);
UPDATE Product
SET import_date = GETDATE()
WHERE import_date IS NULL;