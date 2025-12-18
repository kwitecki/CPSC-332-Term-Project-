-- Departments
INSERT INTO departments (dept_name, dept_phone, office_location) VALUES
('Computer Science','657-278-3700','CS-200'),
('Mathematics','657-278-1000','MH-300');

-- Professors
INSERT INTO professors (ssn,first_name,last_name,street,city,state,zip,phone_area,phone_number,sex,title,salary,dept_id)
VALUES
('111223333','Ada','Lovelace','123 Algorithm Ave','Fullerton','CA','92831','657','5550001','F','Professor',150000,1),
('222334444','Edsger','Dijkstra','456 Shortest Path St','Fullerton','CA','92831','657','5550002','M','Professor',155000,1),
('333445555','Grace','Hopper','789 Compiler Blvd','Fullerton','CA','92831','657','5550003','F','Professor',160000,2);

INSERT INTO professor_degrees (ssn,degree,institution,year) VALUES
('111223333','Ph.D. CS','UT Austin',2012),
('222334444','Ph.D. CS','CMU',2010),
('333445555','Ph.D. Math','Harvard',2005);

-- Courses
INSERT INTO courses (course_no,title,textbook,units,dept_id) VALUES
('CPSC332','File Structures and DB','Elmasri & Navathe',3.0,1),
('CPSC131','Data Structures','Weiss',3.0,1),
('MATH150A','Calculus I','Stewart',4.0,2),
('MATH150B','Calculus II','Stewart',4.0,2);

-- Prereqs
INSERT INTO course_prereqs (course_no,prereq_no) VALUES
('CPSC332','CPSC131'),
('MATH150B','MATH150A');

-- Sections (6 total)
INSERT INTO sections (course_no,section_no,classroom,seats,meeting_days,start_time,end_time,professor_ssn) VALUES
('CPSC332','01','CS-101',35,'TuTh','10:00','11:15','111223333'),
('CPSC332','02','CS-102',35,'TuTh','13:30','14:45','222334444'),
('CPSC131','01','CS-201',40,'MWF','09:00','09:50','222334444'),
('MATH150A','03','MH-110',45,'MWF','11:00','11:50','333445555'),
('MATH150B','01','MH-120',45,'TuTh','12:00','13:15','333445555'),
('MATH150B','02','MH-121',45,'TuTh','15:00','16:15','333445555');

-- Students (8)
INSERT INTO students (cw_id,first_name,last_name,street,city,state,zip,phone_area,phone_number,major_dept_id) VALUES
('000000001','Ian','Gerodias','100 Student Dr','Fullerton','CA','92831','657','1110001',1),
('000000002','Alex','Kim','200 Campus Blvd','Fullerton','CA','92831','657','1110002',1),
('000000003','Sam','Lopez','300 University Ave','Fullerton','CA','92831','657','1110003',1),
('000000004','Riley','Chen','400 College St','Fullerton','CA','92831','657','1110004',1),
('000000005','Jordan','Singh','500 Scholar Way','Fullerton','CA','92831','657','1110005',2),
('000000006','Taylor','Nguyen','600 Academic Ln','Fullerton','CA','92831','657','1110006',2),
('000000007','Casey','Patel','700 Learning Ct','Fullerton','CA','92831','657','1110007',2),
('000000008','Avery','Garcia','800 Knowledge Rd','Fullerton','CA','92831','657','1110008',1);

-- Minors
INSERT INTO student_minors (cw_id,dept_id) VALUES
('000000001',2),('000000003',2),('000000005',1);

-- Set chairpersons for departments
UPDATE departments SET chair_ssn = '111223333' WHERE dept_name = 'Computer Science';
UPDATE departments SET chair_ssn = '333445555' WHERE dept_name = 'Mathematics';

-- Enrollments (≥20)
INSERT INTO enrollments (cw_id,course_no,section_no,grade) VALUES
('000000001','CPSC332','01','A'),
('000000002','CPSC332','01','B+'),
('000000003','CPSC332','01','A-'),
('000000004','CPSC332','02','B'),
('000000005','CPSC332','02','C+'),
('000000006','CPSC131','01','A'),
('000000007','CPSC131','01','B-'),
('000000008','CPSC131','01','A-'),
('000000001','MATH150A','03','A'),
('000000002','MATH150A','03','B'),
('000000003','MATH150A','03','B+'),
('000000004','MATH150B','01','A-'),
('000000005','MATH150B','01','B'),
('000000006','MATH150B','01','B+'),
('000000007','MATH150B','02','C'),
('000000008','MATH150B','02','B-'),
('000000001','MATH150B','02','A'),
('000000002','CPSC332','02','B+'),
('000000003','CPSC332','02','A'),
('000000004','MATH150A','03','A-');
