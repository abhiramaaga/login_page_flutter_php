<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$Koneksi = new mysqli('localhost','root','15Januari2004','data_produk');
$nama_produk = $_POST['nama_produk'];
$harga_produk = $_POST['harga_produk'];
$data = mysqli_query($Koneksi, "insert into tb_produk set nama_produk = '$nama_produk',harga_produk = '$harga_produk'");
if ($data){
    echo json_encode([
        'pesan' => 'sukses'
    ]);
}