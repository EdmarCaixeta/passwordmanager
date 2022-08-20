import 'package:flutter/material.dart';
import 'package:passwordmanager/utils/routes/app_routes.dart';

class PaymentCardWidget extends StatelessWidget {
  final String cardNumber;
  final String expirationDate;
  final String ownerName;

  const PaymentCardWidget(
      {super.key,
      required this.cardNumber,
      required this.expirationDate,
      required this.ownerName});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: Container(
              width: 450,
              height: 280,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/download.png'),
                      fit: BoxFit.fill),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Image.asset(
                        'assets/visa-logo.png',
                        scale: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Text(
                          cardNumber,
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ownerName,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w300),
                            ),
                            Text(
                              expirationDate,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ))
                ],
              )),
        ),
      ],
    );
  }
}
