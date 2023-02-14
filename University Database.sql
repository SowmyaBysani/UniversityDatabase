----CREATE DATABASE
CREATE DATABASE [db_studentdatase];
USE [StudentDatabase];

------------------------------------------------------------------------------------------------------------------------------
-----CREATE TABLE
CREATE TABLE [dbo].[t_Uicdepartment](
[dept_name] [varchar](25) NOT NULL PRIMARY KEY,
[building] [varchar](15) NOT NULL,
[budget] [int] NOT NULL
);


CREATE TABLE [dbo].[UIC_instructor](
[instructor_id] [int] NOT NULL PRIMARY KEY,
[name] [varchar](20) NOT NULL,
[salary] [int] NOT NULL,
[dept_name] [varchar](25) NOT NULL REFERENCES [dbo].[t_Uicdepartment]([dept_name])
);

CREATE TABLE [dbo].[UIC_student](
[student_id] [int] NOT NULL PRIMARY KEY,
[name] [varchar](20) NOT NULL,
[tot_cred] [int] NOT NULL,
[instructor_id] [int] NULL REFERENCES [dbo].[UIC_instructor]([instructor_id]),
[dept_name] [varchar](25) NOT NULL REFERENCES [dbo].[t_Uicdepartment]([dept_name])
);


CREATE TABLE [dbo].[UIC_course](
[course_id] [int] NOT NULL PRIMARY KEY,
[title] [varchar](20) NOT NULL,
[credits] [smallint] NOT NULL,
[prereq] [int] NULL REFERENCES [dbo].[UIC_course]([course_id]),
[dept_name] [varchar](25) NOT NULL REFERENCES [dbo].[t_Uicdepartment]([dept_name])
);


CREATE TABLE [dbo].[UIC_time_slot](
[time_slot_id]  VARCHAR(30) NOT NULL PRIMARY KEY, --example MO_15:00_to_18:00
[day] [char](2) NOT NULL,
[start_time] [time] NOT NULL,
[end_time] [time] NOT NULL,
CONSTRAINT valid_day CHECK ([day] in ('SU','MO','TU','WE','TH','FR','SA'))
);


CREATE TABLE [dbo].[UIC_classroom](
[building] [char](1) NOT NULL,
[room_number] [int] NOT NULL,
[capacity] [int] NULL,
CONSTRAINT PK_classroom_id PRIMARY KEY ([building],[room_number])
);


CREATE TABLE [dbo].[UIC_section](
[section_id] [varchar](4) NOT NULL,
[semester] [varchar](15) NOT NULL,
[year] [int] NOT NULL,
[instructor_id] [int] NOT NULL REFERENCES [dbo].[UIC_instructor]([instructor_id]),
[student_id] [int] NULL REFERENCES [dbo].[UIC_student]([student_id]),
[course_id] [int] NOT NULL REFERENCES [dbo].[UIC_course]([course_id]),
[time_slot_id]  [VARCHAR] (30) NOT NULL REFERENCES [dbo].[UIC_time_slot]([time_slot_id]),
[building] [char](1) NOT NULL,
[room_number] [int] NOT NULL,
[grade] char(1) NULL,
CONSTRAINT valid_grade CHECK ([grade] in ('F','D','C','B','A')),
FOREIGN KEY ([building],[room_number])  REFERENCES [dbo].[UIC_classroom]([building],[room_number])
);

-----------------------------------------------------------------------------------------------------------------------------
-----INSERTING VALUES

INSERT INTO t_Uicdepartment VALUES ('Public Health','A.Taylor',35000),
('Management','MGMNT220',78500),
('Architecture','S.Harward',40000),
('Business','Liautaud',100000),
('Engineering','A.Einstien',87500),
('Law','Harvey Specter',90000),
('Liberal Arts','Michael Smith',30000),
('Medicine','Med12',95000),
('Music','Tansen',30000),
('Urban Planning','UP02',12000);

INSERT INTO UIC_instructor VALUES (29879,'Jim John',71000,'Public Health'),
(12199,'Mary Carter',79000,'Management'),
(21832,'Nancy Gillian',60000,'Music'),
(33476,'Karen Lail',65000,'Music'),
(25191,'James Willians',98000,'Business'),
(21091,'Lucy Davis',75000,'Law'),
(30017,'Albert Ross',67500,'Engineering'),
(20174,'Samantha Taylor',90000,'Medicine'),
(35271,'Linda Mckinze',82000,'Business'),
(28105,'Tim Jackson',50000,'Urban Planning'),
(10362,'Charles Jones',60500,'Liberal Arts'),
(27563,'Jennifer Miller',78500,'Engineering'),
(18491,'Elizabeth Lail',80550,'Law'),
(29633,'Linda Wright',95000,'Business'),
(36345,'Joseph Hill',79000,'Architecture');


