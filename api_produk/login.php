<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$Koneksi = new mysqli('localhost', 'root', '15Januari2004', 'data_produk');

$username = $_POST['username'];
$password = $_POST['password'];

$query = mysqli_query($Koneksi, "SELECT * FROM users WHERE username = '$username'");
$user = mysqli_fetch_assoc($query);

if ($user && password_verify($password, $user['password'])) {
    echo json_encode([
        'pesan' => 'Login berhasil',
        'user' => $user
    ]);
} else {
    echo json_encode([
        'pesan' => 'Username atau password salah'
    ]);
}

?>
