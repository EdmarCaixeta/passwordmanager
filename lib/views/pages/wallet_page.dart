import 'package:flutter/material.dart';
import 'package:passwordmanager/controllers/database.dart';
import 'package:passwordmanager/models/payment_card.dart';
import 'package:passwordmanager/utils/color_pallete.dart';
import 'package:passwordmanager/utils/routes/app_routes.dart';
import 'package:passwordmanager/views/widgets/payment_card.dart';

class WalletPage extends StatelessWidget {
  PageController _pageController = PageController();

  var db = Database();
  WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.NEW_CREDIT_CARD,
              arguments: PaymentCard(
                  cvv: '', cardNumber: '', expirationDate: '', ownerName: ''));
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: walletCardColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<PaymentCard>>(
                stream: db.readPaymentCards(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong!');
                  } else if (snapshot.hasData) {
                    return PageView(
                      onPageChanged: (value) {},
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data!.map((doc) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                AppRoutes.NEW_CREDIT_CARD,
                                arguments: doc);
                          },
                          child: PaymentCardWidget(
                            cardNumber: doc.cardNumber,
                            expirationDate: doc.expirationDate,
                            ownerName: doc.ownerName,
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
