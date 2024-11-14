import 'dart:io';

import 'package:credit_card_storage_system/features/credit_card_scanner.dart';
import 'package:credit_card_storage_system/models/credit_card_model.dart';
import 'package:credit_card_storage_system/features/capture_card_details/views/credit_card_screen.dart';
import 'package:credit_card_storage_system/features/list_card_details/views/credit_cards_list_screen.dart';
import 'package:credit_card_storage_system/repository/credit_card_repository.dart';
import 'package:credit_card_storage_system/blocs/credit_card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();

  final hiveStoragePath = Directory('${appDocumentDir.path}/hive_data');

  // Initialize Hive with a custom path
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(CreditCardDataModelAdapter());
  }

  if (!Hive.isBoxOpen('creditCards')) {
    Hive.init(hiveStoragePath.path);
    await Hive.openBox<CreditCardDataModel>('creditCards');
  }

  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => CreditCardRepository()),
      ],
      child: BlocProvider(
          create: (context) =>
              CreditCardBloc(context.read<CreditCardRepository>()),
          child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Card Capture App',
      home: CreditCardScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => CreditCardScreen(),
            );
          case '/list':
            return MaterialPageRoute(
              builder: (context) => const CreditCardsListScreen(),
            );
          case '/scanner':
            return MaterialPageRoute(
                builder: (context) => const CreditCardScanner(),
                settings: settings);
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}
