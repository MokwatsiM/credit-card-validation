extension CreditCardTypeExtension on String {
  String get inferCardType {
    if (startsWith(RegExp(r'^4'))) {
      return "Visa";
    } else if (startsWith(RegExp(r'^(5[1-5]|2[2-7][0-9]{2})'))) {
      return "MasterCard";
    } else if (startsWith(RegExp(r'^3[47]'))) {
      return "American Express";
    } else if (startsWith(RegExp(
        r'^(6011|65|64[4-9]|6221[2-9]|622[2-8][0-9]|6229[01]|62292[0-5])'))) {
      return "Discover";
    } else if (startsWith(RegExp(r'^(30[0-5]|36|38)'))) {
      return "Diners Club";
    } else if (startsWith(RegExp(r'^(352[8-9]|35[3-8][0-9])'))) {
      return "JCB";
    } else {
      return "Unknown";
    }
  }
}
