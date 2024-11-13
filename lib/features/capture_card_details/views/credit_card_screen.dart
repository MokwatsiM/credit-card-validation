import 'package:credit_card_storage_system/features/capture_card_details/widgets/card_widget_form.dart';
import 'package:credit_card_storage_system/utils/appcolors.dart';
import 'package:credit_card_storage_system/viewmodel/credit_card_notifier_viewmodel.dart';
import 'package:credit_card_storage_system/common/widgets/credit_card_widget_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card_scanner/credit_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreditCardScreen extends ConsumerWidget {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();

  final TextEditingController cvvController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  CreditCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          onSaveCardDetails(ref, context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.colorB58D67,
          textStyle: const TextStyle(color: Colors.white),
          minimumSize: Size(MediaQuery.of(context).size.width - 20, 50),
        ),
        child: const Text(
          'Save card details',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.colorF9EED2,
        title: const Text('Credit Card Capture'),
        actions: [
          IconButton(
              color: AppColors.colorB58D67,
              onPressed: () {
                Navigator.pushNamed(context, '/list');
              },
              icon: const Icon(
                Icons.credit_card,
              )),
          IconButton(
              color: AppColors.colorB58D67,
              onPressed: () async {
                final results = await Navigator.pushNamed(context, '/scanner');
                if (results is CreditCardModel) {
                  results;
                  ref
                      .read(creditCardStateProvider.notifier)
                      .updateCardHolderName((results).holderName);
                  ref
                      .read(creditCardStateProvider.notifier)
                      .updateCardNumber((results).number);
                  ref
                      .read(creditCardStateProvider.notifier)
                      .updateExpiryDate((results).expiryDate);
                  ref
                      .read(creditCardStateProvider.notifier)
                      .updateCardType((results).number.trim());

                  cardHolderNameController.text = (results).holderName;
                  cardNumberController.text = (results).number.trim();
                  expiryDateController.text = (results).expiryDate;
                }
              },
              icon: const Icon(
                Icons.camera_alt,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CreditCardWidgetTemplate(),
              ),
              CreditCardWidgetForm(
                  formKey: _formKey,
                  cardNumberController: cardNumberController,
                  cardHolderNameController: cardHolderNameController,
                  countryController: countryController,
                  expiryDateController: expiryDateController,
                  cvvController: cvvController),
            ],
          ),
        ),
      ),
    );
  }

  void onSaveCardDetails(WidgetRef ref, BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final widgetRef = ref.read(creditCardStateProvider.notifier);
      //
      widgetRef.updateCardType(cardNumberController.text);
      widgetRef.toggleShowBackView();

      widgetRef.addCard();

      if (widgetRef.errorMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widgetRef.errorMessage)),
        );
        widgetRef.clearErrorMessage();
      } else {
        cvvController.clear();
        cardHolderNameController.clear();
        cardNumberController.clear();
        countryController.clear();
        expiryDateController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Successfully saved your credit card details')),
        );
      }
    }
  }
}
