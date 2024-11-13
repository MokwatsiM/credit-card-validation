import 'package:credit_card_storage_system/utils/card_number_formatter.dart';
import 'package:credit_card_storage_system/utils/expiry_date_input_formatter.dart';
import 'package:credit_card_storage_system/viewmodel/credit_card_notifier_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreditCardWidgetForm extends ConsumerWidget {
  const CreditCardWidgetForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.cardNumberController,
    required this.cardHolderNameController,
    required this.countryController,
    required this.expiryDateController,
    required this.cvvController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderNameController;
  final TextEditingController countryController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            controller: cardNumberController,
            decoration: const InputDecoration(
              labelText: 'Card Number',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              CardNumberFormatter()
            ],
            onChanged: (value) {
              ref
                  .read(creditCardStateProvider.notifier)
                  .updateCardNumber(value);
              ref.read(creditCardStateProvider.notifier).updateCardType(value);
            },
            validator: (value) {
              if (value == null || value.length < 16) {
                return 'Please enter a valid card number';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: cardHolderNameController,
            decoration: const InputDecoration(
              labelText: 'Card Holder Name',
              border: OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.characters,
            textInputAction: TextInputAction.next,
            onChanged: (value) => ref
                .read(creditCardStateProvider.notifier)
                .updateCardHolderName(value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter card holder name';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: countryController,
            decoration: const InputDecoration(
              labelText: 'Issuing Country',
              border: OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.characters,
            textInputAction: TextInputAction.next,
            onChanged: (value) => ref
                .read(creditCardStateProvider.notifier)
                .updateIssuingCountry(value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter issuing country name';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: expiryDateController,
                  decoration: const InputDecoration(
                    labelText: 'Expiry Date (MM/YY)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    ExpiryDateInputFormatter(),
                  ],
                  onChanged: (value) => ref
                      .read(creditCardStateProvider.notifier)
                      .updateExpiryDate(value),
                  validator: (value) {
                    if (value == null || value.length < 5) {
                      return 'Invalid expiry date';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  controller: cvvController,
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  onChanged: (value) => ref
                      .read(creditCardStateProvider.notifier)
                      .updateCvv(value),
                  onTap: () => ref
                      .read(creditCardStateProvider.notifier)
                      .toggleShowBackView(),
                  onEditingComplete: () => ref
                      .read(creditCardStateProvider.notifier)
                      .toggleShowBackView(),
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return 'Invalid CVV';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ]));
  }
}
