# CPSC-332-Term-Project-

## Setup
1. Install PHP 7.4+ with PDO MySQL, Composer, and access to a MySQL/MariaDB server.
2. From the project root, install dependencies (Dotenv): `composer require vlucas/phpdotenv`.
3. Create a database (e.g., `university`) and load the schema then sample data:
   - `mysql -u root -p university < sql/schema.sql`
   - `mysql -u root -p university < sql/sample.sql`
4. Create a `.env` file in the project root (same level as `public/`):
   ```
   DB_HOST=127.0.0.1
   DB_NAME=university
   DB_USER=root
   DB_PASS=your_password
   DB_CHARSET=utf8mb4
   ```
5. Start the PHP built-in server from the repo root:
   `php -S localhost:8000 -t public public/index.php`

## Usage
- Home: http://localhost:8000/
- Professor interfaces: http://localhost:8000/professors.php
- Student interfaces: http://localhost:8000/students.php

## Notes
- Ensure only the `public/` directory is exposed if hosting behind Apache/Nginx.
- The pages include a missing `app/views/layout.php` template; add it (basic HTML layout) if you see a fatal error about that file.
