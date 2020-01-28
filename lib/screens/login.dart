import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import '../shared/shared.dart';
import '../services/services.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();
  bool showForm = false;
  void toggleForm() {
    setState(() {
      showForm = !showForm;
      print(showForm);
    });
  }
  bool isFormShowing() {
    return showForm;
  }

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
      body: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Expanded(
            child: FlutterLogo(
              size: 200,
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: 390
            ),
            padding: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: showForm, 
                  child: LoginButtons(loginMethodGoogle: auth.googleLogin, toggleForm: toggleForm, isFormShowing: isFormShowing)
                ),
                Visibility(
                  visible: !showForm, 
                  child: LoginForm(toggleForm: toggleForm, loginMethodEmailPassword: auth.login, isFormShowing: isFormShowing)
                )
              ],
            ),
          )
        ],
      )
    );
  }
}








class LoginButtons extends StatelessWidget {
  final Function loginMethodGoogle;
  final Function toggleForm;
  final Function isFormShowing;

  const LoginButtons(
    {Key key, this.loginMethodGoogle, this.toggleForm, this.isFormShowing}
  ): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GoogleLoginButton(
          color: Colors.blue,
          loginMethod: loginMethodGoogle,
        ),
        EPLoginButton(
          color: Colors.amber,
          toggleForm: toggleForm,
          isFormShowing: isFormShowing
        )
      ],
    );
  }
}







class LoginForm extends StatelessWidget {
  final Function loginMethodEmailPassword;
  final Function toggleForm;
  final Function isFormShowing;

  const LoginForm(
    {Key key, this.loginMethodEmailPassword, this.toggleForm, this.isFormShowing}
  ): super(key: key);


  @override
  Widget build(BuildContext context) {
    TextStyle linkStyle = TextStyle(color: Colors.white70, fontSize: 15);

    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 20),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 30),
          EPLoginButton(
            color: Colors.amber,
            loginMethod: loginMethodEmailPassword,
            toggleForm: toggleForm,
            isFormShowing: isFormShowing,
          ),
          SizedBox(height: 30),
          RichText(
            text: TextSpan(
              style: linkStyle,
              children: <TextSpan>[
                TextSpan(
                  text: 'Login Methods',
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()..onTap = () {
                    toggleForm();
                  }
                ),
              ],
            )
          )
        ]
      )
    );
  }
}







class GoogleLoginButton extends StatelessWidget {
  final Color color;
  final Function loginMethod;

  const GoogleLoginButton(
    {Key key, this.color, this.loginMethod}
  ): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: FlatButton.icon(
        padding: EdgeInsets.all(25),
        icon: Icon(IconData(59481, fontFamily: 'MaterialIcons'), color: Colors.white54, size: 28),
        color: color,
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        label: Expanded(
          child: Text('Login with Google', textAlign: TextAlign.center, textScaleFactor: 1.2),
        ),
      ),
    );
  }
}








class EPLoginButton extends StatelessWidget {
  final Color color;
  final Function loginMethod;
  final Function toggleForm;
  final Function isFormShowing;

  const EPLoginButton(
    {Key key, this.color, this.loginMethod, this.toggleForm, this.isFormShowing}
  ): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: FlatButton.icon(
        padding: EdgeInsets.all(30),
        icon: Icon(IconData(57534, fontFamily: 'MaterialIcons'), color: Colors.white60, size: 28),
        color: color,
        onPressed: () async {
          if (isFormShowing()) {
            toggleForm();
          } else {
            var user = await loginMethod();
            if (user != null) {
              Navigator.pushReplacementNamed(context, '/profile');
            }
          } 
        },
        label: Expanded(
          child: Text('Email & Password Login', textAlign: TextAlign.center, textScaleFactor: 1.2),
        ),
      ),
    );
  }
}

            
            