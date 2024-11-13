import 'package:credit_card_storage_system/common/widgets/card_decorated_box.dart';
import 'package:credit_card_storage_system/models/credit_card_model.dart';
import 'package:credit_card_storage_system/viewmodel/credit_card_notifier_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreditCardWidgetTemplate extends ConsumerWidget {
  const CreditCardWidgetTemplate({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CreditCardDataModel state;
    if (super.key != null) {
      state = ref
          .watch(creditCardStateProvider.notifier)
          .getAllCreditCards()
          .where((element) => element.cardNumber == (key as ValueKey).value)
          .first;
    } else {
      state = ref.watch(creditCardStateProvider);
    }

    return GestureDetector(
        onTap: () =>
            ref.read(creditCardStateProvider.notifier).toggleShowBackView(),
        child: Stack(children: <Widget>[
          AnimatedPositioned(
              curve: Curves.elasticOut,
              duration: const Duration(milliseconds: 2800),
              child: AnimatedContainer(
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 300),
                  child: state.showBackView
                      ? _buildBackView(cardModel: state, context: context)
                      : _buildFrontView(cardModel: state, context: context)))
        ]));
  }

  Widget _buildFrontView(
      {required CreditCardDataModel cardModel, required BuildContext context}) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 0.2,
        height: MediaQuery.of(context).size.width / 1.9,
        child: CardDecoratedBox(
          valueKey: 'front',
          cardModel: cardModel,
          cvv: null,
        ));
  }

  Widget _buildBackView(
      {required CreditCardDataModel cardModel, required BuildContext context}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 0.2,
      height: MediaQuery.of(context).size.width / 1.9,
      child: CardDecoratedBox(
        valueKey: 'back',
        cvv: cardModel.cvv,
        cardModel: null,
      ),
    );
  }
}
