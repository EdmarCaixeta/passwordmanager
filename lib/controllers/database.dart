import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/password.dart';

class Database {
  final user = FirebaseAuth.instance.currentUser;
  final database = FirebaseFirestore.instance;

  Future createPasswordData(
      String appname, String password, String username) async {
    final docPassword = database
        .collection('users')
        .doc(user!.uid)
        .collection('passwords')
        .doc();

    final newPassword = Password(
        appname: appname,
        username: username,
        password: password,
        id: docPassword.id);

    final json = newPassword.toJson();
    await docPassword.set(json);
  }

  Future changePasswordData(
      String id, String appname, String password, String username) async {
    final docPassword = database
        .collection('users')
        .doc(user!.uid)
        .collection('passwords')
        .doc(id);

    final newPassword = Password(
        appname: appname,
        username: username,
        password: password,
        id: docPassword.id);

    final json = newPassword.toJson();
    await docPassword.set(json);
  }

  Future deletePasswordData(String id) async {
    await database
        .collection('users')
        .doc(user!.uid)
        .collection('passwords')
        .doc(id)
        .delete();
  }

  Stream<List<Password>> readPasswords() => FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .collection('passwords')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Password.fromJson(doc.data())).toList());
}
