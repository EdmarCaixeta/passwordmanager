import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/controllers/database.dart';
import 'package:passwordmanager/models/password.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final db = Database();
  final passwordController = TextEditingController();
  final appnameController = TextEditingController();
  final usernameController = TextEditingController();

  void _loadData(Password password) {
    appnameController.text = password.appname;
    usernameController.text = password.username;
    passwordController.text = password.password;
  }

  @override
  Widget build(BuildContext context) {
    var password = ModalRoute.of(context)?.settings.arguments as Password;
    if (password.id.isNotEmpty) {
      _loadData(password);
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: appnameController,
                decoration: InputDecoration(
                    hintText: 'Appname', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Username/Email', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: 'Password', border: OutlineInputBorder()),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        passwordController.text =
                            password.generateRandomString();
                        setState(() {});
                      },
                      icon: Icon(Icons.refresh))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (password.id.isEmpty) {
                      //ID not initialized means registering a new password
                      db.createPasswordData(appnameController.text,
                          passwordController.text, usernameController.text);
                    } else {
                      //Existent ID means changing password data
                      db.changePasswordData(password.id, appnameController.text,
                          passwordController.text, usernameController.text);
                    }
                    Navigator.pop(context);
                  },
                  child: Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
