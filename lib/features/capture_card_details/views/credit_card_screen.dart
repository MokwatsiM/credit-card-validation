import 'package:credit_card_storage_system/features/capture_card_details/widgets/card_widget_form.dart';
import 'package:credit_card_storage_system/utils/appcolors.dart';
import 'package:credit_card_storage_system/blocs/credit_card_bloc.dart';
import 'package:credit_card_storage_system/blocs/credit_card_event.dart';
import 'package:credit_card_storage_system/common/widgets/credit_card_widget_template.dart';
import 'package:credit_card_storage_system/utils/infer_card_type_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card_scanner/credit_card.dart';

class CreditCardScreen extends StatelessWidget {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();

  final TextEditingController cvvController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  CreditCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  if (context.mounted) {
                    context
                        .read<CreditCardBloc>()
                        .add(UpdateCardNumber((results).number));
                    context
                        .read<CreditCardBloc>()
                        .add(UpdateCardHolderName((results).holderName));
                    context
                        .read<CreditCardBloc>()
                        .add(UpdateExpiryDate((results).expiryDate));
                    context
                        .read<CreditCardBloc>()
                        .add(UpdateCardType((results).number.trim()));
                  }

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
        padding: const EdgeInsets.all(16.0),
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
              ElevatedButton(
                onPressed: () {
                  onSaveCardDetailsUsingBloc(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorB58D67,
                  textStyle: const TextStyle(color: Colors.white),
                  minimumSize: Size(MediaQuery.of(context).size.width - 20, 50),
                ),
                child: const Text(
                  'Save card details',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSaveCardDetailsUsingBloc(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final state = context.read<CreditCardBloc>();
      state.add(ToggleCardView());
      state.add(UpdateCardType(cardNumberController.text.inferCardType));
      state.add(AddCard());

      if (state.errorMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.read<CreditCardBloc>().errorMessage)),
        );
        context.read<CreditCardBloc>().add(ClearErrorMessage());
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
