import 'package:flutter/material.dart';
import 'package:flutter_credit_card_scanner/credit_card.dart';
import 'package:flutter_credit_card_scanner/credit_card_scanner.dart';

class CreditCardScanner extends StatefulWidget {
  const CreditCardScanner({super.key});

  @override
  State<StatefulWidget> createState() => _CreditCardScannerState();
}

class _CreditCardScannerState extends State<CreditCardScanner> {
  bool scanFinished = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CameraScannerWidget(
        aspectRatio: 0.56,
        onNoCamera: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('No camera found, please enable camera')));
        },
        onScan: (_, CreditCardModel? p1) {
          if (p1!.holderName.isNotEmpty &&
              p1.expiryDate.isNotEmpty &&
              p1.number.isNotEmpty &&
              p1.expirationMonth.isNotEmpty &&
              p1.expirationYear.isNotEmpty &&
              !scanFinished) {
            scanFinished = true;
            Navigator.pop(context, p1);
          }
        },
        loadingHolder: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
