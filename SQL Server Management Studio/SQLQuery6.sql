CREATE TABLE UserYourID (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserName NVARCHAR(50) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    Role NVARCHAR(10) CHECK (Role IN ('user', 'admin')) NOT NULL
);
GO

-- Chèn d? li?u vào b?ng UserYourID
INSERT INTO UserYourID (UserName, Password, Role) VALUES

('vantri', 'vantri@123', 'user'),
('quangkiet', 'quangkiet@123', 'user'),
('minhnhan', 'minhnhan@123', 'user'),
('giabao', 'giabao@123', 'user'),
('quocdat', 'quocdat@123', 'user'),
('sonnp', 'sonnp@123', 'user'),
('binhdd', 'binhdd@123', 'admin'),
('thino', 'thino@123', 'user'),
('thaitan', 'thaitan@123', 'user'),
('quocca', 'quocca@123', 'user');

GO

-- T?o b?ng TeacherYourID
CREATE TABLE TeacherYourID (
    TeacherID NVARCHAR(10) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    Tel NVARCHAR(15) NOT NULL,
    UserName NVARCHAR(50),
    Image NVARCHAR(100),
    CONSTRAINT FK_Teacher_User FOREIGN KEY (UserName) REFERENCES UserYourID(UserName)
);
GO

-- Chèn d? li?u vào b?ng TeacherYourID
INSERT INTO TeacherYourID (TeacherID, Name, DOB, Tel, UserName, Image) VALUES
('T001', 'Nguyen Phong Son', '1975-03-12', '0903578889', 'sonnp', 'sample_1.png'),
('T002', 'Doan Duy Binh', '1982-03-05', '0982827764', 'binhdd', 'sample_2.png'),
('T003', 'Nguyen Thi No', '1999-04-03', '0944343111', 'thino', 'sample_3.png'); 
GO