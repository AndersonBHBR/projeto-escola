<?php
session_start();
require '../../includes/auth.php'; // Verifica se o usuário está autenticado e tem permissões
require '../../includes/db.php'; // Conexão com o banco de dados

// Verifica se a requisição é POST (quando o formulário é enviado)
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Sanitiza e valida os dados de entrada
    $name = htmlspecialchars($_POST['name'], ENT_QUOTES, 'UTF-8');
    $email = filter_var($_POST['email'], FILTER_SANITIZE_EMAIL);
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT); // Criptografa a senha

    // Verifica se o usuário tem permissão de admin
    if ($_SESSION['role'] !== 'admin') {
        die("Acesso negado!");
    }

    // Insere um novo usuário no banco de dados
    $stmt = $pdo->prepare("INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)");
    $stmt->execute([$name, $email, $password, 'user']); // Definindo 'user' como o papel padrão

    // Redireciona após inserir o usuário
    header("Location: manage_users.php");
    exit;
}

// Consulta todos os usuários do banco de dados
$users = $pdo->query("SELECT * FROM users")->fetchAll();
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Gerenciar Usuários</title>
</head>
<body>
    <h1>Usuários</h1>
    
    <!-- Formulário para adicionar um novo usuário -->
    <h2>Cadastrar Novo Usuário</h2>
    <form method="POST" action="">
        <label for="name">Nome:</label>
        <input type="text" name="name" id="name" required><br>

        <label for="email">Email:</label>
        <input type="email" name="email" id="email" required><br>

        <label for="password">Senha:</label>
        <input type="password" name="password" id="password" required><br>

        <button type="submit">Cadastrar</button>
    </form>

    <hr>

    <!-- Tabela de usuários cadastrados -->
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Email</th>
            <th>Função</th>
            <th>Ações</th>
        </tr>
        <?php foreach ($users as $user): ?>
            <tr>
                <td><?= htmlspecialchars($user['id'], ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= htmlspecialchars($user['name'], ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= htmlspecialchars($user['email'], ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= htmlspecialchars($user['role'], ENT_QUOTES, 'UTF-8') ?></td>
                <td>
                    <a href="edit_user.php?id=<?= $user['id'] ?>">Editar</a> |
                    <a href="delete_user.php?id=<?= $user['id'] ?>">Excluir</a>
                </td>
            </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>