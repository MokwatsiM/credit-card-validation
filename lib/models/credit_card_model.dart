import 'package:hive/hive.dart';

part 'credit_card_model.g.dart';

@HiveType(typeId: 1)
class CreditCardDataModel extends HiveObject {
  @HiveField(0)
  final String cardNumber;

  @HiveField(1)
  final String cardType;

  @HiveField(2)
  final String cvv;

  @HiveField(3)
  final String issuingCountry;
  @HiveField(4)
  final String expiryDate;
  @HiveField(5)
  final String cardHolderName;

  final bool showBackView;

  CreditCardDataModel(
      {this.cardNumber = '',
      this.cardType = '',
      this.cvv = '',
      this.issuingCountry = '',
      this.expiryDate = '',
      this.cardHolderName = '',
      this.showBackView = false});

  CreditCardDataModel copyWith(
      {String? cardNumber,
      String? cardHolderName,
      String? expiryDate,
      String? cvv,
      bool? showBackView,
      String? cardType,
      String? issuingCountry}) {
    return CreditCardDataModel(
        cardNumber: cardNumber ?? this.cardNumber,
        cardHolderName: cardHolderName ?? this.cardHolderName,
        expiryDate: expiryDate ?? this.expiryDate,
        cardType: cardType ?? this.cardType,
        cvv: cvv ?? this.cvv,
        showBackView: showBackView ?? this.showBackView,
        issuingCountry: issuingCountry ?? this.issuingCountry);
  }
}
