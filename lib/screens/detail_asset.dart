import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'laporan_kerusakan.dart';

class DetailAssetPage extends StatefulWidget {
  final Map<String, String> data; // Harus diisi dengan data aset yang relevan

  DetailAssetPage({required this.data});

  @override
  _DetailAssetPageState createState() => _DetailAssetPageState();
}

class _DetailAssetPageState extends State<DetailAssetPage> {
  int _currentImageIndex = 0;
  String? kerusakanType; // Type kerusakan, bisa 'RUSAK SEBAGIAN', 'RUSAK SEDANG', atau 'RUSAK PARAH'
  bool pernahRusakSebelumnya = false; // Status pernah rusak sebelumnya
  int estimasiPerbaikan = 0; // Estimasi perbaikan

  List<String> imageList = [
    'assets/image1.jpg', // Ganti dengan path gambar aset Anda
    'assets/image2.jpg', // Ganti dengan path gambar aset Anda
    'assets/image3.jpg', // Ganti dengan path gambar aset Anda
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
                widget.data['title'] ?? 'Judul Aset', // Ganti dengan judul aset sebenarnya
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
                widget.data['description'] ?? 'Deskripsi Aset', // Ganti dengan deskripsi aset sebenarnya
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
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LaporanKerusakanPage(),
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
                  primary: Colors.grey[300], // Change to match the design's color
                  onPrimary: Colors.black, // Text color
                  minimumSize: Size(double.infinity, 50), // Full-width and height size
                  elevation: 0, // Remove the elevation
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // Rounded corners
                  ),
                ),
                child: Text(
                  'Laporkan Kerusakan',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black, // Ensure text color is black to match the design
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
