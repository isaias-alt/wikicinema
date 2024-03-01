import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:wikicinema/config/router/app_router.dart';
import 'package:wikicinema/config/theme/app_theme.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  Intl.defaultLocale = 'es_MX';
  initializeDateFormatting('es_MX', null);
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: 'Wikicinema',
      theme: AppTheme().getTheme(),
    );
  }
}
