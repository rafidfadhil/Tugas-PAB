import 'package:flutter/material.dart';
import './screens/Homepage.dart';
import './screens/detail_asset.dart';
import './screens/laporan_kerusakan.dart';
import './screens/scan_qr.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asset Management App',
      initialRoute: '/',
      debugShowCheckedModeBanner: false, // Menetapkan ini ke false untuk menghilangkan banner debug
      routes: {
        '/': (context) => HomePage(),
        '/detailasset': (context) => DetailAssetPage(data: {}),
        '/laporankerusakan': (context) => LaporanKerusakanPage(),
        '/scanqr': (context) => ScanQRPage(),
      },
    );
  }
}
