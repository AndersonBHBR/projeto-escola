<?php
// db.php: Conexão com o banco de dados

// Dados de configuração do banco de dados
$host = 'localhost';      // Endereço do servidor de banco de dados
$dbname = 'escola';       // Nome do banco de dados
$username = 'root';       // Nome de usuário do banco de dados
$password = '';           // Senha do banco de dados (vazio para localhost)

try {
    // Conexão com o banco de dados usando PDO
    $dsn = "mysql:host=$host;dbname=$dbname;charset=utf8"; // Definindo a codificação de caracteres como utf8
    $pdo = new PDO($dsn, $username, $password);

    // Definindo os atributos do PDO para tratamento de erros e modo de fetch
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); // Lança exceções em caso de erro
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC); // Modo de fetch associativo

    // Se a conexão for bem-sucedida, não faz nada
} catch (PDOException $e) {
    // Se ocorrer um erro na conexão, exibe a mensagem de erro
    die("Erro ao conectar ao banco de dados: " . $e->getMessage());
}