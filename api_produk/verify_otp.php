<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$Koneksi = new mysqli('localhost', 'root', '15Januari2004', 'data_produk');

$phone = $_POST['phone'];
$otp = $_POST['otp'];

// Periksa OTP
$data = mysqli_query($Koneksi, "SELECT * FROM otp_codes WHERE phone = '$phone' AND otp = '$otp'");

if (mysqli_num_rows($data) > 0) {
    // OTP valid, lanjutkan membuat akun
    mysqli_query($Koneksi, "DELETE FROM otp_codes WHERE phone = '$phone'"); // Hapus OTP setelah verifikasi

    echo json_encode(['pesan' => 'OTP valid, akun berhasil dibuat']);
} else {
    echo json_encode(['pesan' => 'OTP salah atau sudah kadaluarsa']);
}
?>
