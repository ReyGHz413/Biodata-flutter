import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:biodata/models/msiswa.dart';
import 'package:biodata/models/api.dart';
import 'package:biodata/widgets/form.dart';

class Edit extends StatefulWidget {
  final SiswaModel sw;
  const Edit({super.key, required this.sw});

  @override
  State<Edit> createState() => EditState();
}

class EditState extends State<Edit> {
  final formkey = GlobalKey<FormState>();
  
  // Mendefinisikan controller
  late TextEditingController nisController;
  late TextEditingController namaController;
  late TextEditingController tpController;
  late TextEditingController tgController;
  late TextEditingController kelaminController;
  late TextEditingController agamaController;
  late TextEditingController alamatController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data awal dari widget.sw
    nisController = TextEditingController(text: widget.sw.nis);
    namaController = TextEditingController(text: widget.sw.nama);
    tpController = TextEditingController(text: widget.sw.tplahir);
    tgController = TextEditingController(text: widget.sw.tglahir);
    kelaminController = TextEditingController(text: widget.sw.kelamin);
    agamaController = TextEditingController(text: widget.sw.agama);
    alamatController = TextEditingController(text: widget.sw.alamat);
  }

  Future editSw() async {
    return await http.post(
      Uri.parse(BaseUrl.edit),
      body: {
        "id": widget.sw.id.toString(),
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

  void pesan() {
    Fluttertoast.showToast(
      msg: "Perubahan Data Berhasil disimpan",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _onConfirm(context) async {
    http.Response response = await editSw();
    final data = json.decode(response.body);
    if (data['success']) {
      pesan();
      // Kembali ke halaman utama (Home)
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: const Text("Update"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.green,
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          onPressed: () {
            if (formkey.currentState!.validate()) {
              _onConfirm(context);
            }
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: AppForm(
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
    );
  }

  @override
  void dispose() {
    // Selalu dispose controller untuk mencegah memory leak
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