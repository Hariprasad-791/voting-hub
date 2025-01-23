
-- Create the database
CREATE DATABASE IF NOT EXISTS votinghub;

-- Use the database
USE votinghub;

-- Create the Region table
CREATE TABLE Region (
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(255) NOT NULL,
    State VARCHAR(255) NOT NULL,
    Population INT NOT NULL
);

-- Insert values into the Region table
INSERT INTO Region (RegionID, RegionName, State, Population)
VALUES 
    (1, 'North Zone', 'Delhi', 3000000),
    (2, 'South Zone', 'Karnataka', 5000000),
    (3, 'East Zone', 'West Bengal', 2000000),
    (4, 'West Zone', 'Maharashtra', 8000000);

-- Create the Election table
CREATE TABLE Election (
    ElectionID INT PRIMARY KEY,
    Type VARCHAR(255) NOT NULL,
    Year INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Description TEXT
);

-- Insert values into the Election table
INSERT INTO Election (ElectionID, Type, Year, StartDate, EndDate, Description)
VALUES
    (1, 'National', 2024, '2024-01-15', '2024-02-15', 'National Election for Parliament'),
    (2, 'State', 2024, '2024-03-01', '2024-03-31', 'State Election for Assembly');

-- Create the Election_Admin table
CREATE TABLE Election_Admin (
    ElectionID INT,
    AdminID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    ContactDetails VARCHAR(255) NOT NULL,
    Role VARCHAR(255) NOT NULL,
    FOREIGN KEY (ElectionID) REFERENCES Election(ElectionID)
);

-- Insert values into the Election_Admin table
INSERT INTO Election_Admin (ElectionID, AdminID, Name, Password, ContactDetails, Role)
VALUES
    (1, 1, 'John Doe', 'admin123', 'john.doe@votinghub.com', 'Election Officer'),
    (2, 2, 'Jane Smith', 'admin456', 'jane.smith@votinghub.com', 'Regional Coordinator');

-- Create the Party table
CREATE TABLE Party (
    PID INT PRIMARY KEY,
    Pname VARCHAR(255) NOT NULL,
    Leader VARCHAR(255),
    Ideology VARCHAR(255),
    Votes INT,
    RegionID INT,
    ElectionID INT,
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID),
    FOREIGN KEY (ElectionID) REFERENCES Election(ElectionID)
);

-- Insert values into the Party table
INSERT INTO Party (PID, Pname, Leader, Ideology, Votes, RegionID, ElectionID)
VALUES
    (1, 'AAP', 'ramesh', 'Pro-Development and Anti-Corruption', 1203, 1, 1),
    (2, 'NOTA', 'None', 'No Confidence in Candidates', 501, 1, 1),
    (3, 'Congress', 'suresh', 'Social Democracy and Secularism', 1502, 1, 1),
    (4, 'BJP', 'rakesh', 'Nationalism and Economic Reform', 2002, 1, 1),
    (5, 'AAP', 'abc', 'no corruption', 111, 1, 2),
    (6, 'NOTA', 'bc', 'free', 112, 1, 2),
    (7, 'Congress', 'c', 'capitalist', 211, 2, 2),
    (8, 'BJP', 'abcd', 'socialist', 132, 2, 2);

-- Create the Voter table
CREATE TABLE Voter (
    VID INT PRIMARY KEY,
    Vname VARCHAR(255) NOT NULL,
    AdharNumber VARCHAR(12) UNIQUE NOT NULL,
    Bdate DATE NOT NULL,
    Age INT NOT NULL,
    Email VARCHAR(255) UNIQUE,
    Password VARCHAR(255) NOT NULL,
    RegionID INT,
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

-- Insert values into the Voter table
INSERT INTO Voter (VID, Vname, AdharNumber, Bdate, Age, Email, Password, RegionID)
VALUES
    (1, 'Alice', '123456789012', '1990-01-01', 33, 'alice@example.com', 'password1', 1),
    (2, 'Bob', '987654321098', '1985-05-15', 38, 'bob@example.com', 'password2', 2),
    (3, 'Charlie', '456123789654', '1995-03-20', 28, 'charlie@example.com', 'password3', 3);

-- Create the Votesfor table
CREATE TABLE Votesfor (
    VoteID INT PRIMARY KEY AUTO_INCREMENT,
    VID INT,
    PID INT,
    ElectionID INT,
    Date DATE NOT NULL,
    FOREIGN KEY (VID) REFERENCES Voter(VID),
    FOREIGN KEY (PID) REFERENCES Party(PID),
    FOREIGN KEY (ElectionID) REFERENCES Election(ElectionID)
);

-- Insert values into the Votesfor table
INSERT INTO Votesfor (VID, PID, ElectionID, Date)
VALUES
    (1, 1, 1, '2024-01-16'),
    (2, 4, 1, '2024-01-20'),
    (3, 3, 2, '2024-03-05');
