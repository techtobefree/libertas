import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:serve_to_be_free/services/dimensions.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: dimensions.statusBarHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: dimensions.largeAppBarHeight - dimensions.padding,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/testflightqrcode.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Share with your friends!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(
                    text: 'https://testflight.apple.com/join/tbiV25dX'));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Link copied to clipboard!')),
                );
              },
              child: Text(
                'https://testflight.apple.com/join/tbiV25dX',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
