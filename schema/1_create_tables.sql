/*
-- Feature that works on MySQL but not MS SQL
-- How to write it in MS SQL instead

-- MySQL
CONSTRAINT CHECK (Post_End_Date > Post_Date)

-- MS SQL
CONSTRAINT ValidateDateOfAdvertisement CHECK (Post_End > Post_Date)


-- MySQL
FOREIGN KEY (Sender_Phone, Receiver_Phone) REFERENCES Person(MemberPhone, MemberPhone)

-- MS SQL
FOREIGN KEY (Sender_Phone) REFERENCES Person(MemberPhone),
FOREIGN KEY (Receiver_Phone) REFERENCES Person(MemberPhone)
*/



-- Creating database
CREATE DATABASE AdswiseDB;

USE AdswiseDB;

-- Table: Person
CREATE TABLE Person (
MemberPhone CHAR(10),
FirstName VARCHAR(20) NOT NULL,
MiddleName VARCHAR(20),
LastName VARCHAR(25) NOT NULL,
Email VARCHAR(50),

PRIMARY KEY (MemberPhone)
);

-- Table: BoardLocation
CREATE TABLE BoardLocation (
BoardID NUMERIC(3),
Building CHAR(3) NOT NULL,
FloorNumber NUMERIC(2) NOT NULL,
LocationOnFloor CHAR(5),
PRIMARY KEY (BoardID)
);

-- Table: Advertisement
CREATE TABLE Advertisement (
AdID NUMERIC(4),
Adv_Type CHAR(15) NOT NULL,
Post_Date DATE NOT NULL,
Post_End_Date DATE,
SizeDim_Length FLOAT,
SizeDim_Width FLOAT,
Post_Title VARCHAR(70) NOT NULL,
MemberPhone CHAR(10),
PRIMARY KEY (AdID),
FOREIGN KEY (MemberPhone) REFERENCES Person(MemberPhone) ON DELETE SET NULL,
CONSTRAINT CHECK (Post_End_Date > Post_Date)
);

-- Table: NonCollegeMember
CREATE TABLE NonCollegeMember (
NonCollege_MemberPhone CHAR(10),
RegistrationID NUMERIC(6) UNIQUE,
Registration_Date DATE NOT NULL,

PRIMARY KEY (NonCollege_MemberPhone),
FOREIGN KEY (NonCollege_MemberPhone) REFERENCES Person(MemberPhone) ON DELETE CASCADE
);

-- Table: Student_CollegeMember
CREATE TABLE Student_CollegeMember (
StudentPhone CHAR(10),
MajorField CHAR(4) NOT NULL,
Aff_Dep VARCHAR(50) NOT NULL,
CollegeID NUMERIC(7) UNIQUE,

PRIMARY KEY (StudentPhone),
FOREIGN KEY (StudentPhone) REFERENCES Person(MemberPhone) ON DELETE CASCADE
);

-- Table: Professor_CollegeMember
CREATE TABLE Professor_CollegeMember (
ProfessorPhone CHAR(10),
EdLevel VARCHAR(4),
Aff_Dep VARCHAR(50) NOT NULL,
CollegeID NUMERIC(7) UNIQUE,
OfficeLocation CHAR(5),
EmploymentDate DATE,

PRIMARY KEY (ProfessorPhone),
FOREIGN KEY (ProfessorPhone) REFERENCES Person(MemberPhone) ON DELETE CASCADE
);

-- Table: Staff_CollegeMember
CREATE TABLE Staff_CollegeMember (
StaffPhone CHAR(10),
PositionTitle VARCHAR(20) NOT NULL,
Aff_Dep VARCHAR(50) NOT NULL,
CollegeID NUMERIC(7) UNIQUE,
OfficeLocation CHAR(5),
EmploymentDate DATE,

PRIMARY KEY (StaffPhone),
FOREIGN KEY (StaffPhone) REFERENCES Person(MemberPhone) ON DELETE CASCADE
);

-- Table: Advertisement_Message
CREATE TABLE Advertisement_Message (
AdID NUMERIC(4),
MessageID NUMERIC(4),
Content VARCHAR(500) NOT NULL,
Message_Time TIME,
Message_Date DATE NOT NULL,

PRIMARY KEY (AdID, MessageID),
FOREIGN KEY (AdID) REFERENCES Advertisement(AdID) ON DELETE CASCADE
);

-- Table: Person_Sends_Message
CREATE TABLE Person_Sends_Message (
Sender_Phone CHAR(10),
AdID NUMERIC(4),
MessageID NUMERIC(4),


PRIMARY KEY (Sender_Phone, AdID, MessageID),
FOREIGN KEY (Sender_Phone) REFERENCES Person(MemberPhone) ON DELETE CASCADE,
FOREIGN KEY (AdID) REFERENCES Advertisement(AdID) ON DELETE CASCADE
);

-- Table: Person_Receives_Message
CREATE TABLE Person_Receives_Message (
Receiver_Phone CHAR(10),
AdID NUMERIC(4),
MessageID NUMERIC(4),


PRIMARY KEY (Receiver_Phone, AdID, MessageID),
FOREIGN KEY (Receiver_Phone) REFERENCES Person(MemberPhone) ON DELETE CASCADE,
FOREIGN KEY (AdID) REFERENCES Advertisement(AdID) ON DELETE CASCADE
);

-- Table: Staff_Approves_Advertisement
CREATE TABLE Staff_Approves_Advertisement (
AdID NUMERIC(4),
StaffPhone CHAR(10),
ApprovalDate DATE NOT NULL,

PRIMARY KEY (AdID),
FOREIGN KEY (AdID) REFERENCES Advertisement(AdID) ON DELETE CASCADE,
FOREIGN KEY (StaffPhone) REFERENCES Staff_CollegeMember(StaffPhone) ON DELETE CASCADE
);

-- Table: Advertisement_LocatedOn_BoardLocation
CREATE TABLE Advertisement_LocatedOn_BoardLocation (
AdID NUMERIC(4),
BoardID NUMERIC(3),

PRIMARY KEY (AdID, BoardID),
FOREIGN KEY (AdID) REFERENCES Advertisement(AdID) ON DELETE CASCADE,
FOREIGN KEY (BoardID) REFERENCES BoardLocation(BoardID) ON DELETE CASCADE
);
