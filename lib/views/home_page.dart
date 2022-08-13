import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:passwordmanager/models/password.dart';
import 'package:passwordmanager/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  Stream<List<Password>> readPasswords() => FirebaseFirestore.instance
      .collection('passwords')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Password.fromJson(doc.data())).toList());

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
                  Card(),
                  Card(),
                  Card(),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [Text('Passwords')],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Password>>(
                stream: readPasswords(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong!');
                  } else if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data!.map((doc) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                AppRoutes.NEW_PASSWORD,
                                arguments: doc);
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
                                    deletePasswordData(doc.id);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.copy),
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: doc.password));
                                  },
                                ),
                              ],
                            ),
                          ),
                          leading: CircleAvatar(),
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
            )
          ],
        ),
      ),
    );
  }

  void deletePasswordData(String id) {
    final docPassword =
        FirebaseFirestore.instance.collection('passwords').doc(id).delete();
  }
}

class Card extends StatelessWidget {
  const Card({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Container(
        height: 300,
        width: 200,
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(10)),
        child: Text('Hello'),
      ),
    );
  }
}

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
          Text('PasswordManager'),
          Row(
            children: [Icon(Icons.search), Icon(Icons.settings)],
          )
        ],
      ),
    );
  }
}
