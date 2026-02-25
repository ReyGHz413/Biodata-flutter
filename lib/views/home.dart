import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:biodata/models/msiswa.dart';
import 'package:biodata/models/api.dart';
import 'package:biodata/views/details.dart';
import 'package:biodata/views/create.dart';

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<SiswaModel>> sw;

  @override
  void initState() {
    super.initState();
    sw = getSwList();
  }

  Future<List<SiswaModel>> getSwList() async {
    final response = await http.get(Uri.parse(BaseUrl.data));
    if (response.statusCode == 200) {
      final List items = json.decode(response.body);
      return items.map((json) => SiswaModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data Siswa'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<List<SiswaModel>>(
          future: sw,
          builder: (BuildContext context, AsyncSnapshot<List<SiswaModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("Data Kosong");
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    trailing: const Icon(Icons.view_list),
                    title: Text(
                      "${data.nis} ${data.nama}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text("${data.tplahir}, ${data.tglahir}"),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Details(sw: data)
                      ));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.green,
        backgroundColor: Colors.deepOrange,
        onPressed: () {
           Navigator.push(context, MaterialPageRoute(
             builder: (context) => const Create())
           );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}