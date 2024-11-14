import 'dart:convert';

import 'package:credit_card_storage_system/models/credit_card_model.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class CreditCardRepository {
  CreditCardRepository() {
    loadBlockedCountries();
  }
  final Box<CreditCardDataModel> _creditCardBox = Hive.box('creditCards');
  List<String> bannedCountries = [];

  bool isCountryBanned(String country) {
    return bannedCountries.toString().toUpperCase().contains(country);
  }

  Future<void> addCard(CreditCardDataModel card) async {
    if (!await cardExists(card.cardNumber)) {
      await _creditCardBox.add(card);
    }
  }

  Future<bool> cardExists(String cardNumber) async {
    return _creditCardBox.values.any((card) => card.cardNumber == cardNumber);
  }

  List<CreditCardDataModel> getAllCards() {
    return _creditCardBox.values.toList();
  }

  Future<void> loadBlockedCountries() async {
    final String response =
        await rootBundle.loadString('assets/blocked_countries.json');

    final data = json.decode(response);

    // Populate the bannedCountries list from the JSON data
    bannedCountries = List<String>.from(data['blocked_countries']);
  }
}
