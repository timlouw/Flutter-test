import 'package:flutter/material.dart';
// import '../shared/shared.dart';
import '../services/services.dart';


class ProfileScreen extends StatefulWidget {
  createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  AuthService auth = AuthService();
  DatabaseService db = DatabaseService();
  num plainAvg = 0;

  @override
  void initState() {
    super.initState();
    print('hello');
    db.stats.listen((doc) => {
      setState(() {
        print('hellos');
        print(doc.data.plainCloudTotalMS);
        print((doc.data.plainCloudTotalMS / doc.data.plainCloudTotalCalls).toString());
        plainAvg = doc.data.plainCloudTotalMS / doc.data.plainCloudTotalCalls;
        print(plainAvg.toString());
      })
    });

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
          SizedBox(height: 15),
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
          Text('Average Time = ${plainAvg.toString()}ms', textAlign: TextAlign.center),
          SizedBox(height: 15),
          FlatButton.icon(
            color: Colors.blue,
            padding: EdgeInsets.all(5),
            icon: Icon(IconData(57563, fontFamily: 'MaterialIcons'), color: Colors.white60, size: 28),
            onPressed: () async {
              await db.callFunction('sqlCloud');
            },
            label: Expanded(
              child: Text('SQL CF - 156.38.151.52', textAlign: TextAlign.center, textScaleFactor: 1.2),
            ),
          ),
          Text('Average Time = ms', textAlign: TextAlign.center),
          SizedBox(height: 15),
          FlatButton.icon(
            color: Colors.blue,
            padding: EdgeInsets.all(5),
            icon: Icon(IconData(57563, fontFamily: 'MaterialIcons'), color: Colors.white60, size: 28),
            onPressed: () async {
              await db.callFunction('sqlCloudSS');
            },
            label: Expanded(
              child: Text('SQL CF - 160.119.141.249', textAlign: TextAlign.center, textScaleFactor: 1.2),
            ),
          ),
          Text('Average Time = ms', textAlign: TextAlign.center),
          SizedBox(height: 15),
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
          SizedBox(height: 15),
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