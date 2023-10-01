CREATE DATABASE ThucTap;
USE ThucTap;
CREATE TABLE TBLKhoa
(Makhoa char(10)primary key,
 Tenkhoa char(30),
 Dienthoai char(10));
CREATE TABLE TBLGiangVien(
Magv int primary key,
Hotengv char(30),
Luong decimal(5,2),
Makhoa char(10) foreign key references TBLKhoa(Makhoa));
CREATE TABLE TBLSinhVien(
Masv int primary key,
Hotensv char(40),
Makhoa char(10)foreign key references TBLKhoa(Makhoa),
Namsinh int,
Quequan char(30));
CREATE TABLE TBLDeTai(
Madt char(10)primary key,
Tendt char(30),
Kinhphi int,
Noithuctap char(30));
CREATE TABLE TBLHuongDan(
Masv int primary key,
Madt char(10)foreign key references TBLDeTai,
Magv int foreign key references TBLGiangVien,
KetQua decimal(5,2));

INSERT INTO TBLKhoa VALUES
('Geo','Dia ly va QLTN',3855413),
('Math','Toan',3855411),
('Bio','Cong nghe Sinh hoc',3855412);
INSERT INTO TBLGiangVien VALUES
(11,'Thanh Binh',700,'Geo'),    
(12,'Thu Huong',500,'Math'),
(13,'Chu Vinh',650,'Geo'),
(14,'Le Thi Ly',500,'Bio'),
(15,'Tran Son',900,'Math');
INSERT INTO TBLSinhVien VALUES
(1,'Le Van Son','Bio',1990,'Nghe An'),
(2,'Nguyen Thi Mai','Geo',1990,'Thanh Hoa'),
(3,'Bui Xuan Duc','Math',1992,'Ha Noi'),
(4,'Nguyen Van Tung','Bio',null,'Ha Tinh'),
(5,'Le Khanh Linh','Bio',1989,'Ha Nam'),
(6,'Tran Khac Trong','Geo',1991,'Thanh Hoa'),
(7,'Le Thi Van','Math',null,'null'),
(8,'Hoang Van Duc','Bio',1992,'Nghe An');
INSERT INTO TBLDeTai VALUES
('Dt01','GIS',100,'Nghe An'),
('Dt02','ARC GIS',500,'Nam Dinh'),
('Dt03','Spatial DB',100, 'Ha Tinh'),
('Dt04','MAP',300,'Quang Binh' );
INSERT INTO TBLHuongDan VALUES
(1,'Dt01',13,8),
(2,'Dt03',14,0),
(3,'Dt03',12,10),
(5,'Dt04',14,7),
(6,'Dt01',13,Null),
(7,'Dt04',11,10),
(8,'Dt03',15,6);


select * from TBLKhoa
select * from TBLGiangVien
select * from TBLSinhVien
select * from TBLDeTai
select * from TBLHuongDan

-- cau 1
select magv, hotengv, tenkhoa from TBLGiangVien join TBLKhoa on TBLGiangVien.Makhoa = tblkhoa.makhoa
go
-- cau 2
select magv, hotengv, tenkhoa from TBLGiangVien join TBLKhoa on TBLGiangVien.Makhoa = tblkhoa.makhoa
where tblkhoa.Tenkhoa like 'Dia ly va QLTN'
group by TBLGiangVien.magv, TBLGiangVien.Hotengv, tblkhoa.Tenkhoa
go
-- cau 3
select count (*) as 'tong sinh vien' from TBLKhoa join TBLSinhVien on tblkhoa.Makhoa = TBLSinhVien.Makhoa
where tblkhoa.Tenkhoa like 'Cong nghe Sinh hoc'
go
-- cau 4
select masv, hotensv, (YEAR(GETDATE()) - namsinh) as 'tuoi'
from TBLSinhVien join TBLKhoa on TBLSinhVien.Makhoa = tblkhoa.Makhoa
where tblkhoa.tenkhoa like 'Toan'
group by TBLSinhVien.Masv, TBLSinhVien.Hotensv, TBLSinhVien.Namsinh
go
-- cau 5
select count (*) as 'tong giang vien' from TBLKhoa join TBLGiangVien on tblkhoa.Makhoa = TBLGiangVien.Makhoa
where tblkhoa.Tenkhoa like 'Cong nghe Sinh hoc'
go
-- cau 6
select tblsinhvien.masv, hotensv, namsinh
from TBLSinhVien left join TBLHuongDan on TBLSinhVien.masv = TBLHuongDan.Masv
where TBLHuongDan.Masv is null
go
-- cau 7
select tblkhoa.makhoa, tenkhoa, count(*) as 'so giang vien'
from TBLKhoa join TBLGiangVien on TBLKhoa.Makhoa = TBLGiangVien.Makhoa
group by TBLKhoa.makhoa, TBLKhoa.tenkhoa
go
-- cau 8
select dienthoai,tenkhoa from tblkhoa join TBLSinhVien on TBLKhoa.Makhoa = TBLSinhVien.Makhoa
where TBLSinhVien.Hotensv like 'le van son'
go

