<?php

$dsn = "mysql:host=localhost;dbname=phpfluttercoursedb";
$user = "root";
$pass = "";
$option = array(
        PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES UTF8" //for arabic lang
);

try {
    $connect = new PDO($dsn, $user, $pass, $option);

    $connect -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
    header("Access-Control-Allow-Methods: POST, OPTIONS , GET");


    include "functions.php";

    checkAuthenticate();
    
}catch(PDOException $e) {
    echo $e -> getMessage();
}
?>