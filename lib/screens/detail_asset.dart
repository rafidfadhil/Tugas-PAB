import 'package:flutter/material.dart';
import 'laporan_kerusakan.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailAssetPage extends StatefulWidget {
  final Map<String, String> data;

  DetailAssetPage({required this.data});

  @override
  _DetailAssetPageState createState() => _DetailAssetPageState();
}

class _DetailAssetPageState extends State<DetailAssetPage> {
  int _currentImageIndex = 0;
  String? kerusakanType;
  bool pernahRusakSebelumnya = false;
  int estimasiPerbaikan = 0;

  List<String> imageList = [
    'assets/image1.jpg',
    'assets/image2.jpg',
    'assets/image3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      appBar: AppBar(
        backgroundColor: Color(0xFF222736),
        elevation: 0,
        title: Text('Detail Aset', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 240.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                  ),
                  items: imageList.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map((entry) {
                      final int index = entry.key;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentImageIndex = index;
                          });
                        },
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentImageIndex == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.data['title'] ?? 'Judul Aset',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.data['description'] ?? 'Deskripsi Aset',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Estimasi Waktu Perbaikan: ${estimasiPerbaikan > 0 ? '$estimasiPerbaikan hari' : 'Belum dihitung'}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LaporanKerusakanPage(
                            namaAset: widget.data['title'],
                            deskripsiAset: widget.data['description'],
                          ),
                        ),
                      );

                      if (result != null && result is Map) {
                        setState(() {
                          kerusakanType = result['kerusakanType'];
                          pernahRusakSebelumnya = result['pernahRusakSebelumnya'];
                          estimasiPerbaikan = result['estimasiPerbaikan'];
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Laporkan Kerusakan',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            if (kerusakanType != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hasil Laporan Kerusakan:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Type Kerusakan: $kerusakanType',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Pernah Rusak Sebelumnya: ${pernahRusakSebelumnya ? 'Ya' : 'Tidak'}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Estimasi Waktu Perbaikan: ${estimasiPerbaikan > 0 ? '$estimasiPerbaikan hari' : 'Belum dihitung'}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
