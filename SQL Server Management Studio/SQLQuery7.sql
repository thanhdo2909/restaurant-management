CREATE TABLE products (
    id INT PRIMARY KEY IDENTITY(1,1),  -- Tự động tăng ID
    name NVARCHAR(255) NOT NULL,        -- Dùng NVARCHAR để hỗ trợ tiếng Việt
    description NVARCHAR(MAX),          -- Hỗ trợ mô tả dài
    price FLOAT NOT NULL,               -- Giá sản phẩm
    stock INT NOT NULL,                 -- Số lượng tồn kho
    categoryId INT NOT NULL,             -- ID danh mục
    imageUrl NVARCHAR(255),              -- Đường dẫn ảnh
    seller_id INT NOT NULL               -- ID người bán
);

INSERT INTO products (name, description, price, stock, categoryId, imageUrl, seller_id) VALUES
(N'Xi măng Hà Tiên', N'Xi măng chất lượng cao, phù hợp cho xây dựng nhà ở.', 80.5, 100, 1, 'images/ximang_hatien.jpg', 1),
(N'Gạch đỏ ống', N'Gạch nung truyền thống, độ bền cao.', 3.2, 500, 2, 'images/gach_do.jpg', 2),
(N'Gạch lát nền 60x60', N'Gạch men cao cấp, chống trơn trượt.', 150, 200, 2, 'images/gach_lat_nen.jpg', 3),
(N'Bê tông tươi', N'Bê tông tươi chất lượng cao, giao tận nơi.', 1200, 50, 3, 'images/betong_tuoi.jpg', 1),
(N'Cát vàng', N'Cát vàng dùng trong xây dựng.', 500, 300, 3, 'images/cat_vang.jpg', 4),
(N'Sắt hộp 20x40', N'Sắt hộp chất lượng cao, phù hợp cho công trình.', 90, 150, 4, 'images/sat_hop.jpg', 5),
(N'Tôn lạnh 3 lớp', N'Tôn cách nhiệt 3 lớp, chống nóng tốt.', 320, 100, 5, 'images/ton_lanh.jpg', 6),
(N'Xi măng Nghi Sơn', N'Xi măng công nghiệp chất lượng cao.', 75.5, 200, 1, 'images/ximang_nghison.jpg', 2),
(N'Gạch không nung', N'Gạch bảo vệ môi trường, không cần nung.', 4.0, 400, 2, 'images/gach_khongnung.jpg', 7),
(N'Sơn nước Dulux 5L', N'Sơn chống thấm cao cấp Dulux.', 550, 100, 6, 'images/son_dulux.jpg', 8),
(N'Cát trắng mịn', N'Cát trắng dùng cho tô trát tường.', 600, 200, 3, 'images/cat_trang.jpg', 4),
(N'Thép phi 12', N'Thép xây dựng đường kính 12mm.', 150, 250, 4, 'images/thep_phi12.jpg', 9),
(N'Tôn mạ kẽm', N'Tôn chất lượng cao, bảo hành 10 năm.', 280, 120, 5, 'images/ton_makem.jpg', 10),
(N'Sơn Jotun 10L', N'Sơn nội thất cao cấp Jotun.', 950, 80, 6, 'images/son_jotun.jpg', 11),
(N'Gạch bông trang trí', N'Gạch bông dùng trong nội thất.', 100, 300, 2, 'images/gach_bong.jpg', 12),
(N'Gỗ công nghiệp MDF', N'Gỗ MDF chống ẩm, thích hợp làm nội thất.', 350, 60, 7, 'images/go_mdf.jpg', 13),
(N'Sắt V50', N'Sắt hình chữ V dùng cho kết cấu.', 120, 90, 4, 'images/sat_v50.jpg', 14),
(N'Thép hộp 30x60', N'Thép hộp chất lượng cao, chống gỉ sét.', 180, 110, 4, 'images/thep_hop.jpg', 15),
(N'Kính cường lực 8mm', N'Kính an toàn, chịu lực cao.', 450, 50, 8, 'images/kinh_cuongluc.jpg', 16),
(N'Xi măng Thăng Long', N'Xi măng chất lượng cao, dùng cho công trình lớn.', 85, 180, 1, 'images/ximang_thanglong.jpg', 17);
