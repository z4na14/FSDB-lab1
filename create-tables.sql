clear screen


-- Drop selection
drop table BIBUS_ROUTE;
drop table ROUTE_MUNICIPALITY;
drop table MUNICIPAL_LIBRARY;
drop table MUNICIPALITY;
drop table ROUTES;
drop table DRIVER;
drop table BIBUS;
drop table COMMENTS;
drop table SANCTION;
drop table RESERVATION;
drop table LOAN;
drop table COPIES;
drop table EDITIONS;
drop table BOOKS;
drop table USERS;



-- USERS Table
CREATE TABLE USERS (
    UserID CHAR(10) NOT NULL,
    FullName VARCHAR2(100) NOT NULL,
    Passport CHAR(20) UNIQUE NOT NULL,
    BirthDate DATE NOT NULL,
    Municipality VARCHAR2(50) NOT NULL,
    Address VARCHAR2(150) NOT NULL,
    Email VARCHAR2(100) UNIQUE,
    Phone CHAR(9) NOT NULL,
    CONSTRAINT PK_User PRIMARY KEY (UserID)
);

-- EDITIONS Table
CREATE TABLE EDITIONS (
    ISBN CHAR(13) NOT NULL,
    Publisher VARCHAR2(100) NOT NULL,
    MainLanguage VARCHAR2(50) NOT NULL,
    OtherLanguages VARCHAR2(50),
    PubDate DATE NOT NULL,
    Lenght VARCHAR2(50),
    Series VARCHAR2(50),
    Place_Of_Publication VARCHAR2(100),
    Dimensions VARCHAR2(50),
    Other VARCHAR2(500),
    CONSTRAINT PK_Edition PRIMARY KEY (ISBN)
);

-- BOOKS Table
CREATE TABLE BOOKS (
    Title VARCHAR2(200) UNIQUE NOT NULL,
    Alt_Title VARCHAR2(200),
    MainAuthor VARCHAR2(100) NOT NULL,
    Alt_Authors VARCHAR2(200),
    Edition CHAR(13) NOT NULL,
    Copy CHAR(20) NOT NULL,
    CONSTRAINT PK_Book PRIMARY KEY (Title, Edition, Copy),
    CONSTRAINT FK_Book_Edition FOREIGN KEY (Edition) REFERENCES EDITIONS(ISBN) ON DELETE CASCADE
);

-- COPIES Table
CREATE TABLE COPIES (
    Copy_Signature CHAR(20) NOT NULL,
    Condition VARCHAR2(20) CHECK (Condition IN ('New', 'Good', 'Worn', 'Very Used', 'Deteriorated')),
    Date_Deregistered DATE,
    Edition CHAR(13) NOT NULL,
    Comments VARCHAR2(500),
    CONSTRAINT PK_Copy PRIMARY KEY (Copy_Signature),
    CONSTRAINT FK_Copy_Edition FOREIGN KEY (Edition) REFERENCES EDITIONS(ISBN) ON DELETE CASCADE
);

-- LOAN Table
CREATE TABLE LOAN (
    LoanID CHAR(10) NOT NULL,
    USERS CHAR(10) NOT NULL,
    Copy CHAR(20) NOT NULL,
    LoanDate DATE NOT NULL,
    ReturnDate DATE NOT NULL,
    CONSTRAINT PK_Loan PRIMARY KEY (LoanID),
    CONSTRAINT FK_Loan_User FOREIGN KEY (USERS) REFERENCES USERS(UserID) ON DELETE CASCADE,
    CONSTRAINT FK_Loan_Copy FOREIGN KEY (Copy) REFERENCES COPIES(Copy_Signature) ON DELETE CASCADE
);

-- RESERVATION Table
CREATE TABLE RESERVATION (
    ReservationID CHAR(10) NOT NULL,
    USERS CHAR(10) NOT NULL,
    Copy CHAR(20) NOT NULL,
    ReservationDate DATE NOT NULL,
    CONSTRAINT PK_Reservation PRIMARY KEY (ReservationID),
    CONSTRAINT FK_Reservation_User FOREIGN KEY (USERS) REFERENCES USERS(UserID) ON DELETE CASCADE,
    CONSTRAINT FK_Reservation_Copy FOREIGN KEY (Copy) REFERENCES COPIES(Copy_Signature) ON DELETE CASCADE
);

-- SANCTION Table
CREATE TABLE SANCTION (
    SanctionID CHAR(10) NOT NULL,
    USERS CHAR(10) NOT NULL,
    WeeksPenalty INT NOT NULL,
    SanctionDate DATE NOT NULL,
    CONSTRAINT PK_Sanction PRIMARY KEY (SanctionID),
    CONSTRAINT FK_Sanction_User FOREIGN KEY (USERS) REFERENCES USERS(UserID) ON DELETE CASCADE
);

