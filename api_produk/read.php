<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$Koneksi = new mysqli('localhost','root','15Januari2004','data_produk');
$query = mysqli_query($Koneksi, "select * from tb_produk");
$data = mysqli_fetch_all($query, MYSQLI_ASSOC);
echo json_encode($data);