INSERT INTO UIC_student VALUES (980112,'Eduard Mendy',16,29879,'Public Health'),
(805631,'Cesar Azpilicueta',12,12199,'Management'),
(992744,'Antonio Rudiger',18,21832,'Music'),
(894092,'Andreas Christensen',12,33476,'Music'),
(939211,'Trevoh Chalobah',14,25191,'Business'),
(784167,'Thiago Silva',16,21091,'Law'),
(948489,'Malang Sarr',18,30017,'Engineering'),
(874985,'Marcos Alonso',16,20174,'Medicine'),
(992921,'Ben Chilwell',16,35271,'Business'),
(879243,'Reece James',18,28105,'Urban Planning'),
(879175,'Hudson Odoi',16,10362,'Liberal Arts'),
(982747,'Jorginho Frella',12,27563,'Engineering'),
(846478,'Mateo Kovacic',18,18491,'Law'),
(982828,'Ngolo Kante',12,29633,'Business'),
(973883,'Samantha Kerr',16,36345,'Architecture'),
(878569,'Fran Kirby',12,20174,'Medicine'),
(792454,'Magdalena Eriksson',18,10362,'Liberal Arts'),
(974574,'Lauren James',14,30017,'Engineering'),
(899569,'Melaine Leupolz',16,35271,'Business'),
(974583,'Jessie Fleming',12,21091,'Law'),
(899937,'Millie Bright',18,35271,'Business'),
(992394,'Guro Reiten',12,29879,'Public Health'),
(957856,'Jessica Carter',14,20174,'Medicine'),
(892345,'Carly Telford',16,30017,'Engineering'),
(729329,'Lina Hurtig',12,12199,'Management'),
(972324,'Sara Gama',16,35271,'Business'),
(753858,'Jessica Smith',12,NULL,'Engineering'),
(828348,'Samantha Stosar',16,NULL,'Business');



INSERT INTO UIC_course VALUES (102,'Structure Design',4,NULL,'Architecture'),
(120,'Building Design',4,102,'Architecture'),
(270,'Data Mining',4,NULL,'Business'),
(276,'Data Visualization',2,270,'Business'),
(255,'Corporate Finance',4,NULL,'Business'),
(330,'Thermodynamics',2,NULL,'Engineering'),
(350,'Gravitation',4,330,'Engineering'),
(425,'Case Closure',4,NULL,'Law'),
(435,'Pro-Bono',2,425,'Law'),
(505,'Mural Art',4,NULL,'Liberal Arts'),
(601,'Intro to Management',4,NULL,'Management'),
(675,'Stats for Mangement',4,601,'Management'),
(705,'How to CRP',4,NULL,'Medicine'),
(810,'Opera Singing',2,NULL,'Music'),
(820,'Indian Classical',4,810,'Music'),
(918,'Sanitization II',4,NULL,'Public Health'),
(1005,'City Planning',4,NULL,'Urban Planning');


INSERT INTO UIC_time_slot VALUES ('MO_09:00_to_12:00','MO','09:00','12:00'),
('MO_17:30_to_20:30','MO','17:30','20:30'),
('TU_11:00_to_12:00','TU','09:00','12:00'),
('TU_12:00_to_15:00','TU','12:00','15:00'),
('WE_09:00_to_12:00','WE','09:00','12:00'),
('WE_15:00_to_18:00','WE','15:00','18:00'),
('TH_12:00_to_15:00','TH','12:00','15:00'),
('TH_17:30_to_20:30','TH','17:30','20:30'),
('FR_09:00_to_12:00','FR','09:00','12:00'),
('FR_12:00_to_15:00','FR','12:00','15:00'),
('FR_17:30_to_20:30','FR','17:30','20:30'),
('SA_09:00_to_12:00','SA','09:00','12:00'),
('SA_12:00_to_15:00','SA','12:00','15:00');

