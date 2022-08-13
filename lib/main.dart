import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:passwordmanager/routes/app_routes.dart';
import 'package:passwordmanager/views/home_page.dart';
import 'package:passwordmanager/views/new_password_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<bool> isSelected = [true, false];
    return MaterialApp(
      initialRoute: AppRoutes.HOME,
      routes: {
        AppRoutes.HOME: (context) => const HomePage(),
        AppRoutes.NEW_PASSWORD: (context) => const NewPasswordPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
