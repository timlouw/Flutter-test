import 'package:flutter/material.dart';
// import '../shared/shared.dart';
import '../services/services.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();
  bool showForm = false;

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/profile');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlutterLogo(
              size: 150,
            ),
            Text(
              'Login to Start',
              style: Theme.of(context).textTheme.headline,
              textAlign: TextAlign.center,
            ),
            showForm ? LoginForm() : LoginButtons(),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
    {Key key, this.text, this.icon, this.color, this.loginMethod}
  ): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: FlatButton.icon(
        padding: EdgeInsets.all(30),
        icon: Icon(icon, color: Colors.white),
        color: color,
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        label: Expanded(
          child: Text('$text', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}



class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
        ],
      ),
    );
  }
}

class LoginButtons extends StatelessWidget {
  final Function loginMethodEmailPassword;
  final Function loginMethodGoogle;

  const LoginButtons(
    {Key key, this.loginMethodEmailPassword, this.loginMethodGoogle}
  ): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          LoginButton(
            text: 'Google Login',
            color: Colors.black45,
            loginMethod: loginMethodGoogle,
            icon: Icon(
              Icons.golf_course
            ),
          ),
          LoginButton(text: 'Email & Password Login', color: Colors.black45, loginMethod: loginMethodEmailPassword)
        ],
      ),
    );
  }
}

            
            