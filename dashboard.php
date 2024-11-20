<?php
session_start();
require 'includes/auth.php';

if ($_SESSION['role'] === 'admin') {
    header("Location: crud/admin/manage_users.php");
} elseif ($_SESSION['role'] === 'teacher') {
    header("Location: crud/teacher/manage_grades.php");
} elseif ($_SESSION['role'] === 'student') {
    header("Location: crud/student/view_grades.php");
} else {
    echo "Acesso negado!";
}