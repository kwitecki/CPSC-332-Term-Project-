<?php
require __DIR__ . '/../app/bootstrap.php';
ob_start(); ?>
<p>Choose a role:</p>
<ul>
  <li><a href="/professors.php">Professor Interfaces</a></li>
  <li><a href="/students.php">Student Interfaces</a></li>
</ul>
<?php
require __DIR__ . '/../app/views/layout.php';
render('University DB', ob_get_clean());
