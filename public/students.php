<?php
require __DIR__ . '/../app/bootstrap.php';
$pdo = db();

$sections = [];
if (isset($_GET['course_no'])) {
  $stmt = $pdo->prepare("SELECT s.course_no, s.section_no, s.classroom, s.meeting_days, s.start_time, s.end_time, COUNT(e.id) AS enrolled FROM sections s LEFT JOIN enrollments e ON e.course_no = s.course_no AND e.section_no = s.section_no WHERE s.course_no = ? GROUP BY s.course_no, s.section_no, s.classroom, s.meeting_days, s.start_time, s.end_time ORDER BY s.section_no");
  $stmt->execute([$_GET['course_no']]);
  $sections = $stmt->fetchAll();
}

$history = [];
if (isset($_GET['cw_id'])) {
  $stmt = $pdo->prepare("SELECT c.course_no, c.title, s.section_no, e.grade FROM enrollments e JOIN sections s ON s.course_no = e.course_no AND s.section_no = e.section_no JOIN courses c ON c.course_no = e.course_no WHERE e.cw_id = ? ORDER BY c.course_no, s.section_no");
  $stmt->execute([$_GET['cw_id']]);
  $history = $stmt->fetchAll();
}

ob_start(); ?>
<section>
  <h2>(a) Sections for a Course</h2>
  <form method="get">
    <label>Course No: <input name="course_no" placeholder="CPSC332" value="<?= htmlspecialchars($_GET['course_no'] ?? '') ?>"></label>
    <button type="submit">Search</button>
  </form>
  <?php if ($sections): ?>
    <table>
      <tr><th>Course</th><th>Section</th><th>Classroom</th><th>Days</th><th>Start</th><th>End</th><th># Enrolled</th></tr>
      <?php foreach ($sections as $r): ?>
        <tr>
          <td><?= htmlspecialchars($r['course_no']) ?></td>
          <td><?= htmlspecialchars($r['section_no']) ?></td>
          <td><?= htmlspecialchars($r['classroom']) ?></td>
          <td><?= htmlspecialchars($r['meeting_days']) ?></td>
          <td><?= htmlspecialchars(substr($r['start_time'],0,5)) ?></td>
          <td><?= htmlspecialchars(substr($r['end_time'],0,5)) ?></td>
          <td><?= (int)$r['enrolled'] ?></td>
        </tr>
      <?php endforeach; ?>
    </table>
  <?php elseif (isset($_GET['course_no'])): ?>
    <p>No sections found.</p>
  <?php endif; ?>
</section>

<hr>

<section>
  <h2>(b) Course History for a Student</h2>
  <form method="get">
    <label>CWID: <input name="cw_id" placeholder="000000001" value="<?= htmlspecialchars($_GET['cw_id'] ?? '') ?>"></label>
    <button type="submit">Lookup</button>
  </form>
  <?php if ($history): ?>
    <table>
      <tr><th>Course</th><th>Title</th><th>Section</th><th>Grade</th></tr>
      <?php foreach ($history as $r): ?>
        <tr>
          <td><?= htmlspecialchars($r['course_no']) ?></td>
          <td><?= htmlspecialchars($r['title']) ?></td>
          <td><?= htmlspecialchars($r['section_no']) ?></td>
          <td><?= htmlspecialchars($r['grade'] ?? '(NULL)') ?></td>
        </tr>
      <?php endforeach; ?>
    </table>
  <?php elseif (isset($_GET['cw_id'])): ?>
    <p>No records found.</p>
  <?php endif; ?>
</section>
<?php
require __DIR__ . '/../app/views/layout.php';
render('Students', ob_get_clean());
