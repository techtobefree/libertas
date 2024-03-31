import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRDisplay extends StatefulWidget {
  final String code;

  const QRDisplay({Key? key, required this.code}) : super(key: key);

  @override
  _QRDisplayState createState() => _QRDisplayState();
}

class _QRDisplayState extends State<QRDisplay> {
  @override
  void initState() {
    super.initState();
    // _fetchEventData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QR Code',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 28, 72, 1.0),
                Color.fromRGBO(35, 107, 140, 1.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ),
      body: QrImageView(
        data: widget.code,
        version: QrVersions.auto,
        size: 200.0,
      ),
    );
  }
}
