import 'package:flutter/material.dart';
import './screens/Homepage.dart';
import './screens/detail_asset.dart';
import './screens/laporan_kerusakan.dart';
import './screens/scan_qr.dart';
import './screens/login_page.dart';
import './screens/register_page.dart';
import './screens/add_asset_page.dart'; // Pastikan Anda telah membuat file ini

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asset Management App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Define the routes
      routes: {
        '/': (context) => HomePage(),
        '/detailasset': (context) => DetailAssetPage(data: {}),
        '/laporankerusakan': (context) => LaporanKerusakanPage(),
        '/scanqr': (context) => ScanQRPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/addasset': (context) =>
            AddAssetPage(), // Rute untuk halaman penambahan aset
      },
      initialRoute: '/login', // Atur rute awal ke halaman login
    );
  }
}
