<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$Koneksi = new mysqli('localhost','root','15Januari2004','data_produk');
$id_produk = $_POST['id_produk'];

$data = mysqli_query($Koneksi, "delete from tb_produk  where id_produk= '$id_produk'");
if ($data){
    echo json_encode([
        'pesan' => 'sukses delete'
    ]);
}else{
    echo json_encode([
        'pesan' => 'gagal delete'
    ]);
}