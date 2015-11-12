<?php

$email = $_POST["email"];

$date = date("Y-m-d\TH:i:sO");

$data = $date . "," . $email . "\n";

$file = 'emails.csv';

// Write the contents to the file
file_put_contents($file, $data, FILE_APPEND | LOCK_EX);
?>