import 'package:carousel_slider/carousel_slider.dart';
import 'package:credit_card_storage_system/utils/appcolors.dart';
import 'package:credit_card_storage_system/viewmodel/credit_card_notifier_viewmodel.dart';
import 'package:credit_card_storage_system/common/widgets/credit_card_widget_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreditCardsListScreen extends ConsumerWidget {
  const CreditCardsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedCards = ref
        .watch(creditCardStateProvider.notifier)
        .getAllCreditCards()
        .reversed;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorF9EED2,
        title: const Text('Credit Card List'),
      ),
      body: savedCards.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: CarouselSlider(
                  items: savedCards
                      .map((card) => CreditCardWidgetTemplate(
                            key: ValueKey(card.cardNumber),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 250,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    aspectRatio: 16 / 9,
                    initialPage: 0,
                  ),
                ),
              ),
            )
          : const Center(
              child: Text('No saved cards'),
            ),
    );
  }
}
