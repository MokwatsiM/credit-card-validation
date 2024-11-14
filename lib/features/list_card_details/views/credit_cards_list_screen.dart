import 'package:carousel_slider/carousel_slider.dart';
import 'package:credit_card_storage_system/common/widgets/credit_card_widget_template.dart';
import 'package:credit_card_storage_system/models/credit_card_model.dart';
import 'package:credit_card_storage_system/utils/appcolors.dart';
import 'package:credit_card_storage_system/blocs/credit_card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreditCardsListScreen extends StatelessWidget {
  const CreditCardsListScreen({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.colorF9EED2,
          title: const Text('Credit Card List'),
        ),
        body: BlocBuilder<CreditCardBloc, CreditCardDataModel>(
          builder: (context, state) {
            return Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                    child: context
                            .read<CreditCardBloc>()
                            .getAllCreditCards()
                            .isNotEmpty
                        ? CarouselSlider(
                            items: context
                                .read<CreditCardBloc>()
                                .getAllCreditCards()
                                .reversed
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
                          )
                        : const Center(
                            child: Text('No saved cards'),
                          )));
          },
        ));
  }
}
