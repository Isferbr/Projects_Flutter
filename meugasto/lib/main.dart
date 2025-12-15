// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meugasto/firebase_options.dart';
import 'package:meugasto/theme/app_theme.dart';
import 'package:meugasto/views/main_layout.dart';
import 'package:provider/provider.dart';

import 'controllers/auth_controller.dart';
import 'controllers/expense_controller.dart';
import 'controllers/navigation_controller.dart';
import 'views/login_view.dart';
import 'views/home_view.dart';
import 'views/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => ExpenseController()),
        ChangeNotifierProvider(create: (_) => NavigationController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const AuthGate(),
      );
  }
}
