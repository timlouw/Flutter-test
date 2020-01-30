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
              var dbresult = await db.testconnection();
              print(dbresult);
            },
            label: Expanded(
              child: Text('Test DB', textAlign: TextAlign.center, textScaleFactor: 1.2),
            ),
          ),
        ],
      )
    );
  }
}