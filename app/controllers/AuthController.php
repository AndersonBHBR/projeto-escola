<?php

require_once __DIR__ . '/../models/User.php';

class AuthController
{
    public function login()
    {
        session_start();

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $email = $_POST['email'];
            $password = $_POST['password'];

            $userModel = new User();
            $user = $userModel->findByEmail($email);

            if ($user && password_verify($password, $user['password'])) {
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['role'] = $user['role'];
                $_SESSION['name'] = $user['name'];
                header("Location: /dashboard");
                exit;
            } else {
                $error = "Credenciais inválidas!";
            }
        }

        require __DIR__ . '/../views/auth/login.php';
    }

    public function logout()
    {
        session_start();
        session_destroy();
        header("Location: /");
        exit;
    }
}