import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'detail_Asset.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      appBar: AppBar(
        backgroundColor: Color(0xFF222736),
        elevation: 0,
        title: Row(
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
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8), // Reduced the gap from 24 to 8
            _buildImageSlider(context),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSearchTextField(),
                  ),
                  SizedBox(width: 16),
                  _buildSearchIconButton(),
                ],
              ),
            ),
            SizedBox(height: 24),
            _buildCustomCard(
              context,
              'Judul 1',
              'Deskripsi 1 yang panjang disini. Deskripsi ini akan dipotong dan hanya beberapa kata pertama yang akan ditampilkan.',
              'assets/image1.jpg', // Path gambar
            ),
            _buildCustomCard(
              context,
              'Judul 2',
              'Deskripsi 2 yang panjang disini. Deskripsi ini akan dipotong dan hanya beberapa kata pertama yang akan ditampilkan.',
              'assets/image2.jpg', // Path gambar
            ),
            _buildCustomCard(
              context,
              'Judul 3',
              'Deskripsi 3 yang panjang disini. Deskripsi ini akan dipotong dan hanya beberapa kata pertama yang akan ditampilkan.',
              'assets/image3.jpg', // Path gambar
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlider(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0), // Reduce the margin from 12.0 to 8.0
      width: screenWidth,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 190.0,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
        ),
        items: [
          _buildImageContainer('assets/image1.jpg', 'Caption 1'),
          _buildImageContainer('assets/image2.jpg', 'Caption 2'),
          _buildImageContainer('assets/image3.jpg', 'Caption 3'),
        ],
      ),
    );
  }

  Widget _buildImageContainer(String imagePath, String caption) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.black.withOpacity(0.7),
              child: Text(
                caption,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTextField() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF394046),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white54),
          prefixIcon: Icon(Icons.search, color: Colors.white54),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        ),
      ),
    );
  }

  Widget _buildSearchIconButton() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF394046),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Icon(Icons.tune, color: Colors.white54),
    );
  }

  Widget _buildCustomCard(BuildContext context, String title, String description, String imagePath) {
    final cardData = {'title': title, 'description': description};

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 14,
          ),
          maxLines: 2, // Display only two lines of description
          overflow: TextOverflow.ellipsis, // Show ellipsis (...) when text overflows
        ),
        trailing: IconButton(
          iconSize: 30,
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailAssetPage(data: cardData),
              ),
            );
          },
        ),
      ),
    );
  }
}
