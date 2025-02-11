-- Group 4: High Strung
-- Group Members: Michael McGuan & Derek Woodard
-- Project Step 2 Draft DDL

SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- ---------------------------------------------------------------------------
-- TABLE CREATION QUERIES
-- ---------------------------------------------------------------------------

-- Create Students table
DROP TABLE IF EXISTS Students;
CREATE TABLE Students(
    studentID INT AUTO_INCREMENT NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    streetAddress VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zipCode VARCHAR(15),
    phone VARCHAR(15),
    email VARCHAR(100),
    parentFirstName VARCHAR(50),
    parentLastName VARCHAR(50),
    isActive TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY(studentID)
);

-- Create Instruments table
DROP TABLE IF EXISTS Instruments;
CREATE TABLE Instruments (
    instrumentID INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(50) NOT NULL,
    comment VARCHAR(150),
    PRIMARY KEY(instrumentID)
);

-- Create Lessons table
DROP TABLE IF EXISTS Lessons;
CREATE TABLE Lessons (
    lessonID INT AUTO_INCREMENT NOT NULL,
    studentID INT NOT NULL,
    instrumentID INT NOT NULL,
    date DATE NOT NULL,
    comment VARCHAR(150),
    PRIMARY KEY(lessonID),
    CONSTRAINT fk_Lessons_Students
        FOREIGN KEY(studentID) 
        REFERENCES Students(studentID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_Lessons_Instruments
        FOREIGN KEY(instrumentID)
        REFERENCES Instruments(instrumentID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Create Composers table
DROP TABLE IF EXISTS Composers;
CREATE TABLE Composers (
    composerID INT AUTO_INCREMENT NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    PRIMARY KEY(composerID)
);

-- Create Pieces table
DROP TABLE IF EXISTS Pieces;
CREATE TABLE Pieces (
    pieceID INT AUTO_INCREMENT NOT NULL,
    title VARCHAR(100) NOT NULL,
    instrumentID INT NOT NULL,
    composerID INT NOT NULL,
    PRIMARY KEY(pieceID),
    CONSTRAINT fk_Pieces_Instruments
        FOREIGN KEY(instrumentID) 
        REFERENCES Instruments(instrumentID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_Pieces_Composers
        FOREIGN KEY(composerID) 
        REFERENCES Composers(composerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Create StudentInstrument junction table
DROP TABLE IF EXISTS StudentInstrument;
CREATE TABLE StudentInstrument (
    studentID INT NOT NULL,
    instrumentID INT NOT NULL,
    status ENUM('Owned', 'Rented') NOT NULL,
    PRIMARY KEY(studentID, instrumentID),
    CONSTRAINT fk_StudentInstrument_Students
        FOREIGN KEY(studentID)
        REFERENCES Students(StudentId)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_StudentInstrument_Instruments
        FOREIGN KEY(instrumentID) 
        REFERENCES Instruments(InstrumentID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Create StudentPiece junction table
DROP TABLE IF EXISTS StudentPiece;
CREATE TABLE StudentPiece (
    studentID INT NOT NULL,
    pieceID INT NOT NULL,
    dateAssigned DATE NOT NULL,
    dateCompleted DATE,
    PRIMARY KEY(studentID, pieceID),
    CONSTRAINT fk_StudentPiece_Students
    FOREIGN KEY(studentID) 
        REFERENCES Students(studentID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_StudentPiece_Pieces
    FOREIGN KEY(pieceID) 
        REFERENCES Pieces(pieceID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
-- ---------------------------------------------------------------------------
-- Load tables with sample data
-- ---------------------------------------------------------------------------

-- Students sample data
INSERT INTO Students
(firstName, lastName, streetAddress, city, state, zipCode, phone,
email, parentFirstName, parentLastName, isActive)
VALUES
('Jonathan', 'McCoy', '7556 Elgin St', 'Irving', 'Iowa', '47125',
'(594) 273-5475', 'jonathan.mccoy@example.com', 'Roberta', 'Elliot', TRUE),
('Gary', 'Collins', '8748 Adams St', 'Los Lunas', 'New Jersey', '29784',
'(972) 960-8131', 'gary.collins@example.com', 'Marcia', 'Collins', TRUE),
('Johnny', 'Fleming', '4623 E Sandy Lake Rd', 'Princeton', 'Maine', '78296',
'(577) 536-0700', 'johnny.fleming@example.com', 'Gloria', 'Fleming', FALSE),
('James', 'Jones', '6546 Spring Hill Rd', 'Fort Collins', 'North Carolina',
'21782', '(847) 304-0243', 'james.jones@example.com', 'Grace', 'Jones',FALSE),
('Kristin', 'Bryant', '8251 Sunset St', 'Topeka', 'Nevada', '16396',
'(655) 547-8159', 'kristin.bryant@example.com', 'Andy', 'Bryant', TRUE),
('Bessie', 'Douglas', '4449 Cackson St', 'El Monte', 'Nevada', '46077',
'(947) 330-4671', 'bessie.douglas@example.com', NULL, NULL, TRUE);

-- Instruments sample data
INSERT INTO Instruments (name, comment) VALUES
('Violin', NULL),
('Guitar', NULL),
('Piano', NULL);

-- Composers sample data
INSERT INTO Composers (firstName, lastName) VALUES
("Johann Sebastian", "Bach"),
("Wolfgang Amadeus", "Mozart"),
("Fernando", "Sor"),
("Max", "Bruch");

-- Pieces sample data
INSERT INTO Pieces (title, instrumentID, composerID) VALUES
('Partita No.3 in E major, BWV 1006',
    (SELECT instrumentID FROM Instruments WHERE name = 'Violin'),
    (SELECT composerID FROM Composers
        WHERE lastName = 'Bach' AND firstName = 'Johann Sebastian')),
('Invention in C major, BWV 772', 
    (SELECT instrumentID FROM Instruments WHERE name = 'Piano'),
    (SELECT composerID FROM Composers
        WHERE lastName = 'Bach' AND firstName = 'Johann Sebastian')),
('Scottish Fantasy, Op.46',
    (SELECT instrumentID FROM Instruments WHERE name = 'Violin'),
    (SELECT composerID FROM Composers
        WHERE lastName = 'Bruch' AND firstName = 'Max')),
("Sonata No.16 in C major, K.545",
    (SELECT instrumentID FROM Instruments WHERE name = 'Piano'),
    (SELECT composerID FROM Composers
        WHERE lastName = 'Mozart' AND firstName = 'Wolfgang Amadeus')),
("Introduction and Variations on a Theme by Mozart, Op.9",
    (SELECT instrumentID FROM Instruments WHERE name = 'Guitar'),
    (SELECT composerID FROM Composers
        WHERE lastName = 'Sor' AND firstName = 'Fernando'));

-- Lessons sample data
INSERT INTO Lessons (studentID, instrumentID, date, comment) VALUES
((SELECT studentID FROM Students
    WHERE lastName = 'McCoy' AND firstName = 'Jonathan'),
(SELECT instrumentID FROM Instruments WHERE name = 'Violin'),
'2025-01-20', NULL),
((SELECT studentID FROM Students
    WHERE lastName = 'Collins' AND firstName = 'Gary'),
(SELECT instrumentID FROM Instruments WHERE name = 'Violin'),
'2025-01-27', NULL),
((SELECT studentID FROM Students
    WHERE lastName = 'Bryant' AND firstName = 'Kristin'),
(SELECT instrumentID FROM Instruments WHERE name = 'Piano'),
'2025-01-27', 'Begin learning Mozart 2nd mov.'),
((SELECT studentID FROM Students
    WHERE lastName = 'Douglas' AND firstName = 'Bessie'),
(SELECT instrumentID FROM Instruments WHERE name = 'Guitar'),
'2025-01-29', NULL),
((SELECT studentID FROM Students
    WHERE lastName = 'McCoy' AND firstName = 'Jonathan'),
(SELECT instrumentID FROM Instruments WHERE name = 'Violin'),
'2025-01-27', NULL),
((SELECT studentID FROM Students
    WHERE lastName = 'Collins' AND firstName = 'Gary'),
(SELECT instrumentID FROM Instruments WHERE name = 'Guitar'),
'2025-01-27', NULL);

-- StudentInstrument sample data
INSERT INTO StudentInstrument (studentID, instrumentID, status) VALUES
((SELECT studentID FROM Students
    WHERE lastName = 'McCoy' AND firstName = 'Jonathan'),
(SELECT instrumentID FROM Instruments WHERE name = 'Violin'), 'Owned'),
((SELECT studentID FROM Students
    WHERE lastName = 'Collins' AND firstName = 'Gary'),
(SELECT instrumentID FROM Instruments WHERE name = 'Violin'), 'Rented'),
((SELECT studentID FROM Students
    WHERE lastName = 'Collins' AND firstName = 'Gary'),
(SELECT instrumentID FROM Instruments WHERE name = 'Guitar'), 'Rented'),
((SELECT studentID FROM Students
    WHERE lastName = 'Bryant' AND firstName = 'Kristin'),
(SELECT instrumentID FROM Instruments WHERE name = 'Piano'), 'Owned'),
((SELECT studentID FROM Students
    WHERE lastName = 'Douglas' AND firstName = 'Bessie'),
(SELECT instrumentID FROM Instruments WHERE name = 'Guitar'), 'Owned');

-- StudentPiece sample data
INSERT INTO StudentPiece
    (StudentId, pieceID, dateAssigned, dateCompleted) 
VALUES
((SELECT studentID FROM Students
    WHERE lastName = 'McCoy' AND firstName = 'Jonathan'),
(SELECT pieceID FROM Pieces WHERE title = 'Scottish Fantasy, Op.46'),
'2024-11-11', NULL),
((SELECT studentID FROM Students
    WHERE lastName = 'McCoy' AND firstName = 'Jonathan'),
(SELECT pieceID FROM Pieces WHERE title = 'Partita No.3 in E major, BWV 1006'),
'2024-12-09', NULL),
((SELECT studentID FROM Students
    WHERE lastName = 'Bryant' AND firstName = 'Kristin'),
(SELECT pieceID FROM Pieces WHERE title = 'Invention in C major, BWV 772'),
'2024-11-04', NULL),
((SELECT studentID FROM Students
    WHERE lastName = 'Bryant' AND firstName = 'Kristin'),
(SELECT pieceID FROM Pieces WHERE title = 'Sonata No.16 in C major, K.545'),
'2024-11-11', NULL),
((SELECT studentID FROM Students
    WHERE lastName = 'Collins' AND firstName = 'Gary'),
(SELECT pieceID FROM Pieces 
    WHERE title = 'Partita No.3 in E major, BWV 1006'),
'2024-10-28', '2025-01-27'),
((SELECT studentID FROM Students
    WHERE lastName = 'Collins' AND firstName = 'Gary'),
(SELECT pieceID FROM Pieces 
    WHERE title = 'Introduction and Variations on a Theme by Mozart, Op.9'),
'2024-11-04', NULL),
((SELECT studentID FROM Students
    WHERE lastName = 'Douglas' AND firstName = 'Bessie'),
(SELECT pieceID FROM Pieces 
    WHERE title = 'Introduction and Variations on a Theme by Mozart, Op.9'),
'2024-06-11', '2024-09-23');

SET FOREIGN_KEY_CHECKS=1;
COMMIT;  