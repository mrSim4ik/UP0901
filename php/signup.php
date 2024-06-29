<?php
session_start();
require_once 'connect.php';

if (isset($_REQUEST['doGo'])) {
    $surname = $_POST['surname'];
    $name = $_POST['name'];
    $password = $_POST['password'];
    $reppassword = $_POST['reppassword'];
    $email = $_POST['email'];

    // Проверка существования пользователя с таким же email
    $check_email = mysqli_query($connect, "SELECT * FROM users WHERE email='$email'");
    if (mysqli_num_rows($check_email) > 0) {
        // Пользователь с таким email уже существует
        header('Content-Type: application/json');
        echo json_encode(array('success' => false, 'error' => 'user_exists'));
        exit();
    }

    // Проверка соответствия паролей
    if ($password != $reppassword) {
        // Пароли не совпадают
        header('Content-Type: application/json');
        echo json_encode(array('success' => false, 'error' => 'password_mismatch'));
        exit();
    }

    // Проверка заполнения рекапчи
    if (empty($_POST['recaptcha'])) {
        // Рекапча не заполнена или не отправлена
        header('Content-Type: application/json');
        echo json_encode(array('success' => false, 'error' => 'empty_captcha'));
        exit();
    }

    // Проверка рекапчи
    $recaptcha = $_POST['recaptcha'];
    $secretKey = "6LeGfugmAAAAAPeye0LzB9CoAYA7b5usxQ5yb7q3";
    $response = file_get_contents('https://www.google.com/recaptcha/api/siteverify?secret=' . urlencode($secretKey) . '&response=' . urlencode($recaptcha));
    $responseData = json_decode($response);

    if (!$responseData || !$responseData->success) {
        // Ошибка рекапчи
        header('Content-Type: application/json');
        echo json_encode(array('success' => false, 'error' => 'captcha_failed'));
        exit();
    }

    // Хеширование пароля
    $password = md5($password);

    // Хешируем хеш, который состоит из email и времени
    $hash = md5($email . time());

    // Отправка письма с подтверждением
    $to = $email;
    $subject = "Подтвердите Email";
    $message = '
        <html>
        <head>
        <title>Подтвердите Email</title>
        </head>
        <body>
        <p>Привет ' . $name .'! Чтобы подтвердить Email, перейдите по <a href="http://localhost/electrofix_final/php/confirmed.php?hash=' . $hash . '">ссылке</a></p>
        </body>
        </html>
        ';

    $headers  = 'MIME-Version: 1.0' . "\r\n";
    $headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
    $headers .= 'To: ' . $to . "\r\n";
    $headers .= 'From: <dimasik31122003@gmail.com>' . "\r\n";

    mysqli_query($connect, "INSERT INTO users (surname, name, password, email, hash, isAdmin, email_confirmed) VALUES ('$surname', '$name', '$password', '$email', '$hash', '0', '0')");
    if (mail($to, $subject, $message, $headers)) {
        // Если письмо успешно отправлено
        header('Content-Type: application/json');
        echo json_encode(array('success' => true));
        exit();
    } else {
        // Если письмо не удалось отправить
        header('Content-Type: application/json');
        echo json_encode(array('success' => false, 'error' => 'mail_failed'));
        exit();
    }
}
?>
