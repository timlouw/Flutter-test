import 'package:flutter/material.dart';
// import '../shared/shared.dart';
import '../services/services.dart';
import 'dart:developer';

class ProfileScreen extends StatefulWidget {
  createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  AuthService auth = AuthService();
  DatabaseService db = DatabaseService();

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user == null) {
          Navigator.pushReplacementNamed(context, '/');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton.icon(
            color: Colors.red,
            padding: EdgeInsets.all(30),
            icon: Icon(IconData(57563, fontFamily: 'MaterialIcons'), color: Colors.white60, size: 28),
            onPressed: () async {
              await auth.logout();
              Navigator.pushReplacementNamed(context, '/');
            },
            label: Expanded(
              child: Text('Logout', textAlign: TextAlign.center, textScaleFactor: 1.2),
            ),
          ),
          SizedBox(height: 50),
          FlatButton.icon(
            color: Colors.red,
            padding: EdgeInsets.all(30),
            icon: Icon(IconData(57563, fontFamily: 'MaterialIcons'), color: Colors.white60, size: 28),
            onPressed: () async {
              // print('start');
              // var time1 = DateTime.now();
              var dbresult = await db.callFunction('connectANDPull');
              // print(DateTime.now().difference(time1).inMilliseconds);
              // print('done');
              print(dbresult.data['recordsets'][0][0]);
              // print(dbresult.data['recordset'].length);
            },
            label: Expanded(
              child: Text('Test DB connection and fetch', textAlign: TextAlign.center, textScaleFactor: 1.2),
            ),
          ),
          SizedBox(height: 50),
          FlatButton.icon(
            color: Colors.blue,
            padding: EdgeInsets.all(30),
            icon: Icon(IconData(57563, fontFamily: 'MaterialIcons'), color: Colors.white60, size: 28),
            onPressed: () async {
              print('start');
              var time1 = DateTime.now();
              var dbresult = await db.callFunction('roundtriptest');
              print(DateTime.now().difference(time1).inMilliseconds);
              print('done');
            },
            label: Expanded(
              child: Text('Plain Cloud function', textAlign: TextAlign.center, textScaleFactor: 1.2),
            ),
          ),
          SizedBox(height: 50),
          FlatButton.icon(
            color: Colors.blue,
            padding: EdgeInsets.all(30),
            icon: Icon(IconData(57563, fontFamily: 'MaterialIcons'), color: Colors.white60, size: 28),
            onPressed: () async {
              print('start');
              var time1 = DateTime.now();
              var dbresult = await db.callFunction('firestorefetch');
              print(dbresult.data['recordsets'][0].length);
              print(dbresult.data['recordset'].length);
              print(DateTime.now().difference(time1).inMilliseconds);
              print('done');
            },
            label: Expanded(
              child: Text('Firestore Collection fetch of same data', textAlign: TextAlign.center, textScaleFactor: 1.2),
            ),
          ),
        ],
      )
    );
  }
}