import 'package:flutter/material.dart';
// import '../shared/shared.dart';
import '../services/services.dart';
import 'package:geolocator/geolocator.dart';

class ProfileScreen extends StatefulWidget {
  createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  AuthService auth = AuthService();
  DatabaseService db = DatabaseService();
  num plainAvg = 0;
  Position _currentPosition;

  @override
  void initState() {
    super.initState();
    db.stats.listen((doc) => {
          setState(() {
            print('hellos');
            print(doc.data.plainCloudTotalMS);
            print((doc.data.plainCloudTotalMS / doc.data.plainCloudTotalCalls)
                .toString());
            plainAvg =
                doc.data.plainCloudTotalMS / doc.data.plainCloudTotalCalls;
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
        drawer: Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text('Top'),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                    color: Colors.red,
                    padding: EdgeInsets.all(5),
                    onPressed: () async {
                      Navigator.pop(context);
                      await auth.logout();
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: Text('Logout'),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_currentPosition != null)
                Text(
                    "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
              FlatButton(
                child: Text("Get location"),
                onPressed: () {
                  _getCurrentLocation();
                },
              ),
            ],
          ),
        ));
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
