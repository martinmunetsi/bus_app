import 'package:bus_app/terms_privacy.dart';
import 'package:flutter/material.dart';
import 'forgot_password.dart';
import 'home.dart';

enum UserType { Passenger, Driver }
class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  UserType _user = UserType.Passenger;
  String _onError = '';
  String loginName='';
  String loginPassword='';
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  void validateLogin() {
    // This call to setState tells the Flutter framework that something has
    // changed in this State.
    setState(() {
      loginName = usernameController.text;
      loginPassword = passwordController.text;
      _onError='';
      if(loginName =='' || loginPassword==''){
        _onError = 'Invalid username or password.\n';
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '$_onError',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Tajawal',
                        fontSize: 20),
                  )),
              Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20,
                        color: Colors.blue),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email address',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Row(
                  children: <Widget>[
                    Expanded(child:ListTile(
                      title: const Text('Passenger'),
                      leading: Radio(
                        value: UserType.Passenger,
                        groupValue: _user,
                        onChanged: (UserType value) {
                          setState(() {
                            _user = value;
                          });
                        },
                      ),
                    )),
                    Expanded(child:ListTile(
                      title: const Text('Driver'),
                      leading: Radio(
                        value: UserType.Driver,
                        groupValue: _user,
                        onChanged: (UserType value) {
                          setState(() {
                            _user = value;
                          });
                        },
                      ),
                    )),
                  ]
              ),
              Row(
                children: [
                  FlatButton(
                    onPressed: (){
                      //forgot password screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordPage(title: 'Request password reset')),
                      );
                    },
                    textColor: Colors.blue,
                    child: Text('Forgot Password',
                    style:TextStyle(decoration: TextDecoration.underline)),
                  ),
                  FlatButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InfoPage()),
                      );
                    },
                    textColor: Colors.blue,
                    child: Icon(Icons.info),
                    //child: Text('Info'),
                  ),
                ],
              ),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Login'),
                    onPressed: () {
                      validateLogin();
                    },
                  )),
             ],
          )
      ),
    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

