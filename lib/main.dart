import 'package:android_abhi/halaman_produk.dart';
import 'package:android_abhi/login_page.dart';
import 'package:flutter/material.dart';
import 'main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Produk',
      home: MainPage(),
      routes: {
        '/halamanProduk': (context) => HalamanProduk(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
