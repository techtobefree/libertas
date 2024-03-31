import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/events/handlers/event_handlers.dart';

class QRScan extends StatefulWidget {
  final String code;
  final String eventId;
  const QRScan({
    Key? key,
    required this.code,
    required this.eventId,
  }) : super(key: key);

  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  bool _isCheckingIn = false;

  @override
  void initState() {
    super.initState();
    // _fetchEventData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: _isCheckingIn
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : MobileScanner(
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.normal,
                facing: CameraFacing.back,
                torchEnabled: false,
              ),
              onDetect: (capture) async {
                final List<Barcode> barcodes = capture.barcodes;
                final Uint8List? image = capture.image;
                for (final barcode in barcodes) {
                  if (barcode.rawValue == widget.code) {
                    setState(() {
                      _isCheckingIn = true;
                    });
                    await EventHandlers.checkInUEventFromIds(widget.eventId,
                        BlocProvider.of<UserCubit>(context).state.id);
                    setState(() {
                      _isCheckingIn = false;
                    });
                    context.goNamed('checkedin',
                        queryParameters: {'eventId': widget.eventId});
                  }
                  debugPrint(
                      'Barcode found! ${barcode.rawValue} khgfkhgfjhgfj${widget.code}xx');
                }
              },
            ),
    );
  }
}
