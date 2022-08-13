import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/models/password.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
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
    _loadData(password);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
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
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Password', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if (password.id.isEmpty) {
                    //ID not initialized means registering a new password
                    createPasswordData(appnameController.text,
                        passwordController.text, usernameController.text);
                  } else {
                    //Existent ID means changing password data
                    changePasswordData(password.id, appnameController.text,
                        passwordController.text, usernameController.text);
                  }
                  Navigator.pop(context);
                },
                child: Text('Save'))
          ],
        ),
      ),
    );
  }

  Future createPasswordData(
      String appname, String password, String username) async {
    final docPassword =
        FirebaseFirestore.instance.collection('passwords').doc();

    final newPassword = Password(
        appname: appname,
        username: username,
        password: password,
        id: docPassword.id);

    final json = newPassword.toJson();
    await docPassword.set(json);
  }

  void changePasswordData(
      String id, String appname, String password, String username) async {
    final docPassword =
        FirebaseFirestore.instance.collection('passwords').doc(id);

    final newPassword = Password(
        appname: appname,
        username: username,
        password: password,
        id: docPassword.id);

    final json = newPassword.toJson();
    await docPassword.set(json);
  }
}
