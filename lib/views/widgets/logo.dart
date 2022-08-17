import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppLogo extends StatelessWidget {
  final width;

  const AppLogo({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Image(
        image: AssetImage('assets/Manager.png'),
      ),
    );
  }
}
