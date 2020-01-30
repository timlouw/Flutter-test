import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import '../shared/shared.dart';
import '../services/services.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  AuthService _auth = AuthService();
  String _error = '';
  bool _showError = false;
  bool _showForm = false;
  void toggleForm() {
    setState(() {_showForm = !_showForm;});
  }
  void hideError() {
    setState(() {_showError = false;});
  }
  void setError(String error) {
    setState(() {
      _showError = !_showError;
      _error = error;
    });
  }
  bool isFormShowing() {
    return _showForm;
  }

  @override
  void initState() {
    super.initState();
    _auth.getUser.then(
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
          SizedBox(height: 40),
          Expanded(
            child: FlutterLogo(
              size: 200,
            ),
          ),
          SizedBox(height: 7),
          Visibility(
            visible: _showError,
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            child: Text(_error, style: TextStyle(color: Colors.red, fontSize: 13),)
          ),
          SizedBox(height: 7),
          Container(
            constraints: BoxConstraints(
              minHeight: 340
            ),
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: _showForm, 
                  child: LoginButtons(loginMethodGoogle: _auth.googleLogin, toggleForm: toggleForm, isFormShowing: isFormShowing)
                ),
                Visibility(
                  visible: !_showForm, 
                  child: LoginForm(toggleForm: toggleForm, loginMethodEmailPassword: _auth.login, isFormShowing: isFormShowing, hideError: hideError, setError: setError,)
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
        FlatButton.icon(
          padding: EdgeInsets.all(20),
          icon: Icon(IconData(59481, fontFamily: 'MaterialIcons'), color: Colors.white54, size: 28),
          color: Colors.blue,
          onPressed: () async {
            var user = await loginMethodGoogle();
            if (user != null) {
              Navigator.pushReplacementNamed(context, '/profile');
            }
          },
          label: Expanded(
            child: Text('Google Account Login', textAlign: TextAlign.center, textScaleFactor: 1.2),
          ),
        ),
        SizedBox(height: 20),
        FlatButton.icon(
          padding: EdgeInsets.all(20),
          icon: Icon(IconData(57534, fontFamily: 'MaterialIcons'), color: Colors.white60, size: 28),
          color: Colors.amber,
          onPressed: () async {
            toggleForm();
          },
          label: Expanded(
            child: Text('Email & Password Login', textAlign: TextAlign.center, textScaleFactor: 1.2),
          ),
        ),
      ],
    );
  }
}







class LoginForm extends StatelessWidget {
  final Function loginMethodEmailPassword;
  final Function toggleForm;
  final Function isFormShowing;
  final Function setError;
  final Function hideError;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formValidationService = FormValidationService();

  LoginForm(
    {Key key, this.loginMethodEmailPassword, this.toggleForm, this.isFormShowing, this.hideError, this.setError, }
  ): super(key: key);

  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              validator: (value) {
                return _formValidationService.validateValue(
                  value, 
                  r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$', 
                  true, 
                  "Email is not valid", 
                  "Enter your email"
                );
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              validator: (value) {
                return _formValidationService.validateValue(value, r'^.{6,}$', true, "Minimum of any 6 characters", "Enter your password");
              },
            ),
            SizedBox(height: 20),
            FlatButton.icon(
              padding: EdgeInsets.all(20),
              icon: Icon(IconData(57534, fontFamily: 'MaterialIcons'), color: Colors.white60, size: 28),
              color: Colors.amber,
              onPressed: () async {
                if (isFormShowing()) {
                  toggleForm();
                } else {
                  if (_formKey.currentState.validate()) {
                    loginMethodEmailPassword(_emailController.text, _passwordController.text).then((e) => {
                      hideError(),
                      print(e),
                      Navigator.pushReplacementNamed(context, '/profile')
                    }).catchError((error) => {
                      setError(error.code),
                      print(error.code)
                    });
                  }
                } 
              },
              label: Expanded(
                child: Text('Email & Password Login', textAlign: TextAlign.center, textScaleFactor: 1.2),
              ),
            ),
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white70, fontSize: 15),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Login Methods',
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      toggleForm();
                      hideError();
                    }
                  ),
                ],
              )
            )
          ]
        )
      )
    );
  }
}     