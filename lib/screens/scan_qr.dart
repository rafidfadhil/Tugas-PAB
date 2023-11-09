import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRPage extends StatefulWidget {
  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isFlashOn = false; // To track the flashlight state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41), // Set background color to match your home page
      appBar: AppBar(
        backgroundColor: Color(0xFF222736), // Match the AppBar color with your home page
        title: Text(
          'Scan QR Code',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.topCenter, // Align items at the top center
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: (QRViewController controller) {
                        this.controller = controller;
                        controller.scannedDataStream.listen((scanData) {
                          setState(() {
                            result = scanData;
                          });
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 16.0, // Adjust the top position as needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          isFlashOn ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white, // Icon color
                        ),
                        onPressed: () {
                          if (controller != null) {
                            controller!.toggleFlash();
                            setState(() {
                              isFlashOn = !isFlashOn;
                            });
                          }
                        },
                      ),
                      SizedBox(width: 16.0),
                      IconButton(
                        icon: Icon(
                          Icons.flip_camera_android,
                          color: Colors.white, // Icon color
                        ),
                        onPressed: () {
                          if (controller != null) {
                            controller!.flipCamera();
                          }
                        },
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
                  if (result != null)
                    Text(
                      'Hasil Scan:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color
                      ),
                    ),
                  SizedBox(height: 8.0),
                  if (result != null)
                    Text(
                      '${result!.code}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white, // Text color
                      ),
                    )
                  else
                    Text(
                      'Arahkan kamera ke QR Code untuk memindai.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Text color
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (controller != null) {
            controller!.toggleFlash();
            setState(() {
              isFlashOn = !isFlashOn;
            });
          }
        },
        label: Text('Scan QR Code'),
        icon: Icon(Icons.qr_code),
        backgroundColor: Colors.blue, // FAB background color
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
