<?php
header('Content-Type: application/json');
include 'konekdb.php';

$stmt = $db->query("SELECT id, nis, nama, tplahir, tglahir, kelamin, agama, alamat FROM siswa");
$stmt->execute();
$results = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($results);
?>