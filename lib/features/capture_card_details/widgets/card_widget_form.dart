import 'package:credit_card_storage_system/models/credit_card_model.dart';
import 'package:credit_card_storage_system/utils/card_number_formatter.dart';
import 'package:credit_card_storage_system/utils/expiry_date_input_formatter.dart';
import 'package:credit_card_storage_system/utils/infer_card_type_extension.dart';
import 'package:credit_card_storage_system/blocs/credit_card_bloc.dart';
import 'package:credit_card_storage_system/blocs/credit_card_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreditCardWidgetForm extends StatelessWidget {
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
  Widget build(BuildContext contexts) {
    return BlocBuilder<CreditCardBloc, CreditCardDataModel>(
      builder: (context, state) {
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
                  context.read<CreditCardBloc>().add(UpdateCardNumber(value));
                  context
                      .read<CreditCardBloc>()
                      .add(UpdateCardType(value.inferCardType));
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
                onChanged: (value) => context
                    .read<CreditCardBloc>()
                    .add(UpdateCardHolderName(value)),
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
                onChanged: (value) => context
                    .read<CreditCardBloc>()
                    .add(UpdateIssuingAuthority(value)),
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
                      onChanged: (value) => context
                          .read<CreditCardBloc>()
                          .add(UpdateExpiryDate(value)),
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
                      onChanged: (value) =>
                          context.read<CreditCardBloc>().add(UpdateCvv(value)),
                      onTap: () =>
                          context.read<CreditCardBloc>().add(ToggleCardView()),
                      onEditingComplete: () =>
                          context.read<CreditCardBloc>().add(ToggleCardView()),
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
      },
    );
  }
}
