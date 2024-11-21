<?php

require_once __DIR__ . '/../app/controllers/AuthController.php';
require_once __DIR__ . '/../app/controllers/DashboardController.php';

define('BASE_URL', '/projeto-escola/');

// Depuração: Mostre a URI capturada
$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
echo "URI capturada: $uri<br>";

$uri = str_replace('/projeto-escola', '', $uri);  // Ajusta a URI, removendo o prefixo do projeto

switch ($uri) {
    case '/Projeto_Escola/public/':
    case '/Projeto_Escola/public/index.php':
    case '/':
        $controller = new AuthController();
        $controller->login();
        break;

    case '/Projeto_Escola/public/login':
        $controller = new AuthController();
        $controller->login();
        break;

    case '/Projeto_Escola/public/logout':
        $controller = new AuthController();
        $controller->logout();
        break;

    case '/Projeto_Escola/public/dashboard':
        $controller = new DashboardController();
        $controller->index();
        break;

    default:
        http_response_code(404);
        echo "Página não encontrada!";
        break;
}