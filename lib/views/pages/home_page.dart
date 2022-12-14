import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwordmanager/controllers/database.dart';
import 'package:passwordmanager/models/password.dart';
import 'package:passwordmanager/utils/routes/app_routes.dart';
import 'package:passwordmanager/views/widgets/cards.dart';
import 'package:passwordmanager/views/widgets/header.dart';

class HomePage extends StatelessWidget {
  var db = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.NEW_PASSWORD,
              arguments: Password(appname: '', username: '', password: ''));
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Header(),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  WalletCard(),
                  NotesCard(),
                  SafetyCard(),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Passwords',
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
            ),
            Expanded(
              child: passwordList(),
            )
          ],
        ),
      ),
    );
  }

  StreamBuilder<List<Password>> passwordList() {
    return StreamBuilder<List<Password>>(
      stream: db.readPasswords(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Text(
              'Empty List',
              style: TextStyle(fontWeight: FontWeight.w100),
            );
          }
          return ListView(
            children: snapshot.data!.map((doc) {
              return passwordListTile(context, doc);
            }).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  ListTile passwordListTile(BuildContext context, Password doc) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.NEW_PASSWORD, arguments: doc);
      },
      title: Text(doc.appname),
      subtitle: Text(doc.username),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
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
                                db.deletePasswordData(doc.id);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              )),
                        ],
                      );
                    });
                //db.deletePasswordData(doc.id);
              },
            ),
            IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: doc.password));
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Text copied!')));
              },
            ),
          ],
        ),
      ),
      leading: CircleAvatar(),
    );
  }
}
