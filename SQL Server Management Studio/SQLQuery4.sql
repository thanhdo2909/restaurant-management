-- Tạo database
CREATE DATABASE PRJ301_DE181023;
GO

-- Sử dụng database vừa tạo
USE PRJ301_DE181023;
GO

-- Tạo bảng UserYourID
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserName VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(10) CHECK (Role IN ('user', 'admin')) NOT NULL
);
GO

-- Thêm dữ liệu vào bảng UserYourID
INSERT INTO Users (UserName, Password, Role) 
VALUES 
    ('sonnp', 'sonnp@123', 'user'),
    ('binhdd', 'binhdd@123', 'admin');
GO

-- Tạo bảng TeacherYourID
CREATE TABLE Teachers (
    TeacherID CHAR(4) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    Tel VARCHAR(15) NOT NULL,
    UserName VARCHAR(50) NOT NULL,
    Image VARCHAR(255),
    FOREIGN KEY (UserName) REFERENCES Users(UserName) ON DELETE CASCADE
);
GO

-- Thêm dữ liệu vào bảng TeacherYourID
INSERT INTO Teachers (TeacherID, Name, DOB, Tel, UserName, Image) 
VALUES 
    ('T001', N'Nguyen Phong Son', '1975-03-12', '0903578889', 'sonnp', 'sample_1.png'),
    ('T002', N'Doan Duy Binh', '1982-03-05', '0982827764', 'binhdd', 'sample_2.png'),
    ('T003', N'Nguyen Thi No', '1999-04-03', '0944343111', 'thino', 'sample_3.png');
GO