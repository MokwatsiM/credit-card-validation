import 'package:credit_card_storage_system/models/credit_card_model.dart';
import 'package:credit_card_storage_system/repository/credit_card_repository.dart';
import 'package:credit_card_storage_system/utils/infer_card_type_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreditCardNotifier extends AutoDisposeNotifier<CreditCardDataModel> {
  final CreditCardRepository repository;
  String errorMessage = '';

  CreditCardNotifier(this.repository);

  void updateCardNumber(String cardNumber) {
    state = state.copyWith(cardNumber: cardNumber);
  }

  void updateCardHolderName(String cardHolderName) {
    state = state.copyWith(cardHolderName: cardHolderName);
  }

  void updateExpiryDate(String expiryDate) {
    state = state.copyWith(expiryDate: expiryDate);
  }

  void updateCvv(String cvv) {
    state = state.copyWith(cvv: cvv);
  }

  void updateCardType(String cardNumber) {
    state =
        state.copyWith(cardType: cardNumber.replaceAll(' ', '').inferCardType);
  }

  void updateIssuingCountry(String country) {
    state = state.copyWith(issuingCountry: country);
  }

  void toggleShowBackView() {
    state = state.copyWith(showBackView: !state.showBackView);
  }

  void addCard() {
    if (repository.isCountryBanned(state.issuingCountry)) {
      errorMessage = 'Sorry your card is from a banned country';
    } else if (repository
        .getAllCards()
        .where((element) => element.cardNumber == state.cardNumber)
        .isNotEmpty) {
      errorMessage = 'Card details already exist ';
    } else {
      state.copyWith(showBackView: !state.showBackView);
      repository.addCard(state);
      state = CreditCardDataModel();
    }
  }

  void clearErrorMessage() {
    errorMessage = '';
  }

  List<CreditCardDataModel> getAllCreditCards() {
    return repository.getAllCards();
  }

  @override
  CreditCardDataModel build() {
    repository.loadBlockedCountries();
    return CreditCardDataModel();
  }
}

final creditCardStateProvider =
    AutoDisposeNotifierProvider<CreditCardNotifier, CreditCardDataModel>(
  () => CreditCardNotifier(CreditCardRepository()),
);
