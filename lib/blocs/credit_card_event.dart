abstract class CreditCardEvent {}

class UpdateCardNumber extends CreditCardEvent {
  final String cardNumber;
  UpdateCardNumber(this.cardNumber);
}

class UpdateCardHolderName extends CreditCardEvent {
  final String cardHolderName;
  UpdateCardHolderName(this.cardHolderName);
}

class UpdateExpiryDate extends CreditCardEvent {
  final String expiryDate;
  UpdateExpiryDate(this.expiryDate);
}

class UpdateCvv extends CreditCardEvent {
  final String cvv;
  UpdateCvv(this.cvv);
}

class UpdateIssuingAuthority extends CreditCardEvent {
  final String country;
  UpdateIssuingAuthority(this.country);
}

class ToggleCardView extends CreditCardEvent {
  ToggleCardView();
}

class UpdateCardType extends CreditCardEvent {
  final String cardType;

  UpdateCardType(this.cardType);
}

class ClearErrorMessage extends CreditCardEvent {
  ClearErrorMessage();
}

class AddCard extends CreditCardEvent {
  AddCard();
}

class GetCards extends CreditCardEvent {
  GetCards();
}

class UpdateErrorMessage extends CreditCardEvent {
  final String errorMessage;
  UpdateErrorMessage(this.errorMessage);
}
