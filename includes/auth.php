<?php
// Verifica se a sessão foi iniciada
if (session_status() === PHP_SESSION_NONE) {
    session_start(); // Inicia a sessão caso não tenha sido iniciada
}

// Verifica se o usuário não está autenticado
if (!isset($_SESSION['user_id']) || !isset($_SESSION['role'])) {
    // Redireciona para a página de login
    header("Location: index.php");
    exit;
}