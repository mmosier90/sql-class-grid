--Table deletions; skip for now
DROP TABLE cmhs_Section;
DROP TABLE cmhs_Staff;
DROP TABLE cmhs_Roster;
DROP TABLE cmhs_Course;
DROP TABLE cmhs_Student;


-- Creating the Staff Table
CREATE TABLE cmhs_Staff  (
   -- Columns
   cmhs_StaffID int identity,
   StaffFirstName varchar(25) NOT NULL,
   StaffLastName varchar(25) NOT NULL,
   StaffMiddleName varchar(25),
   StaffEmailAddress varchar(100) NOT NULL,
   Admin BIT,
   Role char(50),
   -- Constraints
   CONSTRAINT PK_cmhs_Staff PRIMARY KEY (cmhs_StaffID),
   CONSTRAINT U1_cmhs_Staff UNIQUE (StaffEmailAddress)
);
--Check Staff Table
SELECT * FROM cmhs_Staff;


-- Creating the Course Table
CREATE TABLE cmhs_Course  (
   -- Columns
   cmhs_CourseID int identity,
   CourseName varchar(100) NOT NULL,
   DI BIT,
   Honors BIT,
   AP BIT,
   GenEd BIT
   --Constraints
   CONSTRAINT PK_cmhs_Course PRIMARY KEY (cmhs_CourseID),
   CONSTRAINT U1_cmhs_Course UNIQUE (CourseName)
);
--Check Course Table
SELECT * FROM cmhs_Course;


-- Creating the Student Table
CREATE TABLE cmhs_Student  (
   -- Columns
   cmhs_StudentID int identity,
   StdntFirstName varchar(25) NOT NULL,
   StdntLastName varchar(25) NOT NULL,
   StdntMiddleName varchar(25),
   StdntEmailAddress char(100) NOT NULL,
   GPA DECIMAL(3,2),
   SATScore int,
   APScore int,
   Attendance int
   -- Constraints
   CONSTRAINT PK_cmhs_Student PRIMARY KEY (cmhs_StudentID),
);
--Check Student Table
SELECT * FROM cmhs_Student;


-- Creating the Course Section Table
CREATE TABLE cmhs_Section  (
   -- Columns
   cmhs_SectionNumber int identity,
   Period varchar(10) NOT NULL,
   Room varchar(10) NOT NULL,
   StaffID int,
   CourseNum int,
   SectionType varchar(25)
   -- Constraints
   CONSTRAINT PK_cmhs_Section PRIMARY KEY (cmhs_SectionNumber)
   CONSTRAINT FK1_cmhs_Section FOREIGN KEY (StaffID) REFERENCES cmhs_Staff(cmhs_StaffID),
   CONSTRAINT FK2_cmhs_Section FOREIGN KEY (CourseNum) REFERENCES cmhs_Course(cmhs_CourseID)
)
--Check Course Section Table
SELECT * FROM cmhs_Section;


-- Creating the Roster Table
CREATE TABLE cmhs_Roster  (
   -- Columns
   rosternum int identity,
   SectionNum int,
   StudentNum int,
   GradePercent int,
   GradeLetter varchar(5)
   -- Constraints
   CONSTRAINT PK_cmhs_Roster PRIMARY KEY (rosternum),
   CONSTRAINT FK1_cmhs_Roster FOREIGN KEY (SectionNum) REFERENCES cmhs_Section(cmhs_SectionNumber),
   CONSTRAINT FK2_cmhs_Roster FOREIGN KEY (StudentNum) REFERENCES cmhs_Student(cmhs_StudentID)
);
--Check Roster Table
SELECT * FROM cmhs_Roster;


--Adding data to Staff Table
INSERT INTO cmhs_STAFF
   (StaffFirstName, StaffLastName, StaffMiddleName, StaffEmailAddress, Admin, Role)
VALUES
   ('Dwayna','Sanchez',NULL,'dsanchez@catdomain.xyz',1,'Principal'),
   ('Arnold','Twist','Patrick','aptwist@catdomain.xyz',1,'DirectorSPED'),
   ('Marina','Moore','Sue','msmoore@catdomain.xyz',0,'Teacher'),
   ('Jorge','Rudy','Cross','jcrudy@catdomain.xyz',0,'Teacher'),
   ('Terrell','Jones','Charles','tcjones@catdomain.xyz',0,'TeacherSPED')
--Check Staff Table
SELECT * FROM cmhs_Staff;


--Adding data to Course Table
INSERT INTO cmhs_Course
   (CourseName, DI, Honors, AP, GenEd)
VALUES
   ('Algebra',1,1,0,1),
   ('Biology',1,1,1,1),
   ('BasketWeaving',0,0,0,1),
   ('English',1,0,0,1),
   ('Art',0,0,0,1)
--Check Course Table
SELECT * FROM cmhs_Course;


--Adding data to Student Table
INSERT INTO cmhs_Student
   (StdntFirstName, StdntLastName, StdntMiddleName, StdntEmailAddress, GPA, SATScore, APScore, Attendance)
VALUES
   ('Julia','Torres','Lee','julialtorres@catdomain.xyz',2.47,1500,NULL,89),
   ('Samuel','Townsend',NULL,'samueltownsend@catdomain.xyz',3.45,1280,2,25),
   ('Francis','Mosier','James','francisjmosier@catdomain.xyz',2.64,1430,NULL,54),
   ('Gabriel','Childs','Chris','gabrielcchilds@catdomain.xyz',3.98,1100,4,78),
   ('Noel','Robb',NULL,'noelrobb@catdomain.xyz',3.5,980,3,97)
--Check Student Table
SELECT * FROM cmhs_Student;

--Adding data to Section Table
INSERT INTO cmhs_Section
   (Period, Room, StaffID, CourseNum, SectionType)
VALUES
	('1','336',3,1,'H'),
	('2','336',4,1,'G'),
	('3','336',5,1,'DI'),
	('1','321',5,2,'DI'),
	('2','321',3,2,'AP'),
	('3','321',4,2,'G'),
	('3','212',3,3,'G'),
	('2','330',5,4,'G'),
	('1','102',4,5,'G')
--Check Section Table
SELECT * FROM cmhs_Section;


--Adding data to Roster Table
INSERT INTO cmhs_Roster
   (SectionNum, StudentNum, GradePercent, GradeLetter)
VALUES
   (3,3,89,'B+'),
   (1,1,73,'C-'),
   (1,2,34,'F'),
   (2,4,54,'F'),
   (2,5,78,'C+'),
   (4,3,68,'D+'),
   (4,5,84,'B'),
   (5,2,62,'D-'),
   (6,1,91,'A-'),
   (6,4,80,'B-'),
   (7,2,74,'C'),
   (7,5,97,'A+'),
   (8,1,54,'F'),
   (8,3,85,'B'),
   (9,4,94,'A')
--Check Roster Table
SELECT * FROM cmhs_Roster;


--QCHECK: So what classes does Ms. Moore teach, in order?
SELECT Period, CourseName, SectionType
FROM cmhs_Section
JOIN cmhs_Staff ON cmhs_Section.StaffID = cmhs_Staff.cmhs_StaffID
JOIN cmhs_Course ON cmhs_Section.CourseNum = cmhs_Course.cmhs_CourseID
WHERE StaffID = 3
ORDER BY Period
--Here, you can change StaffID = 3 to any number and find a teacher's schedule


--Find Student Schedule
--Aggregate class data - GPA, SAT, AP, Attendance - by section#
