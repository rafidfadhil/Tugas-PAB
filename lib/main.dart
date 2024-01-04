import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_pengembangan_aplikasi/providers/auth_provider.dart';
import './screens/Homepage.dart';
import './screens/detail_asset.dart';
import './screens/laporan_kerusakan.dart';
import './screens/scan_qr.dart';
import './screens/login_page.dart';
import './screens/register_page.dart';
import './screens/add_asset_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Asset Management App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(), // Memulai aplikasi dari LoginPage
        routes: {
          '/login': (context) => LoginPage(),
          '/homepage': (context) => HomePage(),
          '/register': (context) => RegisterPage(),
          '/add_asset': (context) => AddAssetPage(),
          '/detail_asset': (context) => DetailAssetPage(data: {}),
          '/laporan_kerusakan': (context) => LaporanKerusakanPage(),
          '/scan_qr': (context) => ScanQRPage(),
          // Tambahkan rute lain sesuai kebutuhan aplikasi Anda
        },
      ),
    );
  }
}
