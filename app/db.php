<?php
function db(): PDO {
  static $pdo;
  if ($pdo) return $pdo;

  $host = $_ENV['DB_HOST'] ?? '127.0.0.1';
  $db   = $_ENV['DB_NAME'] ?? 'university';
  $user = $_ENV['DB_USER'] ?? 'root';
  $pass = $_ENV['DB_PASS'] ?? '';
  $charset = $_ENV['DB_CHARSET'] ?? 'utf8mb4';

  $dsn = "mysql:host=$host;dbname=$db;charset=$charset";
  $opt = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES => false
  ];
  return $pdo = new PDO($dsn, $user, $pass, $opt);
}
