import 'package:flutter/material.dart';

class LaporanKerusakanPage extends StatefulWidget {
  final String? namaAset; // Menambahkan parameter nama aset
  final String? deskripsiAset; // Menambahkan parameter deskripsi aset

  LaporanKerusakanPage({this.namaAset, this.deskripsiAset});

  @override
  _LaporanKerusakanPageState createState() => _LaporanKerusakanPageState();
}

class _LaporanKerusakanPageState extends State<LaporanKerusakanPage> {
  String? selectedKerusakanType;
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
        title: Text('Laporan Kerusakan'),
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
            'Nama Aset: ${widget.namaAset ?? 'Nama Aset Anda'}',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2F41),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Deskripsi Aset: ${widget.deskripsiAset ?? 'Deskripsi Aset Anda'}',
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xFF2D2F41),
            ),
          ),
          SizedBox(height: 24.0),
          Text(
            'Jenis Kerusakan:',
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xFF2D2F41),
            ),
          ),
          _buildDropdownKerusakanType(),
          SizedBox(height: 24.0),
          Text(
            'Uraian Kerusakan:',
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xFF2D2F41),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Deskripsi Kerusakan',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onChanged: (value) {
              setState(() {
                uraianKerusakan = value;
                estimasiPerbaikan = hitungEstimasiPerbaikan();
              });
            },
          ),
          SizedBox(height: 24.0),
          Text(
            'Pernah Rusak Sebelumnya:',
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xFF2D2F41),
            ),
          ),
          _buildSwitchPernahRusakSebelumnya(),
          SizedBox(height: 24.0),
          _buildHasilLaporan(),
          SizedBox(height: 24.0),
          _buildLaporkanButton(),
        ],
      ),
    );
  }

  Widget _buildDropdownKerusakanType() {
    return DropdownButtonFormField<String>(
      value: selectedKerusakanType,
      onChanged: (String? newValue) {
        setState(() {
          selectedKerusakanType = newValue;
          estimasiPerbaikan = hitungEstimasiPerbaikan();
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
      decoration: InputDecoration(
        labelText: 'Jenis Kerusakan',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  Widget _buildSwitchPernahRusakSebelumnya() {
    return Row(
      children: <Widget>[
        Text('Pernah Rusak Sebelumnya: '),
        Switch(
          value: pernahRusakSebelumnya,
          onChanged: (bool newValue) {
            setState(() {
              pernahRusakSebelumnya = newValue;
              estimasiPerbaikan = hitungEstimasiPerbaikan();
            });
          },
        ),
      ],
    );
  }

  Widget _buildLaporkanButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Logika untuk tombol "Hitung" di sini
              // Anda bisa menambahkan logika sesuai kebutuhan
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: SizedBox(
              height: 50.0, // Tinggi tombol
              child: Center(
                child: Text(
                  'Hitung',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.0), // Jarak antara tombol
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              final result = {
                'kerusakanType': selectedKerusakanType,
                'pernahRusakSebelumnya': pernahRusakSebelumnya,
                'estimasiPerbaikan': estimasiPerbaikan,
              };

              Navigator.of(context).pop(result);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: SizedBox(
              height: 50.0, // Tinggi tombol
              child: Center(
                child: Text(
                  'Laporkan',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHasilLaporan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Hasil Laporan Kerusakan:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Type Kerusakan: ${selectedKerusakanType ?? 'Belum dipilih'}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        Text(
          'Pernah Rusak Sebelumnya: ${pernahRusakSebelumnya ? 'Ya' : 'Tidak'}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        Text(
          'Estimasi Waktu Perbaikan: ${estimasiPerbaikan > 0 ? '$estimasiPerbaikan hari' : 'Belum dihitung'}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

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
}
