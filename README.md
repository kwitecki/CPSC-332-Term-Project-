# CPSC-332-Term-Project-

## Project Requirements Compliance

This database project meets all specified requirements:

### Database Schema Requirements:
1. **Professor Information**: SSN (primary key), name, complete address (street, city, state, zip), telephone (area code + 7 digits), sex, title, salary, and college degrees (separate table)
2. **Department Information**: Unique number, name, telephone, office location, and chairperson (professor)
3. **Course Information**: Unique course number, title, textbook, units, prerequisites (M:N relationship), and department association
4. **Section Information**: Section number (unique within course), classroom, seats, meeting days, start/end times, and assigned professor
5. **Student Information**: Campus-wide ID, complete name (first/last), address, telephone, major department, and multiple possible minors
6. **Enrollment Records**: Student, course section, and grade with proper constraints

### Data Requirements:
- 8 students (exactly 8 records)
- 2 departments (Computer Science, Mathematics)
- 3 professors (Ada Lovelace, Edsger Dijkstra, Grace Hopper)
- 4 courses (CPSC332, CPSC131, MATH150A, MATH150B)
- 6 sections (distributed across courses)
- 20 enrollment records (exactly 20 records)

### Interface Requirements:
**For Professors:**
- (a) Given professor SSN - list class titles, classrooms, meeting days/times
- (b) Given course number and section - count students by grade distribution

**For Students:**
- (a) Given course number - list sections with classrooms, times, and enrollment counts
- (b) Given student CWID - list all courses taken and grades received

## Setup
1. Install PHP 7.4+ with PDO MySQL and access to a MySQL/MariaDB server.
2. Create a database (e.g., `university_db`) and load the schema then sample data:
   - `sudo mysql < sql/schema.sql`
   - `sudo mysql < sql/sample.sql`
3. Configure database connection by either:
   - **Option A**: Create a `.env` file in the project root:
     ```
     DB_HOST=127.0.0.1
     DB_NAME=university_db
     DB_USER=root
     DB_PASS=your_password
     DB_CHARSET=utf8mb4
     ```
   - **Option B**: Edit `app/db.php` directly with your database credentials
4. Start the PHP built-in server from the repo root:
   `php -S localhost:8000 -t public`

## Usage
- Home: http://localhost:8000/
- Professor interfaces: http://localhost:8000/professors.php
- Student interfaces: http://localhost:8000/students.php

## Testing & Verification
To verify all requirements are met, run the test queries:
```bash
mysql -u root -p university_db < sql/test_requirements.sql
```

### Sample Test Data:
- Professor SSN for testing: `111223333` (Ada Lovelace)
- Course Number for testing: `CPSC332`
- Section Number for testing: `01`
- Student CWID for testing: `000000001` (Ian Gerodias)

### Database Features:
- Referential Integrity: All foreign keys properly enforced
- Complex Relationships: M:N for course prerequisites and student minors
- Composite Keys: Course sections use (course_no, section_no)
- Enumerated Values: Grades and sex fields use controlled vocabularies
- Data Validation: Check constraints prevent self-referencing prerequisites

## Deployment in Restricted Environments

If you need to deploy this project in an environment where you don't have `sudo` access, follow these steps:

### Prerequisites
- PHP CLI access with PDO and MySQL extensions
- Access to a MySQL/MariaDB database (credentials provided by hosting/admin)
- Ability to create files in your directory

### Step-by-Step Deployment

#### 1. Check PHP Extensions
```bash
php -m | grep -i pdo
php -m | grep -i mysql
```
If these extensions are missing, contact your administrator or use a different server.

#### 2. Upload Project Files
Transfer all project files to target directory, maintaining the folder structure.

#### 3. Set Up Database
Since you can't use `sudo mysql`, you'll need to use provided database credentials:

**Option A: Using MySQL CLI (if available)**
```bash
mysql -h hostname -u username -p database_name < sql/schema.sql
mysql -h hostname -u username -p database_name < sql/sample.sql
```

**Option B: Using phpMyAdmin or Web Interface**
- Copy the contents of `sql/schema.sql` and execute it
- Copy the contents of `sql/sample.sql` and execute it

#### 4. Configure Database Connection
**IMPORTANT:** Without Composer installed, `.env` files are NOT loaded. You MUST edit `app/db.php` directly.

**Edit `app/db.php` with your credentials:**
```php
// Replace the fallback values in app/db.php (lines 6-10):
$host = 'your_mysql_host';      // e.g., 'mysql.example.com' or 'localhost'
$db   = 'your_database_name';   // e.g., 'user123_university' or 'university_db'
$user = 'your_username';        // e.g., 'user123_web' (credentials from hosting)
$pass = 'your_password';        // provided password from hosting/admin
```

**Note:** The default values (`root` with empty password) are for local development only. In restricted/shared hosting environments, use the database credentials provided by your hosting provider or administrator.

#### 5. Start the Application
```bash
# Run from project root directory:
php -S localhost:8000 -t public
```

### Common Shared Hosting Scenarios

**Typical shared hosting credentials might look like:**
```env
DB_HOST=mysql.yourhostingprovider.com
DB_NAME=username_university_db
DB_USER=username_dbuser
DB_PASS=randomly_generated_password
DB_CHARSET=utf8mb4
```

**Key differences from local development:**
- Database host is often not `localhost`
- Database names are usually prefixed with your username
- You use existing credentials rather than creating new MySQL users
- You may need to import SQL files through a web interface

### Troubleshooting
- **"could not find driver"**: PHP MySQL extension not installed - contact admin
- **"Access denied"**: Check database credentials with your hosting provider
- **"Unknown database"**: Ensure database was created and SQL files imported
- **Connection refused**: Verify the correct database host/port

## Notes
- Ensure only the `public/` directory is exposed if hosting behind Apache/Nginx.
- If you don't have Composer available, you can skip the `.env` file and edit database credentials directly in `app/db.php`.
- The project works with or without additional dependencies - all core functionality is built with standard PHP.
