import 'package:credit_card_storage_system/common/widgets/back_item_cvv.dart';
import 'package:credit_card_storage_system/common/widgets/card_front_item.dart';
import 'package:credit_card_storage_system/models/credit_card_model.dart';
import 'package:credit_card_storage_system/utils/appcolors.dart';
import 'package:flutter/material.dart';

class CardDecoratedBox extends StatelessWidget {
  final String valueKey;
  final String? cvv;
  final CreditCardDataModel? cardModel;
  const CardDecoratedBox({
    super.key,
    required this.valueKey,
    this.cvv,
    this.cardModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      key: ValueKey(valueKey),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/card_bg.png'),
          fit: BoxFit.cover,
        ),
        color: AppColors.cardBgColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: cvv != null
          ? BackItemCVV(
              cvv: cvv!,
            )
          : CardFrontItem(cardModel: cardModel!),
    );
  }
}
