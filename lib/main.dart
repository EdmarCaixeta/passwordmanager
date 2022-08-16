import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/utils/routes/app_routes.dart';
import 'package:passwordmanager/views/home_page.dart';
import 'package:passwordmanager/views/new_password_page.dart';
import 'package:passwordmanager/views/settings_page.dart';
import 'package:passwordmanager/views/sigin_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.AUTH_VERIFICATION,
      routes: {
        AppRoutes.HOME: (context) => HomePage(),
        AppRoutes.NEW_PASSWORD: (context) => const NewPasswordPage(),
        AppRoutes.SETTINGS: (context) => const SettingsPage(),
        AppRoutes.SIGNIN: ((context) => SigninPage()),
        AppRoutes.AUTH_VERIFICATION: (context) => const AuthVerification(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthVerification extends StatelessWidget {
  const AuthVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SigninPage();
          }
        },
      ),
    );
  }
}
