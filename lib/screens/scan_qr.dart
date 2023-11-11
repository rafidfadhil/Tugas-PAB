import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() => runApp(MaterialApp(
      home: ScanQRPage(),
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF222736), // Warna utama aplikasi
        scaffoldBackgroundColor: Color(0xFF2D2F41), // Latar belakang aplikasi
      ),
    ));

class ScanQRPage extends StatefulWidget {
  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isFlashOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      appBar: AppBar(
        backgroundColor: Color(0xFF222736),
        title: Text(
          'Scan QR Code',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                ),
                Positioned(
                  top: 16.0,
                  right: 16.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildIconButton(
                        isFlashOn ? Icons.flash_on : Icons.flash_off,
                        _onFlashButtonPressed,
                      ),
                      SizedBox(width: 16.0),
                      _buildIconButton(
                        Icons.flip_camera_android,
                        _onFlipButtonPressed,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildResultText(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionButton(
            Icons.qr_code,
            'Scan QR Code',
            _onFlashButtonPressed,
            Colors.blue,
          ), // Tombol "Scan QR Code"
          SizedBox(width: 16.0), // Tambahkan jarak antara tombol "Scan QR Code" dan "Show QR Code"
          _buildActionButton(
            Icons.qr_code,
            'Show QR Code',
            _onShowQRCodeButtonPressed,
            Colors.green,
          ), // Tombol "Show QR Code"
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onFlashButtonPressed() {
    if (controller != null) {
      controller!.toggleFlash();
      setState(() {
        isFlashOn = !isFlashOn;
      });
    }
  }

  void _onFlipButtonPressed() {
    if (controller != null) {
      controller!.flipCamera();
    }
  }

  void _onShowQRCodeButtonPressed() {
    // Add logic to show your own QR code here
    // You can display a dialog or navigate to a new page to show the QR code.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your QR Code'),
          content: Container(
            width: 200.0, // Adjust the size as needed
            height: 200.0,
            child: Center(
              child: Image.asset(
                'assets/your_qr_code.png', // Replace with your QR code image path
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  IconButton _buildIconButton(IconData icon, Function() onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: onPressed,
    );
  }

  Widget _buildResultText() {
    if (result != null) {
      return Column(
        children: [
          Text(
            'Hasil Scan:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            '${result!.code}',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      );
    } else {
      return Text(
        'Arahkan kamera ke QR Code untuk memindai.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      );
    }
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    Function() onPressed,
    Color backgroundColor,
  ) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: Text(label),
      icon: Icon(icon),
      backgroundColor: backgroundColor,
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