-- COMMENTS Table
CREATE TABLE COMMENTS (
    CommentID CHAR(10) NOT NULL,
    USERS CHAR(10) NOT NULL,
    Book_Title VARCHAR2(200) NOT NULL,
    Text VARCHAR2(2000) NOT NULL,
    CommentDate DATE NOT NULL,
    Vote INT DEFAULT 0,
    CONSTRAINT PK_Comment PRIMARY KEY (CommentID),
    CONSTRAINT FK_Comment_User FOREIGN KEY (USERS) REFERENCES USERS(UserID) ON DELETE CASCADE,
    CONSTRAINT FK_Comment_Book FOREIGN KEY (Book_Title) REFERENCES BOOKS(Title) ON DELETE CASCADE
);

-- BIBUS Table
CREATE TABLE BIBUS (
    Plate CHAR(8) NOT NULL,
    LastInspection DATE NOT NULL,
    NextInspection DATE NOT NULL,
    CONSTRAINT PK_Bibus PRIMARY KEY (Plate)
);

-- DRIVER Table
CREATE TABLE DRIVER (
    FullName VARCHAR2(100) NOT NULL,
    Passport CHAR(20) NOT NULL,
    Phone CHAR(9) NOT NULL,
    Email VARCHAR2(100) UNIQUE NOT NULL,
    ContractStart DATE NOT NULL,
    ContractEnd DATE,
    Assigned_Bibus CHAR(8),
    CONSTRAINT PK_Driver PRIMARY KEY (Passport),
    CONSTRAINT FK_Driver_Bibus FOREIGN KEY (Assigned_Bibus) REFERENCES BIBUS(Plate) ON DELETE SET NULL
);

-- ROUTES Table
CREATE TABLE ROUTES (
    RouteID CHAR(5) NOT NULL,
    RouteDate DATE NOT NULL,
    CONSTRAINT PK_Route PRIMARY KEY (RouteID)
);

-- MUNICIPALITY Table
CREATE TABLE MUNICIPALITY (
    Name VARCHAR2(50) NOT NULL,
    Population INT NOT NULL,
    Municipal_Library CHAR(20),
    CONSTRAINT PK_Municipality PRIMARY KEY (Name)
);

-- MUNICIPAL_LIBRARY Table
CREATE TABLE MUNICIPAL_LIBRARY (
    CIF CHAR(20) NOT NULL,
    InstitutionName VARCHAR2(100) NOT NULL,
    FoundationDate DATE,
    Municipality VARCHAR2(50) NOT NULL,
    Address VARCHAR2(150) NOT NULL,
    Email VARCHAR2(100) UNIQUE,
    Phone CHAR(9) NOT NULL,
    CONSTRAINT PK_Municipal_Library PRIMARY KEY (CIF),
    CONSTRAINT FK_MunicipalLibrary_Municipality FOREIGN KEY (Municipality) REFERENCES MUNICIPALITY(Name) ON DELETE CASCADE
);

-- ROUTE_MUNICIPALITY (Many-to-Many Relationship)
CREATE TABLE ROUTE_MUNICIPALITY (
    RouteID CHAR(5) NOT NULL,
    Municipality VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_Route_Municipality PRIMARY KEY (RouteID, Municipality),
    CONSTRAINT FK_RouteMunicipality_Route FOREIGN KEY (RouteID) REFERENCES ROUTES(RouteID) ON DELETE CASCADE,
    CONSTRAINT FK_RouteMunicipality_Municipality FOREIGN KEY (Municipality) REFERENCES MUNICIPALITY(Name) ON DELETE CASCADE
);

-- BIBUS_ROUTE (Many-to-Many Relationship)
CREATE TABLE BIBUS_ROUTE (
    Plate CHAR(8) NOT NULL,
    RouteID CHAR(5) NOT NULL,
    CONSTRAINT PK_Bibus_Route PRIMARY KEY (Plate, RouteID),
    CONSTRAINT FK_BibusRoute_Bibus FOREIGN KEY (Plate) REFERENCES BIBUS(Plate) ON DELETE CASCADE,
    CONSTRAINT FK_BibusRoute_Route FOREIGN KEY (RouteID) REFERENCES ROUTES(RouteID) ON DELETE CASCADE
);

-- Drop everything we just created

drop table BIBUS_ROUTE;
drop table ROUTE_MUNICIPALITY;
drop table MUNICIPAL_LIBRARY;
drop table MUNICIPALITY;
drop table ROUTES;
drop table DRIVER;
drop table BIBUS;
drop table COMMENTS;
drop table SANCTION;
drop table RESERVATION;
drop table LOAN;
drop table COPIES;
drop table EDITIONS;
drop table BOOKS;
drop table USERS;

-- ———————————No tables?————————————
-- ⠀⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽ 
-- ⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫ 
-- ⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏ 
-- ⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀ 
-- ⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀ 
-- ⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀ 
-- ⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀ 
-- ⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀ 
-- ⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
-- ⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
-- ⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
-- ⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
-- ⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
-- —————————————————————————————————
