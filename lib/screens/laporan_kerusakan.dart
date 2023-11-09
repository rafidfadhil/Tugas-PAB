import 'package:flutter/material.dart';

class LaporanKerusakanPage extends StatefulWidget {
  @override
  _LaporanKerusakanPageState createState() => _LaporanKerusakanPageState();
}

class _LaporanKerusakanPageState extends State<LaporanKerusakanPage> {
  String selectedKerusakanType = 'RUSAK SEBAGIAN';
  String uraianKerusakan = '';
  bool pernahRusakSebelumnya = false;
  int estimasiPerbaikan = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      appBar: AppBar(
        backgroundColor: Color(0xFF222736),
        elevation: 0,
        title: _buildAppBarTitle(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 16.0),
            _buildLaporanContent(),
          ],
        ),
      ),
    );
  }

  // Membuat widget untuk judul AppBar
  Widget _buildAppBarTitle() {
    return Row(
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          child: Image.asset(
            './assets/logo.png',
            width: 48,
            height: 48,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Deal Management',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Asset Management',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLaporanContent() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Nama Aset: Nama Aset Anda',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Deskripsi Aset: Deskripsi Aset Anda',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 24.0),
          Text(
            'Jenis Kerusakan:',
            style: TextStyle(fontSize: 16.0),
          ),
          _buildDropdownKerusakanType(),
          SizedBox(height: 24.0),
          Text(
            'Uraian Kerusakan:',
            style: TextStyle(fontSize: 16.0),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Deskripsi Kerusakan',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                uraianKerusakan = value;
              });
            },
          ),
          SizedBox(height: 24.0),
          Text(
            'Pernah Rusak Sebelumnya:',
            style: TextStyle(fontSize: 16.0),
          ),
          _buildSwitchPernahRusakSebelumnya(), // Menggunakan Switch
          SizedBox(height: 24.0),
          _buildLaporkanButton(),
          SizedBox(height: 24.0),
          Text(
            'Hasil Laporan:',
            style: TextStyle(fontSize: 16.0),
          ),
          _buildHasilLaporan(),
        ],
      ),
    );
  }

  // Membuat dropdown untuk jenis kerusakan
  Widget _buildDropdownKerusakanType() {
    return DropdownButton<String>(
      value: selectedKerusakanType,
      onChanged: (String? newValue) {
        setState(() {
          selectedKerusakanType = newValue!;
        });
      },
      items: <String>[
        'RUSAK SEBAGIAN',
        'RUSAK SEDANG',
        'RUSAK PARAH',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  // Membuat Switch untuk pernah rusak sebelumnya
  Widget _buildSwitchPernahRusakSebelumnya() {
    return Row(
      children: <Widget>[
        Text('Pernah Rusak Sebelumnya: '),
        Switch(
          value: pernahRusakSebelumnya,
          onChanged: (bool newValue) {
            setState(() {
              pernahRusakSebelumnya = newValue;
            });
          },
        ),
      ],
    );
  }

  // Membuat tombol "Laporkan Kerusakan"
  Widget _buildLaporkanButton() {
    return ElevatedButton(
      onPressed: () {
        estimasiPerbaikan = hitungEstimasiPerbaikan();
        _showEstimasiDialog();
      },
      child: Text('Laporkan Kerusakan'),
    );
  }

  // Membuat hasil laporan (Type Kerusakan, Pernah Rusak Sebelumnya, dan Estimasi Perbaikan)
  Widget _buildHasilLaporan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Type Kerusakan: $selectedKerusakanType'),
        Text('Pernah Rusak Sebelumnya: ${pernahRusakSebelumnya ? 'Ya' : 'Tidak'}'),
        Text('Estimasi Perbaikan: ${estimasiPerbaikan > 0 ? '$estimasiPerbaikan hari' : 'Belum dihitung'}'),
      ],
    );
  }

  // Fungsi untuk menghitung estimasi perbaikan
  int hitungEstimasiPerbaikan() {
    int estimasi = 0;

    if (!pernahRusakSebelumnya) {
      switch (selectedKerusakanType) {
        case 'RUSAK SEBAGIAN':
          estimasi = 2;
          break;
        case 'RUSAK SEDANG':
          estimasi = 4;
          break;
        case 'RUSAK PARAH':
          estimasi = 7;
          break;
      }
    } else {
      switch (selectedKerusakanType) {
        case 'RUSAK SEBAGIAN':
          estimasi = 4;
          break;
        case 'RUSAK SEDANG':
          estimasi = 8;
          break;
        case 'RUSAK PARAH':
          estimasi = 14;
          break;
      }
    }

    return estimasi;
  }

  // Menampilkan dialog estimasi perbaikan
  void _showEstimasiDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Estimasi Perbaikan'),
          content: Text(
              'Estimasi Perbaikan: ${estimasiPerbaikan > 0 ? '$estimasiPerbaikan hari' : 'Belum dihitung'}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
