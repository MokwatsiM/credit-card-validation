import 'package:credit_card_storage_system/common/widgets/card_item_view_holder.dart';
import 'package:credit_card_storage_system/models/credit_card_model.dart';
import 'package:flutter/material.dart';

class CardFrontItem extends StatelessWidget {
  final CreditCardDataModel cardModel;
  const CardFrontItem({super.key, required this.cardModel});

  @override
  Widget build(BuildContext context) {
    return cardFrontItem();
  }

  Column cardFrontItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/chip_2.png',
              height: 40,
              width: 40,
            ),
            Text(
              cardModel.cardType,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        Text(
          _formatCardNumber(cardModel.cardNumber),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            letterSpacing: 2,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CardItemViewHolder(
              title: 'CARD HOLDER',
              item: cardModel.cardHolderName,
            ),
            CardItemViewHolder(
              title: 'EXPIRES',
              item: cardModel.expiryDate,
            ),
          ],
        ),
      ],
    );
  }

  String _formatCardNumber(String number) {
    if (number.isEmpty) return '**** **** **** ****';
    final cleanNumber = number.replaceAll(RegExp(r'\D'), '');
    final paddedNumber = cleanNumber.padRight(16, '*');
    return [
      paddedNumber.substring(0, 4),
      paddedNumber.substring(4, 8),
      paddedNumber.substring(8, 12),
      paddedNumber.substring(12, 16),
    ].join(' ');
  }
}
