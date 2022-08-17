import 'package:flutter/material.dart';
import 'package:passwordmanager/utils/routes/app_routes.dart';
import 'package:passwordmanager/views/widgets/logo.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppLogo(width: 150.0),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.SETTINGS);
                },
                icon: Icon(Icons.settings),
              )
            ],
          )
        ],
      ),
    );
  }
}
