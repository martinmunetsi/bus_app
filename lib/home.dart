import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
    // Column is also a layout widget. It takes a list of children and
    // arranges them vertically. By default, it sizes itself to fit its
    // children horizontally, and tries to be as tall as its parent.
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
       Image.asset('assets/splash.jpg'),
       ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigate back to previous screen when tapped.
          },
          child: Text('Back'),
        ),
      ]
        ),

      ),
    );
  }
}