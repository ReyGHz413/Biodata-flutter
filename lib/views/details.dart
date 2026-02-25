import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:biodata/models/api.dart';
import 'package:biodata/models/msiswa.dart';
import 'package:biodata/views/edit.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class Details extends StatefulWidget {
  final SiswaModel sw;
  const Details({super.key, required this.sw});

  @override
  State<Details> createState() => DetailsState();
}

class DetailsState extends State<Details> {
  
  // Fungsi untuk menghapus data siswa
  void deleteSiswa(context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(BaseUrl.hapus),
        body: {
          'id': widget.sw.id.toString(),
        },
      );

      final data = json.decode(response.body);
      if (data['success'] == true) {
        pesan(); // Tampilkan toast
        // Kembali ke halaman utama dan refresh list
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        Fluttertoast.showToast(msg: "Gagal menghapus data");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Terjadi kesalahan: $e");
    }
  }

  // Menampilkan pesan toast sukses
  void pesan() {
    Fluttertoast.showToast(
      msg: "Penghapusan Data Berhasil disimpan",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Dialog konfirmasi sebelum hapus
  void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Apakah anda yakin akan menghapus data ini?'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(Icons.cancel, color: Colors.grey),
            ),
            ElevatedButton(
              onPressed: () => deleteSiswa(context),
              child: const Icon(Icons.check_circle, color: Colors.red),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID : ${widget.sw.id}", style: const TextStyle(fontSize: 20)),
            Text("NIS : ${widget.sw.nis}", style: const TextStyle(fontSize: 20)),
            const Padding(padding: EdgeInsets.all(10)),
            Text("NAMA : ${widget.sw.nama}", style: const TextStyle(fontSize: 20)),
            Text("Tempat Lahir : ${widget.sw.tplahir}", style: const TextStyle(fontSize: 20)),
            Text("Tanggal Lahir : ${widget.sw.tglahir}", style: const TextStyle(fontSize: 20)),
            Text("Kelamin : ${widget.sw.kelamin}", style: const TextStyle(fontSize: 20)),
            Text("Agama : ${widget.sw.agama}", style: const TextStyle(fontSize: 20)),
            Text("Alamat : ${widget.sw.alamat}", style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Edit(sw: widget.sw),
          ),
        ),
      ),
    );
  }
}