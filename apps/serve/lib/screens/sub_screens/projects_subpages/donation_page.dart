import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  void pay(int cents) async {
    try {
      var response = await http.post(
        Uri.parse(
            'http://server-to-be-free-flask-server:4242/create-payment-intent'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'cents': cents}),
      );
      var body = json.decode(response.body);
      var clientSecret = body['clientSecret'];
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Your Merchant Name',
      ));
      await Stripe.instance.presentPaymentSheet();
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text('Payment successful!'),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => pay(5 * 100),
          child: const Text('Donate 5 Bucks'),
        ),
      ),
    );
  }
}
