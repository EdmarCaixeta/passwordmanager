import 'package:flutter/material.dart';
import 'package:passwordmanager/utils/color_pallete.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 150,
          width: 130,
          decoration: BoxDecoration(
              color: walletCardColor, borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Icon(
            Icons.wallet,
            size: 80,
            color: walletCardAccentColor,
          )),
        ),
      ),
    );
  }
}

class NotesCard extends StatelessWidget {
  const NotesCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 150,
          width: 130,
          decoration: BoxDecoration(
              color: noteCardColor, borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Icon(
            Icons.notes,
            size: 80,
            color: noteCardAccentColor,
          )),
        ),
      ),
    );
  }
}

class SafetyCard extends StatelessWidget {
  const SafetyCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 150,
          width: 130,
          decoration: BoxDecoration(
              color: safetyCardColor, borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Icon(
            Icons.circle,
            size: 80,
            color: noteCardAccentColor,
          )),
        ),
      ),
    );
  }
}
