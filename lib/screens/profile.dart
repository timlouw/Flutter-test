import 'package:flutter/material.dart';
// import '../shared/shared.dart';
import '../services/services.dart';

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
            padding: EdgeInsets.all(5),
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
            color: Colors.blue,
            padding: EdgeInsets.all(5),
            icon: Icon(IconData(57563, fontFamily: 'MaterialIcons'), color: Colors.white60, size: 28),
            onPressed: () async {
              await db.callFunction('sqlCloudasdasdasd');
            },
            label: Expanded(
              child: Text('SQL Cloud Function', textAlign: TextAlign.center, textScaleFactor: 1.2),
            ),
          ),
          Text('Average Time = ms', textAlign: TextAlign.center),
          SizedBox(height: 50),
          FlatButton.icon(
            color: Colors.blue,
            padding: EdgeInsets.all(5),
            icon: Icon(IconData(57563, fontFamily: 'MaterialIcons'), color: Colors.white60, size: 28),
            onPressed: () async {
              await db.callFunction('plainCloud');
            },
            label: Expanded(
              child: Text('Plain Cloud function', textAlign: TextAlign.center, textScaleFactor: 1.2),
            ),
          ),
          Text('Average Time = ms', textAlign: TextAlign.center),
          SizedBox(height: 50),
          FlatButton.icon(
            color: Colors.orange,
            padding: EdgeInsets.all(5),
            icon: Icon(IconData(57563, fontFamily: 'MaterialIcons'), color: Colors.white60, size: 28),
            onPressed: () async {
              await db.equalFirestore();
            },
            label: Expanded(
              child: Text('Firestore(80 docs)', textAlign: TextAlign.center, textScaleFactor: 1.2),
            ),
          ),
          Text('Average Time = ms', textAlign: TextAlign.center),
          SizedBox(height: 50),
          FlatButton.icon(
            color: Colors.orange,
            padding: EdgeInsets.all(5),
            icon: Icon(IconData(57563, fontFamily: 'MaterialIcons'), color: Colors.white60, size: 28),
            onPressed: () async {
              await db.filledFirestore();
            },
            label: Expanded(
              child: Text('Firestore(1000 docs)', textAlign: TextAlign.center, textScaleFactor: 1.2),
            ),
          ),
          Text('Average Time = ms', textAlign: TextAlign.center),
        ],
      )
    );
  }
}