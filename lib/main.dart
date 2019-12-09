import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: new HomePage(),
        drawer: Drawer(),
        floatingActionButton: FloatingActionButton( onPressed: () {},),
      )
    );
  }
}




class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('My App is Lit'),
      ),
    );
  }
}
