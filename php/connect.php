<?php

    $connect = mysqli_connect('localhost', 'root','','electrofix_final');

    if (!$connect) {
        die('Error Connect to DB');
    }
?>