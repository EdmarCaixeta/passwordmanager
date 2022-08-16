import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Home'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Wallet'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Notes'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Account Settings'),
              ),
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                },
                child: Text('Logout'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