INSERT INTO UIC_classroom VALUES ('A',102,80),
('A',105,NULL),
('B',203,130),
('B',206,125),
('C',201,58),
('C',207,62),
('C',305,NULL),
('D',201,80),
('D',206,NULL),
('D',209,75),
('E',203,NULL),
('E',208,80),
('F',301,76),
('F',306,80),
('G',206,90),
('G',209,NULL),
('H',201,NULL),
('H',205,70),
('H',301,49),
('I',301,90),
('I',309,NULL),
('J',204,70),
('J',207,90),
('J',209,NULL);

INSERT INTO UIC_section VALUES 
('ARC2','FALL',2021,29879,973883,120,'FR_12:00_to_15:00','A',102,'A'),
('ARC2','FALL',2020,29879,973883,102,'MO_09:00_to_12:00','A',105,'B'),
('LBA1','SPRING',2021,10362,792454,505,'FR_09:00_to_12:00','B',203,'A'),
('MGM2','FALL',2020,12199,729329,601,'SA_12:00_to_15:00','C',207,'D'),
('MGM2','FALL',2020,12199,805631,675,'SA_12:00_to_15:00','C',207,'B'),
('LAW1','SPRING',2021,18491,784167,435,'TH_12:00_to_15:00','D',201,'F'),
('LAW2','SPRING',2021,18491,846478,425,'TU_12:00_to_15:00','D',206,'A'),
('LAW2','SPRING',2021,18491,974583,425,'TU_12:00_to_15:00','D',206,'B'),
('MDC8','FALL',2021,20174,874985,705,'WE_09:00_to_12:00','E',203,'A'),
('MDC8','FALL',2020,20174,878569,705,'WE_09:00_to_12:00','E',208,'A'),
('LAW5','SPRING',2021,21091,846478,435,'TH_17:30_to_20:30','D',209,'F'),
('MSC2','FALL',2020,21832,894092,810,'FR_09:00_to_12:00','F',301,'C'),
('MSC2','FALL',2021,21832,894092,820,'FR_12:00_to_15:00','F',306,'B'),
('BUS1','SPRING',2021,25191,828348,255,'FR_17:30_to_20:30','H',201,'A'),
('BUS5','FALL',2021,25191,899569,270,'MO_09:00_to_12:00','H',205,'C'),
('ENG2','FALL',2020,27563,753858,350,'MO_17:30_to_20:30','G',206,'F'),
('ENG2','SPRING',2019,27563,892345,330,'SA_09:00_to_12:00','G',209,'A'),
('ENG2','SPRING',2020,27563,982747,330,'SA_12:00_to_15:00','G',206,'B'),
('UPL3','FALL',2021,28105,879243,1005,'TH_12:00_to_15:00','I',309,'A'),
('PBH9','FALL',2019,29879,980112,918,'TH_17:30_to_20:30','J',204,'B'),
('ENG8','FALL',2020,30017,948489,350,'TU_09:00_to_12:00','G',206,'F'),
('ENG9','SPRING',2020,30017,974574,330,'TU_12:00_to_15:00','G',209,'B'),
('BUS2','FALL',2019,35271,939211,276,'WE_09:00_to_12:00','H',301,'B'),
('BUS8','SPRING',2019,35271,939211,270,'WE_15:00_to_18:00','H',205,'A'),
('BUS8','SPRING',2019,35271,972324,270,'WE_15:00_to_18:00','H',205,'A'),
('BUS7','FALL',2020,35271,982828,270,'WE_15:00_to_18:00','H',301,'C'),
('BUS5','FALL',2019,35271,992921,270,'SA_12:00_to_15:00','H',205,'A');


SELECT * FROM t_Uicdepartment order by budget desc;
SELECT * FROM UIC_instructor;
SELECT * FROM UIC_student;
SELECT * FROM UIC_course
SELECT * FROM UIC_time_slot;
SELECT * FROM UIC_classroom;
SELECT * FROM UIC_section;
------------------------------------------------------------------------------------------------------------------------------




--------------------------------------------------QUERIES--------------------------------------------------------------



-----QUERY1

SELECT UIC_instructor.instructor_id ,UIC_instructor.name, UIC_student.student_id, UIC_student.name
FROM UIC_student
INNER JOIN UIC_instructor
ON UIC_student.instructor_id = UIC_instructor.instructor_id

--QUERY 2
SELECT UIC_student.name , UIC_student.tot_cred FROM UIC_student WHERE dept_name= 'Business';

