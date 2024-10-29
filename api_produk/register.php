<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$Koneksi = new mysqli('localhost', 'root', '15Januari2004', 'data_produk');

$username = $_POST['username'];
$password = $_POST['password'];

// Enkripsi password menggunakan hash
$password_hashed = password_hash($password, PASSWORD_BCRYPT);

$data = mysqli_query($Koneksi, "INSERT INTO users (username, password) VALUES ('$username', '$password_hashed')");

if ($data) {
    echo json_encode([
        'pesan' => 'Registrasi berhasil'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Registrasi gagal'
    ]);
}

?>
