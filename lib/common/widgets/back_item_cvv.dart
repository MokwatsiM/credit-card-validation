import 'package:credit_card_storage_system/utils/appcolors.dart';
import 'package:flutter/material.dart';

class BackItemCVV extends StatelessWidget {
  final String cvv;
  const BackItemCVV({super.key, required this.cvv});

  @override
  Widget build(BuildContext context) {
    return backItemCVV();
  }

  Column backItemCVV() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          height: 50,
          color: Colors.black,
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  height: 50,
                  color: Colors.white70,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 50,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    cvv,
                    style: const TextStyle(
                      color: AppColors.cardBgColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
