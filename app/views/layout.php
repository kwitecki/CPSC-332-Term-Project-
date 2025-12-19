<?php function render($title, $content) { ?>
<!DOCTYPE html>
<html><head>
<meta charset="UTF-8">
<title><?= htmlspecialchars($title) ?></title>
<style>
body{font-family:Arial,sans-serif;max-width:1200px;margin:0 auto;padding:20px;line-height:1.6}
nav{background:#f4f4f4;padding:10px;margin-bottom:20px;border-radius:5px}
nav a{margin-right:15px;text-decoration:none;color:#333;font-weight:bold}
nav a:hover{color:#007cba}
table{border-collapse:collapse;width:100%;margin-top:15px}
th,td{border:1px solid #ddd;padding:8px;text-align:left}
th{background-color:#f2f2f2}
tr:nth-child(even){background-color:#f9f9f9}
form{background:#f8f8f8;padding:15px;border-radius:5px;margin:10px 0}
form label{display:block;margin-bottom:10px;font-weight:bold}
form input{padding:5px;margin-left:10px;border:1px solid #ddd;border-radius:3px}
button{background:#007cba;color:white;padding:8px 15px;border:none;border-radius:3px;cursor:pointer}
button:hover{background:#005a87}
section{margin-bottom:30px;padding:20px;border:1px solid #eee;border-radius:5px}
h2{color:#333;border-bottom:2px solid #007cba;padding-bottom:5px}
</style>
</head><body>
<nav>
  <a href="/">Home</a>
  <a href="/professors.php">Professor Interfaces</a>
  <a href="/students.php">Student Interfaces</a>
</nav>
<h1><?= htmlspecialchars($title) ?></h1>
<main><?= $content ?></main>
<footer style="margin-top:40px;padding-top:20px;border-top:1px solid #eee;color:#666;text-align:center">
  <p>CPSC-332 Database Project - <?= date('Y') ?></p>
</footer>
</body></html>
<?php } ?>