create database QLNH;	
CREATE TABLE Membership_Tier (
    TierID INT IDENTITY(1,1) PRIMARY KEY,
    TierName NVARCHAR(100),
    MinSpending DECIMAL(10,2),
    DiscountPercent FLOAT
);

CREATE TABLE Accounts (
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(255),
    Email NVARCHAR(255),
    BirthDate DATE,
    TierID INT FOREIGN KEY REFERENCES Membership_Tier(TierID),
    CreatedAt DATETIME,
    Username NVARCHAR(100),
    PasswordHash NVARCHAR(255),
    FailedLoginCount INT,
    Status NVARCHAR(50),
    ProfileImage NVARCHAR(255),
    Role NVARCHAR(50)
);

CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100),
    Description NVARCHAR(255)
);

CREATE TABLE Food (
    FoodID INT IDENTITY(1,1) PRIMARY KEY,
    Image NVARCHAR(255),
    Price DECIMAL(10,2),
    FoodName NVARCHAR(255),
    Ingredients NVARCHAR(500),
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    Description NVARCHAR(1000)
);

CREATE TABLE Favorites (
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID),
    FoodID INT FOREIGN KEY REFERENCES Food(FoodID),
    PRIMARY KEY (AccountID, FoodID)
);

CREATE TABLE Rooms (
    RoomID INT IDENTITY(1,1) PRIMARY KEY,
    QRCodePath NVARCHAR(255),
    Status NVARCHAR(50)
);

CREATE TABLE RoomBookings (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID),
    RoomID INT FOREIGN KEY REFERENCES Rooms(RoomID),
    StartTime DATETIME,
    EndTime DATETIME
);

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID),
    ShipperID INT, -- Giả sử có bảng Shippers sau
    TotalAmount DECIMAL(10,2),
    Status NVARCHAR(50),
    CreatedAt DATETIME,
);

CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    FoodID INT FOREIGN KEY REFERENCES Food(FoodID),
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE PreOrders (
    PreOrderID INT IDENTITY(1,1) PRIMARY KEY,
    BookingID INT FOREIGN KEY REFERENCES RoomBookings(BookingID),
    FoodID INT FOREIGN KEY REFERENCES Food(FoodID),
    Quantity INT,
    Note NVARCHAR(255)
);

CREATE TABLE Promotions (
    PromoID INT IDENTITY(1,1) PRIMARY KEY,
    PromoCode NVARCHAR(50),
    DiscountPercent FLOAT,
    ExpirationDate DATE
);

CREATE TABLE Promo_Usage (
    UsageID INT IDENTITY(1,1) PRIMARY KEY,
    OrderDetailID INT FOREIGN KEY REFERENCES OrderDetails(OrderDetailID),
    PromoID INT FOREIGN KEY REFERENCES Promotions(PromoID),
    IsUsed BIT
);

CREATE TABLE Notifications (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID),
    Message NVARCHAR(1000),
    IsRead BIT,
    CreatedAt DATETIME,
    Title NVARCHAR(255)
);

CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    FoodID INT FOREIGN KEY REFERENCES Food(FoodID),
AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID),
    Comment NVARCHAR(MAX),
    Rating INT,
    CreatedAt DATETIME
);