-- Create database and use it
CREATE DATABASE IF NOT EXISTS university_db;
USE university_db;

-- Drop in dependency order (dev convenience)
DROP TABLE IF EXISTS enrollments, student_minors, sections, course_prereqs,
  courses, students, professors, professor_degrees, departments;

-- Departments
CREATE TABLE departments (
  dept_id        INT AUTO_INCREMENT PRIMARY KEY,
  dept_name      VARCHAR(100) NOT NULL UNIQUE,
  dept_phone     VARCHAR(20),
  office_location VARCHAR(100),
  chair_ssn      CHAR(9)      -- FK to professors once that table exists
) ENGINE=InnoDB;

-- Professors
CREATE TABLE professors (
  ssn            CHAR(9) PRIMARY KEY,
  first_name     VARCHAR(50) NOT NULL,
  last_name      VARCHAR(50) NOT NULL,
  street         VARCHAR(100),
  city           VARCHAR(60),
  state          CHAR(2),
  zip            CHAR(5),
  phone_area     CHAR(3),
  phone_number   CHAR(7),
  sex            ENUM('M','F','X') NULL,
  title          VARCHAR(50),
  salary         DECIMAL(10,2),
  dept_id        INT NOT NULL,              -- department affiliation
  CONSTRAINT fk_prof_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
) ENGINE=InnoDB;

-- Professor degrees (1:N)
CREATE TABLE professor_degrees (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ssn CHAR(9) NOT NULL,
  degree VARCHAR(100) NOT NULL,
  institution VARCHAR(120),
  year SMALLINT,
  CONSTRAINT fk_deg_prof FOREIGN KEY (ssn) REFERENCES professors(ssn)
) ENGINE=InnoDB;

-- Courses
CREATE TABLE courses (
  course_no      VARCHAR(10) PRIMARY KEY,   -- unique number per spec
  title          VARCHAR(120) NOT NULL,
  textbook       VARCHAR(200),
  units          DECIMAL(3,1) NOT NULL,
  dept_id        INT NOT NULL,
  CONSTRAINT fk_course_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
) ENGINE=InnoDB;

-- Course prerequisites (M:N self-relationship on courses)
CREATE TABLE course_prereqs (
  course_no      VARCHAR(10) NOT NULL,
  prereq_no      VARCHAR(10) NOT NULL,
  PRIMARY KEY (course_no, prereq_no),
  CONSTRAINT fk_pr_course  FOREIGN KEY (course_no) REFERENCES courses(course_no),
  CONSTRAINT fk_pr_prereq  FOREIGN KEY (prereq_no) REFERENCES courses(course_no),
  CONSTRAINT chk_no_self_prereq CHECK (course_no <> prereq_no)
) ENGINE=InnoDB;

-- Sections (course has several sections; section number is unique within course)
CREATE TABLE sections (
  course_no      VARCHAR(10) NOT NULL,
  section_no     VARCHAR(8)  NOT NULL,
  classroom      VARCHAR(50),
  seats          INT,
  meeting_days   VARCHAR(10),       -- e.g., 'MWF', 'TuTh'
  start_time     TIME,
  end_time       TIME,
  professor_ssn  CHAR(9) NOT NULL,
  PRIMARY KEY (course_no, section_no),
  CONSTRAINT fk_sec_course FOREIGN KEY (course_no) REFERENCES courses(course_no),
  CONSTRAINT fk_sec_prof   FOREIGN KEY (professor_ssn) REFERENCES professors(ssn)
) ENGINE=InnoDB;

-- Students
CREATE TABLE students (
  cw_id          CHAR(9) PRIMARY KEY,       -- campus wide ID
  first_name     VARCHAR(50) NOT NULL,
  last_name      VARCHAR(50) NOT NULL,
  street         VARCHAR(100),
  city           VARCHAR(60),
  state          CHAR(2),
  zip            CHAR(5),
  phone_area     CHAR(3),
  phone_number   CHAR(7),
  major_dept_id  INT NOT NULL,
  CONSTRAINT fk_student_major FOREIGN KEY (major_dept_id) REFERENCES departments(dept_id)
) ENGINE=InnoDB;

-- Student minors (0..N)
CREATE TABLE student_minors (
  cw_id          CHAR(9) NOT NULL,
  dept_id        INT NOT NULL,
  PRIMARY KEY (cw_id, dept_id),
  CONSTRAINT fk_minor_student FOREIGN KEY (cw_id) REFERENCES students(cw_id),
  CONSTRAINT fk_minor_dept    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
) ENGINE=InnoDB;

-- Enrollments (Student x Section) with grade
CREATE TABLE enrollments (
  id             BIGINT AUTO_INCREMENT PRIMARY KEY,
  cw_id          CHAR(9) NOT NULL,
  course_no      VARCHAR(10) NOT NULL,
  section_no     VARCHAR(8)  NOT NULL,
  grade          ENUM('A','A-','B+','B','B-','C+','C','C-','D+','D','D-','F','W','I') NULL,
  CONSTRAINT fk_enr_student  FOREIGN KEY (cw_id) REFERENCES students(cw_id),
  CONSTRAINT fk_enr_section  FOREIGN KEY (course_no, section_no) REFERENCES sections(course_no, section_no),
  UNIQUE KEY uq_one_enroll_per_section (cw_id, course_no, section_no)
) ENGINE=InnoDB;

-- Back-fill chair FK now that professors exists
ALTER TABLE departments
  ADD CONSTRAINT fk_dept_chair FOREIGN KEY (chair_ssn) REFERENCES professors(ssn);
