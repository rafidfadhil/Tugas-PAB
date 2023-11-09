import 'package:flutter/material.dart';

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Asset',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomePage(); // Ganti dengan halaman Home Anda
      case 1:
        return SearchPage(); // Ganti dengan halaman Search Anda
      case 2:
        return QrCodePage(); // Ganti dengan halaman QR Code Anda
      case 3:
        return AssetPage(); // Ganti dengan halaman Asset Anda
      case 4:
        return ProfilePage(); // Ganti dengan halaman Profile Anda
      default:
        return Container();
    }
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implementasikan halaman Home Anda di sini
    return Container();
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implementasikan halaman Search Anda di sini
    return Container();
  }
}

class QrCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implementasikan halaman QR Code Anda di sini
    return Container();
  }
}

class AssetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implementasikan halaman Asset Anda di sini
    return Container();
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implementasikan halaman Profile Anda di sini
    return Container();
  }
}
