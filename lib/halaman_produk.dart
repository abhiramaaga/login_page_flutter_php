import 'dart:convert';
import 'package:android_abhi/detail_produk.dart';
import 'package:android_abhi/edit_produk.dart';
import 'package:android_abhi/login_page.dart';
import 'package:android_abhi/tambah_produk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HalamanProduk extends StatefulWidget {
  const HalamanProduk({super.key});

  @override
  State<HalamanProduk> createState() => _HalamanProdukState();
}

class _HalamanProdukState extends State<HalamanProduk> {
  List _listdata = [];
  bool _loading = true;

  Future _getdata() async {
    // Ambil data produk dari API
    try {
      final respon = await http.get(Uri.parse('http://192.168.100.177/api_produk/read.php'));
      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        setState(() {
          _listdata = data;
          _loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _hapus(String id) async {
    // Ambil data produk dari API
    try {
      final respon = await http.post(Uri.parse('http://192.168.100.177/api_produk/delete.php'),
      body: {
        "id_produk": id,
      });
      if (respon.statusCode == 200) {
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    _getdata();
    super.initState();
  }

  void _logout() {
    // Hapus informasi pengguna (jika ada, misalnya token)
    // Anda mungkin perlu menambahkan logika untuk menghapus token atau data pengguna

    // Navigasi kembali ke halaman login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Ganti dengan halaman login Anda
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Produk'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout, // Panggil fungsi logout ketika tombol ditekan
          ),
        ],
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProduk(
                        ListData: {
                          'id_produk' : _listdata[index]['id_produk'],
                          'nama_produk' : _listdata[index]['nama_produk'],
                          'harga_produk' : _listdata[index]['harga_produk'],
                        },
                      )));
                    },
                    child: ListTile(
                      title: Text(_listdata[index]['nama_produk']),
                      subtitle: Text(_listdata[index]['harga_produk']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UbahProduk(
                              ListData: {
                                'id_produk' : _listdata[index]['id_produk'],
                              'nama_produk' : _listdata[index]['nama_produk'],
                              'harga_produk' : _listdata[index]['harga_produk'],
                              },
                            )));
                          }, 
                            icon: (Icon(Icons.edit))),
                            IconButton(onPressed: (){
                              showDialog(
                                barrierDismissible: false,
                                context: context, 
                              builder: ((context){
                                return AlertDialog(
                                  content: Text('hapus data ini?'),
                                  actions: [
                                    ElevatedButton(onPressed: (){
                                      _hapus(_listdata[index]['id_produk']).then((value){
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                          builder: ((context)=> HalamanProduk())),
                                           (route)=> false);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue), 
                                    child: Text('hapus')),
                                    ElevatedButton(onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue), 
                                    child: Text('batal')),
                                  ],
                                );
                              }));
                            },
                             icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Text(
          '+',
          style: TextStyle(fontSize: 24),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TambahProduk()));
        },
      ),
    );
  }
}
