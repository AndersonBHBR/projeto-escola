<?php

class DashboardController
{
    public function index()
    {
        session_start();

        if (!isset($_SESSION['role'])) {
            header("Location: /");
            exit;
        }

        switch ($_SESSION['role']) {
            case 'admin':
                require __DIR__ . '/../views/dashboard/admin.php';
                break;
            case 'teacher':
                require __DIR__ . '/../views/dashboard/teacher.php';
                break;
            case 'student':
                require __DIR__ . '/../views/dashboard/student.php';
                break;
            default:
                echo "Acesso negado!";
        }
    }
}