import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:biodata/models/msiswa.dart';
import 'package:biodata/models/api.dart';
import 'package:biodata/widgets/form.dart'; // Pastikan widget AppForm sudah benar

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  // GlobalKey untuk validasi form
  final formkey = GlobalKey<FormState>();

  // Controller untuk menangkap input teks
  final nisController = TextEditingController();
  final namaController = TextEditingController();
  final tpController = TextEditingController();
  final tgController = TextEditingController();
  final kelaminController = TextEditingController();
  final agamaController = TextEditingController();
  final alamatController = TextEditingController();

  // Fungsi untuk mengirim data ke API via POST
  Future<http.Response> createSw() async {
    return await http.post(
      Uri.parse(BaseUrl.tambah),
      body: {
        "nis": nisController.text,
        "nama": namaController.text,
        "tplahir": tpController.text,
        "tglahir": tgController.text,
        "kelamin": kelaminController.text,
        "agama": agamaController.text,
        "alamat": alamatController.text,
      },
    );
  }

  // Fungsi yang dipanggil saat tombol Simpan ditekan
  void _onConfirm(BuildContext context) async {
    try {
      final response = await createSw();
      final data = json.decode(response.body);

      // Cek apakah API mengembalikan status sukses
      if (data['success'] == true) {
        if (!mounted) return;
        
        // Tampilkan feedback sukses
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data berhasil disimpan!")),
        );

        // Kembali ke halaman utama dan hapus tumpukan navigasi
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal menyimpan data.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.green,
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          onPressed: () {
            // Validasi form sebelum konfirmasi
            if (formkey.currentState!.validate()) {
              print("OK SUKSES");
              _onConfirm(context);
            }
          },
          child: const Text("Simpan"),
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView( // Tambahkan agar tidak error pixel overflow
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: AppForm( // Pastikan parameter di widget form.dart sesuai
                formkey: formkey,
                nisController: nisController,
                namaController: namaController,
                tpController: tpController,
                tgController: tgController,
                kelaminController: kelaminController,
                agamaController: agamaController,
                alamatController: alamatController,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Bersihkan controller saat widget dihapus untuk menghemat memori
  @override
  void dispose() {
    nisController.dispose();
    namaController.dispose();
    tpController.dispose();
    tgController.dispose();
    kelaminController.dispose();
    agamaController.dispose();
    alamatController.dispose();
    super.dispose();
  }
}