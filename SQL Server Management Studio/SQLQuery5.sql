CREATE DATABASE PRJ301_DE181023;
GO
USE PRJ301_DE181023;
GO

CREATE TABLE UserDE181023 (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Role VARCHAR(20) NOT NULL
);
GO

CREATE TABLE TeacherDE181023 (
    TeacherID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    Tel VARCHAR(15) NOT NULL,
    UserName VARCHAR(50) NOT NULL,
    Image VARCHAR(100),
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES UserDE181023(UserID)
);
GO

INSERT INTO UserDE181023 (UserID, UserName, Password, Role)
VALUES 
    (1, 'sonnp', 'sonnp@123', 'user'),
    (2, 'binhdd', 'binhdd@123', 'admin');
GO

INSERT INTO TeacherDE181023 (TeacherID, Name, DOB, Tel, UserName, Image, UserID)
VALUES 
    ('T001', 'Nguyen Phong Son', '1975-03-12', '0903578889', 'sonnp', 'sample_1.png', 1),
    ('T002', 'Doan Duy Binh', '1982-03-05', '0982827764', 'binhdd', 'sample_2.png', 2),
    ('T003', 'Nguyen Thi No', '1999-04-03', '0944343111', 'thino', 'sample_3.png', NULL);
GO