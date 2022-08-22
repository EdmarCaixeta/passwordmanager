import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:passwordmanager/models/payment_card.dart';

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

  Future createPaymentCardData(
    String cardNumber,
    String cvv,
    String expirationDate,
    String ownerName,
  ) async {
    final docCreditCard = database
        .collection('users')
        .doc(user!.uid)
        .collection('payment-cards')
        .doc();

    final newCreditCard = PaymentCard(
        cardNumber: cardNumber,
        cvv: cvv,
        expirationDate: expirationDate,
        ownerName: ownerName,
        id: docCreditCard.id);

    final json = newCreditCard.toJson();
    await docCreditCard.set(json);
  }

  Future changePaymentCardData(
    String id,
    String cardNumber,
    String cvv,
    String expirationDate,
    String ownerName,
  ) async {
    final docCreditCard = database
        .collection('users')
        .doc(user!.uid)
        .collection('payment-cards')
        .doc(id);

    final newCreditCard = PaymentCard(
        cardNumber: cardNumber,
        cvv: cvv,
        expirationDate: expirationDate,
        ownerName: ownerName,
        id: docCreditCard.id);

    final json = newCreditCard.toJson();
    await docCreditCard.set(json);
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

  Future deletePaymentCardData(String id) async {
    await database
        .collection('users')
        .doc(user!.uid)
        .collection('payment-cards')
        .doc(id)
        .delete();
  }

  Stream<List<Password>> readPasswords() => FirebaseFirestore.instance
      .collection('users')
      .doc(user?.uid)
      .collection('passwords')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Password.fromJson(doc.data())).toList());

  Stream<List<PaymentCard>> readPaymentCards() => FirebaseFirestore.instance
      .collection('users')
      .doc(user?.uid)
      .collection('payment-cards')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => PaymentCard.fromJson(doc.data()))
          .toList());
}
