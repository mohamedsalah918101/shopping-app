import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopping_app/shopping_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // using EasyLocalization Package for switch between Arabic and English
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
          supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
          path: 'languages',
          fallbackLocale: Locale('en', 'US'),
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: tr('shopping_app_title'),

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: auth.currentUser == null ? LoginPage() : ShoppingPage(),
    );
  }
}

