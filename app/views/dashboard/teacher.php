<?php
session_start();
require '../../includes/auth.php'; // Verifica se o usuário está autenticado e tem permissões
require '../../includes/db.php'; // Conexão com o banco de dados

// Verifica se o usuário é um professor
if ($_SESSION['role'] !== 'teacher') {
    die("Acesso negado!");
}

// Verifica se o token CSRF é válido
if ($_POST['csrf_token'] !== $_SESSION['csrf_token']) {
    die('Token CSRF inválido!');
}

// Obtém as turmas e notas
$stmt = $pdo->prepare("
    SELECT grades.id, students.name AS student_name, subjects.name AS subject_name, grades.grade, grades.bimester
    FROM grades
    JOIN students ON grades.student_id = students.id
    JOIN subjects ON grades.subject_id = subjects.id
    WHERE subjects.teacher_id = ?
");
$stmt->execute([$_SESSION['user_id']]);
$grades = $stmt->fetchAll();

// Processa a inserção ou edição
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Sanitiza os dados de entrada
    $student_id = filter_var($_POST['student_id'], FILTER_SANITIZE_NUMBER_INT);
    $subject_id = filter_var($_POST['subject_id'], FILTER_SANITIZE_NUMBER_INT);
    $grade = filter_var($_POST['grade'], FILTER_SANITIZE_NUMBER_FLOAT, FILTER_FLAG_ALLOW_FRACTION);
    $bimester = filter_var($_POST['bimester'], FILTER_SANITIZE_NUMBER_INT);

    // Verifica se os valores estão dentro de limites válidos
    if (!is_numeric($grade) || $grade < 0 || $grade > 10) {
        die("Nota inválida!");
    }

    if ($bimester < 1 || $bimester > 4) {
        die("Bimestre inválido! O valor deve estar entre 1 e 4.");
    }

    // Insere ou atualiza a nota
    $stmt = $pdo->prepare("
        INSERT INTO grades (student_id, subject_id, grade, bimester, created_at, updated_at)
        VALUES (?, ?, ?, ?, NOW(), NOW())
        ON DUPLICATE KEY UPDATE
        grade = VALUES(grade), updated_at = NOW()
    ");
    $stmt->execute([$student_id, $subject_id, $grade, $bimester]);

    // Redireciona após salvar
    header("Location: manage_grades.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Gerenciar Notas</title>
</head>
<body>
    <h1>Gerenciar Notas</h1>
    
    <!-- Exibe o token CSRF no formulário -->
    <form method="POST">
        <input type="hidden" name="csrf_token" value="<?= $_SESSION['csrf_token'] ?>">

        <!-- Seleção do aluno -->
        <label>Aluno:
            <select name="student_id" required>
                <?php
                $students = $pdo->query("SELECT id, name FROM students")->fetchAll();
                foreach ($students as $student) {
                    echo "<option value='{$student['id']}'>{$student['name']}</option>";
                }
                ?>
            </select>
        </label><br>

        <!-- Seleção da disciplina -->
        <label>Disciplina:
            <select name="subject_id" required>
                <?php
                $subjects = $pdo->prepare("SELECT id, name FROM subjects WHERE teacher_id = ?");
                $subjects->execute([$_SESSION['user_id']]);
                foreach ($subjects->fetchAll() as $subject) {
                    echo "<option value='{$subject['id']}'>{$subject['name']}</option>";
                }
                ?>
            </select>
        </label><br>

        <!-- Entrada da nota -->
        <label>Nota: <input type="number" step="0.1" name="grade" required min="0" max="10"></label><br>
        
        <!-- Entrada do bimestre -->
        <label>Bimestre: <input type="number" name="bimester" min="1" max="4" required></label><br>
        
        <button type="submit">Salvar</button>
    </form>

    <h2>Notas</h2>
    <table border="1">
        <tr>
            <th>Aluno</th>
            <th>Disciplina</th>
            <th>Nota</th>
            <th>Bimestre</th>
        </tr>
        <?php foreach ($grades as $grade): ?>
            <tr>
                <td><?= htmlspecialchars($grade['student_name'], ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= htmlspecialchars($grade['subject_name'], ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= htmlspecialchars($grade['grade'], ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= htmlspecialchars($grade['bimester'], ENT_QUOTES, 'UTF-8') ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>