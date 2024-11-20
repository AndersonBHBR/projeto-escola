<?php
session_start();
require 'includes/db.php';

ini_set('display_errors', 1);
error_reporting(E_ALL);

// Geração do CSRF token se não existir na sessão
if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}

// Processamento do formulário de login
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Verificação do token CSRF
    if (empty($_POST['csrf_token']) || $_POST['csrf_token'] !== $_SESSION['csrf_token']) {
        die("Token CSRF inválido!");
    }

    // Coleta e sanitiza os dados do formulário
    $email = filter_var($_POST['email'], FILTER_SANITIZE_EMAIL);
    $passwordInput = $_POST['password'];

    // Busca o usuário no banco de dados
    $stmt = $pdo->prepare("SELECT id, name, password, role FROM users WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch();

    // Validação das credenciais
    if ($user && password_verify($passwordInput, $user['password'])) {
        // Sessão de usuário autenticado
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['role'] = $user['role'];
        $_SESSION['name'] = $user['name'];

        // Redireciona para o painel do usuário
        header("Location: dashboard.php");
        exit;
    } else {
        $error = "Credenciais inválidas!";
    }
}

?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Escola</title>
</head>
<body>
    <h1>Login</h1>

    <!-- Exibe mensagem de erro -->
    <?php if (isset($error)) : ?>
        <p style="color: red;"><?= htmlspecialchars($error, ENT_QUOTES, 'UTF-8') ?></p>
    <?php endif; ?>

    <!-- Formulário de login -->
    <form method="POST" action="">
        <input type="hidden" name="csrf_token" value="<?= htmlspecialchars($_SESSION['csrf_token'], ENT_QUOTES, 'UTF-8') ?>">
        <label for="email">Email:</label>
        <input type="email" name="email" id="email" required><br>

        <label for="password">Senha:</label>
        <input type="password" name="password" id="password" required><br>

        <button type="submit">Entrar</button>
    </form>
</body>
</html>