-- bài 2 câu 1
select tbldetai.Madt, tendt, hotengv, ketqua
from TBLHuongDan 
join TBLGiangVien on TBLHuongDan.Magv = TBLGiangVien.Magv
join TBLDeTai on TBLHuongDan.Madt = TBLDeTai.Madt
where TBLGiangVien.Hotengv like 'Tran son'
go

-- bài 2 câu 2
-- Cho biết tên đề tài không có sinh viên nào thực tập
select * from TBLDeTai
left join TBLHuongDan  on TBLHuongDan.Madt = TBLDeTai.Madt
where TBLHuongDan.Madt is null
go

-- bài 2 câu 3
-- Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 2 sinh viên trở lên.
select tblgiangvien.Magv, hotengv, tblkhoa.Makhoa, tenkhoa, COUNT(tblhuongdan.Magv) as N'số sinh viên hướng dẫn'
from TBLGiangVien join TBLKhoa on TBLGiangVien.Makhoa = TBLKhoa.Makhoa
join TBLHuongDan on TBLGiangVien.Magv = TBLHuongDan.Magv
group by TBLGiangVien.Magv, TBLGiangVien.Hotengv, TBLKhoa.Makhoa, TBLKhoa.Tenkhoa
having COUNT(tblhuongdan.Magv) > 1
select * from TBLHuongDan
go

-- bài 2 câu 4
select top (1)madt, tendt, kinhphi
from TBLDeTai
order by Kinhphi desc
select * from TBLDeTai
go

-- bài 2 câu 5
-- Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
select tbldetai.Madt, tendt, COUNT (tbldetai.Madt) as N'số sinh viên tham gia'
from TBLDeTai join TBLHuongDan on TBLDeTai.Madt = TBLHuongDan.Madt
join TBLSinhVien on TBLHuongDan.Masv = TBLSinhVien.Masv
group by TBLDeTai.Madt, TBLDeTai.Tendt
having COUNT(TBLDeTai.Madt)>2
select * from TBLHuongDan
go
-- bài 2 câu 6
-- Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIALY và QLTN’
select TBLSinhVien.Masv, TBLSinhVien.Hotensv,TBLKhoa.Tenkhoa, TBLHuongDan.KetQua
from TBLSinhVien join TBLHuongDan on TBLSinhVien.Masv = TBLHuongDan.Masv
join TBLKhoa on TBLSinhVien.Makhoa = TBLKhoa.Makhoa
where TBLKhoa.Tenkhoa like 'Dia ly va QLTN'
select * from TBLHuongDan
go
-- bài 2 câu 7
-- Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
select TBLKhoa.Tenkhoa, count(tblkhoa.makhoa) as N'số lượng sinh viên'
from TBLKhoa join TBLSinhVien on TBLKhoa.Makhoa = TBLSinhVien.Makhoa
group by TBLKhoa.Tenkhoa
select * from TBLSinhVien
go
-- bài 2 câu 8
-- Cho biết thông tin về các sinh viên thực tập tại quê nhà
select * from TBLSinhVien
join TBLHuongDan on TBLSinhVien.Masv = TBLHuongDan.Masv
join TBLDeTai on TBLHuongDan.Madt = TBLDeTai.Madt
where TBLSinhVien.Quequan = TBLDeTai.Noithuctap
select * from TBLSinhVien
select * from TBLDeTai
select * from TBLHuongDan
go
-- bài 2 câu 9
-- Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập
select * from TBLSinhVien
join TBLHuongDan on TBLSinhVien.Masv = TBLHuongDan.Masv
where TBLHuongDan.KetQua is null
select * from TBLHuongDan
go
-- bài 2 câu 10
-- Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0
select * from TBLSinhVien
join TBLHuongDan on TBLSinhVien.Masv = TBLHuongDan.Masv
where TBLHuongDan.KetQua = 0
select * from TBLHuongDan
go