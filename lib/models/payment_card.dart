import 'package:flutter/material.dart';

enum CardType { MasterCard, Visa, Invalid, Others }

class PaymentCard {
  late CardType type;
  final String id;
  final String cvv;
  final String cardNumber;
  final String expirationDate;
  final String ownerName;

  PaymentCard({
    this.id = '',
    required this.cvv,
    required this.cardNumber,
    required this.expirationDate,
    required this.ownerName,
  });

  toJson() => {
        'id': id,
        'card-number': cardNumber,
        'cvv': cvv,
        'expiration-date': expirationDate,
        'owner-name': ownerName
      };

  static PaymentCard fromJson(Map<String, dynamic> json) => PaymentCard(
        id: json['id'],
        cardNumber: json['card-number'],
        ownerName: json['owner-name'],
        cvv: json['cvv'],
        expirationDate: json['expiration-date'],
      );
}
