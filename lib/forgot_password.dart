import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String email='';
  String _onSubmit = '';
  bool _isButtonDisabled;
  final String METRO_ADMIN_EMAIL = 'transmetro.maputo@gmail.com';
  bool _validate = false;
  bool visible = true;
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void requestPasswordReset() {

   if (_formKey.currentState.validate()) {
      //data is valid, continue.
      setState(() {
        email = emailController.text;
      });

      if( !_isButtonDisabled) {
        _launchURL(METRO_ADMIN_EMAIL, 'Forgot Password',
            'Password Reset required for: ' + email);
      }
    }
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
      setState(() {
        _onSubmit = 'Request has been submitted. An email will be sent to you with the instructions.';
        _isButtonDisabled = true;
      });
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    _isButtonDisabled = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FocusTraversalGroup(
          child: _buildForm(),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () {
        //Form.of(primaryFocus.context).save();
      },
      child: ListView( // Allows scrolling
        children: <Widget>[
          Text(''),
          _buildEmailField(),
          _buildSubmitButton(),
          Text(''),
          Center(child: Text(
            '$_onSubmit',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontFamily: 'Tajawal',
                fontSize: 20),
          )),
        ],
      ),
    );
  }

  _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(children: [
        ElevatedButton.icon(
          onPressed: () {
            requestPasswordReset();
          },
          label: Text('Submit'),
          icon: Icon(Icons.account_circle),
        )
      ]),
    );
  }

  _buildEmailField() {
    return  TextFormField(
      key: Key('email'),
      controller: emailController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(5.0),
        icon: Icon(Icons.email),
        labelText: 'Email *',
        hintText: 'Enter your email address',
        border: OutlineInputBorder(),
      ),
      validator: (String value) {
          return validateEmail(value);
      },
    );
  }

 String validateEmail(String value) {
   String regPattern =r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
   if (!value.contains('@')) {
     return 'Email needs the @ character.';
   }
   else if (!RegExp(regPattern).hasMatch(value)) {
     return 'This is not a valid email address';
   }
   return null;
  }

}