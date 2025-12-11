<?php
require __DIR__ . '/../app/bootstrap.php';

$pdo = db();

$profResults = [];
if (isset($_GET['prof_ssn'])) {
  $stmt = $pdo->prepare("
    SELECT c.title, s.classroom, s.meeting_days, s.start_time, s.end_time
    FROM sections s
    JOIN courses c ON c.course_no = s.course_no
    WHERE s.professor_ssn = ?
    ORDER BY c.title, s.start_time
  ");
  $stmt->execute([$_GET['prof_ssn']]);
  $profResults = $stmt->fetchAll();
}

$gradeResults = [];
if (isset($_GET['course_no'], $_GET['section_no'])) {
  $stmt = $pdo->prepare("
    SELECT grade, COUNT(*) AS cnt
    FROM enrollments
    WHERE course_no = ? AND section_no = ?
    GROUP BY grade
    ORDER BY FIELD(grade,'A','A-','B+','B','B-','C+','C','C-','D+','D','D-','F','W','I')
  ");
  $stmt->execute([$_GET['course_no'], $_GET['section_no']]);
  $gradeResults = $stmt->fetchAll();
}

ob_start(); ?>
<section>
  <h2>(a) Classes for a Professor</h2>
  <form method="get">
    <label>Professor SSN:
      <input name="prof_ssn" placeholder="111223333" value="<?= htmlspecialchars($_GET['prof_ssn'] ?? '') ?>">
    </label>
    <button type="submit">Lookup</button>
  </form>
  <?php if ($profResults): ?>
    <table>
      <tr><th>Title</th><th>Classroom</th><th>Days</th><th>Start</th><th>End</th></tr>
      <?php foreach ($profResults as $r): ?>
        <tr>
          <td><?= htmlspecialchars($r['title']) ?></td>
          <td><?= htmlspecialchars($r['classroom']) ?></td>
          <td><?= htmlspecialchars($r['meeting_days']) ?></td>
          <td><?= htmlspecialchars(substr($r['start_time'],0,5)) ?></td>
          <td><?= htmlspecialchars(substr($r['end_time'],0,5)) ?></td>
        </tr>
      <?php endforeach; ?>
    </table>
  <?php elseif (isset($_GET['prof_ssn'])): ?>
    <p>No sections found.</p>
  <?php endif; ?>
</section>

<hr>

<section>
  <h2>(b) Grade Distribution for a Section</h2>
  <form method="get">
    <label>Course No: <input name="course_no" placeholder="CPSC332"
      value="<?= htmlspecialchars($_GET['course_no'] ?? '') ?>"></label>
    <label>Section No: <input name="section_no" placeholder="01"
      value="<?= htmlspecialchars($_GET['section_no'] ?? '') ?>"></label>
    <button type="submit">Count</button>
  </form>
  <?php if ($gradeResults): ?>
    <table>
      <tr><th>Grade</th><th>Count</th></tr>
      <?php foreach ($gradeResults as $r): ?>
        <tr><td><?= htmlspecialchars($r['grade'] ?? '(NULL)') ?></td><td><?= (int)$r['cnt'] ?></td></tr>
      <?php endforeach; ?>
    </table>
  <?php elseif (isset($_GET['course_no'], $_GET['section_no'])): ?>
    <p>No enrollments found.</p>
  <?php endif; ?>
</section>
<?php
require __DIR__ . '/../app/views/layout.php';
render('Professors', ob_get_clean());
