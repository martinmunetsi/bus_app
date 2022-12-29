import 'package:flutter/material.dart';
import 'package:bus_app/login.dart';
import 'package:bus_app/sign_up.dart';

enum LanguageOption { Portuguese, English }
final String _title = 'TransMetro Bus';

class LanguagePage extends StatefulWidget {
  LanguagePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  LanguagePageState createState() => LanguagePageState();

}

class LanguagePageState extends State<LanguagePage> {
  LanguageOption _language = LanguageOption.Portuguese;

  void Login() {
    //after language selection, navigate to login route when tapped.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(title: _title)),
    );
  }

  void SignUp() {
    //after language selection, navigate to Sign Up route when tapped.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage(title: _title + ': Sign Up')),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: const Text('Portuguese'),
                leading: Radio(
                  value: LanguageOption.Portuguese,
                  groupValue: _language,
                  onChanged: (LanguageOption value) {
                    setState(() {
                      _language = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('English'),
                leading: Radio(
                  value: LanguageOption.English,
                  groupValue: _language,
                  onChanged: (LanguageOption value) {
                    setState(() {
                      _language = value;
                    });
                  },
                ),
              ),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                OutlinedButton(
                  onPressed: (){
                    Login();
                  },
                  child: Text('LOGIN'),
                  //child: Icon(Icons.add),
                ),
              ],
            ),
            Column(
              children: [
                OutlinedButton(
                  onPressed: (){
                    SignUp();
                  },
                  child: Text('SIGN UP'),
                  //child: Icon(Icons.add),
                )
              ],
            )
          ]
      ),
            ]
        ),

      ),
    );
  }

}
