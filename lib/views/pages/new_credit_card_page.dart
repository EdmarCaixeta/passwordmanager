import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwordmanager/controllers/database.dart';
import 'package:passwordmanager/models/payment_card.dart';
import 'package:passwordmanager/models/password.dart';

class NewCreditCardPage extends StatefulWidget {
  const NewCreditCardPage({Key? key}) : super(key: key);

  @override
  State<NewCreditCardPage> createState() => _NewCreditCardPageState();
}

class _NewCreditCardPageState extends State<NewCreditCardPage> {
  final db = Database();
  late bool isNewPassword = true;

  final cardNumberController = TextEditingController();
  final cvvController = TextEditingController();
  final expirationDateController = TextEditingController();
  final ownerNameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _loadData(PaymentCard card) {
    ownerNameController.text = card.ownerName;
    cvvController.text = card.cvv;
    expirationDateController.text = card.expirationDate;
    cardNumberController.text = card.cardNumber;
  }

  String? validate(value) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var paymentCard = ModalRoute.of(context)?.settings.arguments as PaymentCard;
    if (paymentCard.id.isNotEmpty) {
      isNewPassword = false;
      _loadData(paymentCard);
    }
    return Scaffold(
      floatingActionButtonLocation: isNewPassword
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isNewPassword
          ? FloatingActionButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  if (paymentCard.id.isEmpty) {
                    db.createPaymentCardData(
                        cardNumberController.text,
                        cvvController.text,
                        expirationDateController.text,
                        ownerNameController.text);
                  } else {
                    db.changePaymentCardData(
                        paymentCard.id,
                        cardNumberController.text,
                        cvvController.text,
                        expirationDateController.text,
                        ownerNameController.text);
                  }

                  Navigator.of(context).pop();
                }
              },
              child: Icon(Icons.save),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () async {
                    db.deletePaymentCardData(paymentCard.id);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Are you sure?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel')),
                              TextButton(
                                  onPressed: () {
                                    db.deletePaymentCardData(paymentCard.id);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  )),
                            ],
                          );
                        });
                  },
                  child: Icon(Icons.delete),
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      if (paymentCard.id.isEmpty) {
                        db.createPaymentCardData(
                            cardNumberController.text,
                            cvvController.text,
                            expirationDateController.text,
                            ownerNameController.text);
                      } else {
                        db.changePaymentCardData(
                            paymentCard.id,
                            cardNumberController.text,
                            cvvController.text,
                            expirationDateController.text,
                            ownerNameController.text);
                      }

                      Navigator.of(context).pop();
                    }
                  },
                  child: const Icon(Icons.save),
                ),
              ],
            ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  inputFormatters: [TextInputMask(mask: '9999 9999 9999 9999')],
                  validator: validate,
                  keyboardType: TextInputType.number,
                  controller: cardNumberController,
                  maxLength: 20,
                  decoration: InputDecoration(
                    hintText: 'Card Number',
                    counterText: '',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: validate,
                  controller: ownerNameController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      hintText: 'Owner\'s Name', border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: validate,
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  decoration: InputDecoration(
                    hintText: 'CVV',
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  inputFormatters: [TextInputMask(mask: '99/99')],
                  validator: validate,
                  controller: expirationDateController,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  decoration: InputDecoration(
                      counterText: '',
                      hintText: 'Expiration Date',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
