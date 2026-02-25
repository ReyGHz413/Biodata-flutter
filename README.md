# 🎓 Aplikasi Biodata Siswa (Flutter + PHP/MySQL)

[![Flutter](https://img.shields.io/badge/Framework-Flutter-blue.svg)](https://flutter.dev/)
[![PHP](https://img.shields.io/badge/Backend-PHP-777bb4.svg)](https://www.php.net/)
[![MySQL](https://img.shields.io/badge/Database-MySQL-4479a1.svg)](https://www.mysql.com/)

Aplikasi manajemen data siswa yang dibangun menggunakan **Flutter** sebagai antarmuka mobile dan **PHP** sebagai REST API untuk mengelola database **MySQL**. Proyek ini dirancang untuk mempermudah pendataan identitas siswa secara digital.

---

## 🌟 Fitur Utama

* **Manajemen Biodata Lengkap**: Mendukung pengelolaan data NIS, Nama, Tempat/Tanggal Lahir, Jenis Kelamin, Agama, hingga Alamat.
* **Integrasi Database Real-time**: Operasi CRUD (Create, Read, Update, Delete) langsung terhubung ke server MySQL melalui API PHP.
* **Interface Modern**: Tampilan daftar siswa yang bersih menggunakan widget `Card` dan `ListView` di Flutter.
* **Detail Siswa**: Informasi mendalam untuk setiap siswa dengan tata letak yang rapi.
* **Navigasi Mudah**: Perpindahan antar halaman (Daftar, Tambah, Edit) yang mulus.

---

## 🛠️ Teknologi & Arsitektur

### Mobile Frontend
* **Dart & Flutter**: Framework utama untuk aplikasi Android/iOS.
* **Http Package**: Untuk melakukan request API (GET, POST).
* **FutureBuilder**: Mengambil data dari server secara asynchronous.

### Backend & Database
* **PHP**: Sebagai jembatan (API) antara aplikasi mobile dan database.
* **MySQL**: Penyimpanan data relasional menggunakan tabel `siswa`.
* **JSON**: Format pertukaran data antara frontend dan backend.

---

## 📊 Struktur Database

Aplikasi ini menggunakan database `biodata` dengan tabel `siswa` yang memiliki skema sebagai berikut:

| Kolom | Tipe Data | Deskripsi |
| :--- | :--- | :--- |
| `id` | INT (AI) | Primary Key |
| `nis` | VARCHAR(16) | Nomor Induk Siswa |
| `nama` | VARCHAR(50) | Nama Lengkap Siswa |
| `tplahir` | VARCHAR(50) | Tempat Lahir |
| `tglahir` | DATE | Tanggal Lahir |
| `kelamin` | VARCHAR(15) | Jenis Kelamin (L/P) |
| `agama` | VARCHAR(15) | Agama Siswa |
| `alamat` | VARCHAR(200) | Alamat Lengkap Siswa |

---

## ⚙️ Cara Instalasi

1. **Persiapan Database**:
   * Buat database baru bernama `biodata` di phpMyAdmin.
   * Import file `biodata.sql` yang tersedia di repositori ini.

2. **Konfigurasi Backend**:
   * Simpan file PHP Anda di folder server (htdocs).
   * Pastikan koneksi database pada `konekdb.php` sudah benar.

3. **Konfigurasi Flutter**:
   * Update file `lib/models/api.dart` dengan URL server Anda (contoh: `http://192.168.1.x/biodata/`).
   * Jalankan `flutter pub get`.

4. **Menjalankan Aplikasi**:
   ```bash
   flutter run
