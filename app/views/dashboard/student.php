<?php
session_start();
require '../../includes/auth.php'; // Verifica se o usuário está autenticado
require '../../includes/db.php'; // Conexão com o banco de dados

// Verifica se o usuário é um estudante
if ($_SESSION['role'] !== 'student') {
    die("Acesso negado!");
}

// Verifica se o token CSRF é válido
if ($_POST['csrf_token'] !== $_SESSION['csrf_token']) {
    die('Token CSRF inválido!');
}

// Obtém as notas do aluno logado
$stmt = $pdo->prepare("
    SELECT grades.grade, grades.bimester, subjects.name AS subject_name
    FROM grades
    JOIN subjects ON grades.subject_id = subjects.id
    WHERE grades.student_id = ?
");
$stmt->execute([$_SESSION['user_id']]);
$grades = $stmt->fetchAll();
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Minhas Notas</title>
</head>
<body>
    <h1>Minhas Notas</h1>
    
    <!-- Exibe o token CSRF no formulário -->
    <input type="hidden" name="csrf_token" value="<?= $_SESSION['csrf_token'] ?>">

    <table border="1">
        <tr>
            <th>Disciplina</th>
            <th>Nota</th>
            <th>Bimestre</th>
        </tr>
        <?php foreach ($grades as $grade): ?>
            <tr>
                <!-- Sanitiza e exibe as notas -->
                <td><?= htmlspecialchars($grade['subject_name'], ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= htmlspecialchars($grade['grade'], ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= htmlspecialchars($grade['bimester'], ENT_QUOTES, 'UTF-8') ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>