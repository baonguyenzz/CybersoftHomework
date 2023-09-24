CREATE DATABASE deadline2409_baonguyen
GO
USE deadline2409_baonguyen
GO

CREATE TABLE nhacungcap(
mancc int identity primary key not null,
tenncc nvarchar(20)
)
GO

CREATE TABLE sanpham (
masp int identity primary key not null,
tensp nvarchar(50) not null,
loaisp nvarchar(50) not null,
gianhap int not null,
giaban int not null,
soluong int not null,
donvitinh nvarchar(20),
giamgia varchar(10),
ngaynhap datetime,
mancc int foreign key references nhacungcap(mancc)
)

INSERT INTO nhacungcap (tenncc)
VALUES
  ('Sam Sung'),
  ('Panasonic'),
  ('Apple'),
  ('Xiaomi'),
  ('Lenovo');
GO

INSERT INTO sanpham (tensp, loaisp, gianhap, giaban, soluong, donvitinh, giamgia, ngaynhap, mancc)
VALUES
  (N'Máy giặt', N'Đồ gia dụng', 8000000, 12000000, 50, 'Cái', '0%', '2023-09-01', 2),
  ('Ipad', N'Máy tính bảng', 1500000, 2200000, 30, 'Cái', '5%', '2023-09-02', 3),
  ('Macbook Air', N'Laptop', 5000000, 7000000, 40, 'Cái', '10%', '2023-09-03', 3),
  ('Iphone 15 pro max', N'Điện thoại', 25000000, 35000000, 60, 'Cái', '0%', '2023-09-04', 3),
  ('Macbook Pro', N'Laptop', 25000000, 35000000, 20, 'Cái', '5%', '2023-09-05', 3),
  (N'Tủ lạnh', N'Đồ gia dụng', 9000000, 14000000, 70, 'Cái', '0%', '2023-09-06', 1),
  ('Samsung Galaxy Tab', N'Máy tính bảng', 1700000, 8000000, 35, 'Cái', '5%', '2023-09-07', 1),
  ('Xiaomi Note 12', N'Điện thoại', 2800000, 3800000, 65, 'Cái', '0%', '2023-09-08', 4),
  ('Thinkpad', 'Laptop', 7500000, 9800000, 25, 'Cái', '10%', '2023-09-09', 5),
  ('Samsung Galaxy A24', N'Điện thoại', 3000000, 4200000, 45, 'Cái', '5%', '2023-09-10', 1);
 GO
 SELECT * FROM nhacungcap
 SELECT * FROM sanpham

 -- CÂU 1
SELECT * FROM sanpham
-- CÂU 2
SELECT MASP, TENSP, GIANHAP, GIABAN, SOLUONG, GIAMGIA FROM sanpham
-- CÂU 3
SELECT MASP, TENSP, GIANHAP, GIABAN, SOLUONG FROM sanpham
WHERE SOLUONG > 60
-- CÂU 4
SELECT TOP (3) MASP, TENSP, GIANHAP, GIABAN, SOLUONG,DONVITINH,GIAMGIA, NGAYNHAP AS N'NGÀY NHẬP MỚI NHẤT'
FROM sanpham
GROUP BY MASP, TENSP, GIANHAP, GIABAN, SOLUONG,DONVITINH,GIAMGIA, NGAYNHAP
ORDER BY NGAYNHAP DESC;
-- CÂU 5
SELECT * FROM sanpham
WHERE tensp LIKE '%SAMSUNG%'
-- CÂU 6
SELECT * FROM sanpham
WHERE tensp LIKE '%MACBOOK%' AND giaban > 7000000
-- CÂU 7
SELECT * FROM sanpham
WHERE giaban BETWEEN 8000000 AND 10000000
-- CÂU 8
SELECT MASP, TENSP, GIANHAP, GIABAN, SOLUONG, TENNCC
FROM sanpham JOIN nhacungcap ON sanpham.mancc = nhacungcap.mancc
-- CÂU 9
SELECT MASP, TENSP, GIANHAP, GIABAN, SOLUONG, sanpham.mancc, TENNCC,LOAISP
FROM sanpham JOIN nhacungcap ON sanpham.mancc = nhacungcap.mancc
WHERE giaban > 5000000
-- CÂU 10
SELECT * FROM sanpham
WHERE loaisp LIKE N'MÁY TÍNH BẢNG'