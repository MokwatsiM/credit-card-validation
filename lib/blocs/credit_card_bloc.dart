import 'package:credit_card_storage_system/models/credit_card_model.dart';
import 'package:credit_card_storage_system/repository/credit_card_repository.dart';
import 'package:credit_card_storage_system/blocs/credit_card_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreditCardBloc extends Bloc<CreditCardEvent, CreditCardDataModel> {
  final CreditCardRepository repository;
  String errorMessage = '';

  CreditCardBloc(this.repository) : super(CreditCardDataModel()) {
    on<UpdateCardNumber>((event, emit) {
      emit(state.copyWith(cardNumber: event.cardNumber));
    });
    on<UpdateCardHolderName>((event, emit) {
      emit(state.copyWith(cardHolderName: event.cardHolderName));
    });
    on<UpdateExpiryDate>((event, emit) {
      emit(state.copyWith(expiryDate: event.expiryDate));
    });
    on<UpdateCvv>((event, emit) {
      emit(state.copyWith(cvv: event.cvv));
    });
    on<UpdateCardType>((event, emit) {
      emit(state.copyWith(cardType: event.cardType));
    });
    on<UpdateIssuingAuthority>((event, emit) {
      emit(state.copyWith(issuingCountry: event.country));
    });
    on<ToggleCardView>((event, emit) {
      emit(state.copyWith(showBackView: !state.showBackView));
    });
    on<AddCard>((event, emit) {
      _addCard();
      emit(state);
    });
    on<GetCards>((event, emit) {
      getAllCreditCards();
      emit(state);
    });
    on<ClearErrorMessage>((event, emit) {
      clearErrorMessage();
      emit(state);
    });
    on<UpdateErrorMessage>((event, emit) {
      emit(state);
    });
  }

  void clearErrorMessage() {
    errorMessage = '';
  }

  void _addCard() {
    if (repository.isCountryBanned(state.issuingCountry)) {
      errorMessage = 'Sorry your card is from a banned country';
      state;
    } else if (repository
        .getAllCards()
        .where((element) => element.cardNumber == state.cardNumber)
        .isNotEmpty) {
      errorMessage = 'Card details already exist ';
      state;
    } else {
      state.copyWith(showBackView: !state.showBackView);
      repository.addCard(state);
    }
  }

  List<CreditCardDataModel> getAllCreditCards() {
    return repository.getAllCards();
  }
}