--QUERY 3
SELECT t_Uicdepartment.dept_name ,  MIN([budget]) AS [Budget]
FROM t_Uicdepartment
GROUP BY t_Uicdepartment.dept_name 
HAVING MIN([budget])>50000

--QUERY 4
SELECT UIC_instructor.name , UIC_instructor.salary
 FROM UIC_instructor WHERE salary = (SELECT MAX(salary) FROM UIC_instructor);

--QUERY 5
 SELECT COUNT(name) FROM UIC_student WHERE tot_cred = 12;

--QUERY 6
 SELECT UIC_course.title , UIC_section.semester 
 FROM UIC_course
 INNER JOIN UIC_section
 ON UIC_course.course_id = UIC_section.course_id


--QUERY 7
 SELECT UIC_student.name
 FROM UIC_student
 WHERE student_id
 IN ( SELECT student_id FROM UIC_section WHERE semester = 'FALL');

--Query 8
--Number of students in each department
select COUNT(student_id) as NumberOfStudents ,dept_name FROM UIC_student Group By dept_name;

--Query 9
--List courses in which no prerequisite is required
select course_id,title,dept_name from UIC_course where prereq is NOT NULL;

--Query 10
--Number of students in each course
SELECT UIC_course.course_id, COUNT(UIC_student.student_id) AS NumberOfStudents FROM UIC_student
INNER JOIN t_Uicdepartment ON t_Uicdepartment.dept_name = UIC_student.dept_name
INNER JOIN UIC_course ON t_Uicdepartment.dept_name = UIC_course.dept_name
GROUP BY course_id;

--Query 11
--Sort courses by number of credits in ascending order
SELECT course_id, title, credits from UIC_course ORDER BY credits;

--Query 12
--Average Salary of instructor of each department
select dept_name, AVG(salary) as AverageSalary from UIC_instructor GROUP BY dept_name ORDER BY AverageSalary desc;

--Query 13
-- Get details related to a section when section id is ARC2
select UIC_section.instructor_id,UIC_instructor.name as InstructorName, section_id,course_id, time_slot_id,semester from UIC_section 
INNER JOIN UIC_instructor on UIC_instructor.instructor_id = UIC_section.instructor_id
where section_id = 'ARC2';

--Query 14
--Get max salary of instructor in Architecture department
select dept_name,MAX(salary) as MaxSalary from UIC_instructor WHERE dept_name = 'Architecture' Group BY dept_name;

--Query 15
--Listing all the student_id with the semester, section & course_id with year and grade
Select student_id, semester, year, section_id, course_id, grade FROM UIC_section WHERE semester = 'FALL' 
ORDER BY year DESC, grade ASC;  

--Query 16
--Lists the Count of Students per instructor sorted alphabetically
SELECT UIC_instructor.instructor_id ,UIC_instructor.name, COUNT(UIC_student.student_id) AS "Student Per Instructor" FROM UIC_student
INNER JOIN UIC_instructor ON UIC_student.instructor_id = UIC_instructor.instructor_id 
GROUP BY UIC_instructor.instructor_id ,UIC_instructor.name
ORDER BY UIC_instructor.name ASC;

--Query 17
--Average Capacity of classroom from classrrom table
 SELECT AVG(capacity) AS 'Classroom Capacity' FROM UIC_classroom;

--Query 18
--StudentId with Instructorid who got failed in fall & Spring semsester
SELECT student_id, instructor_id, semester, grade FROM UIC_section WHERE GRADE = 'F';

--Query 19
--Lists all the instructors name starting with ‘L’ 
SELECT * FROM UIC_instructor
WHERE name LIKE 'l_%'; 

--Query 20
--Student_id with name, schedule & location details
SELECT UIC_section.student_id, UIC_student.name, UIC_section.building, UIC_section.room_number, UIC_section.time_slot_id
FROM UIC_section
RIGHT JOIN UIC_student
ON UIC_section.student_id = UIC_student.student_id
WHERE UIC_section.student_id IS NOT NULL
UNION
   SELECT UIC_section.student_id, UIC_student.name, UIC_section.building, UIC_section.room_number, UIC_section.time_slot_id
   FROM UIC_section
   LEFT JOIN UIC_student
   ON UIC_section.student_id = UIC_student.student_id;

-------------------------------------------------------------------------------------------------------------------------


