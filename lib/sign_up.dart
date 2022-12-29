import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'home.dart';
import 'package:bus_app/terms_privacy.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  String firstName='';
  String lastName='';
  String cellphone='';
  String email='';
  DateTime _selectedDate;
  bool _validate = false;
  bool visible = true;
  String password, confirmPassword;
  bool _acceptedTermsAndPrivacyPolicy = false;
  final TextEditingController _dateOfBirthController = TextEditingController();
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final cellphoneController = TextEditingController();
  final emailController = TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _confirmPasswordController =  new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  void register() {

    if(!_acceptedTermsAndPrivacyPolicy) {
      showTermsDialog();
    } else if (_formKey.currentState.validate()) {
      //data is valid, continue.
      setState(() {
        firstName = firstNameController.text;
        lastName = lastNameController.text;
        cellphone = cellphoneController.text;
        email = emailController.text;
      });
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    cellphoneController.dispose();
    emailController.dispose();
    _dateOfBirthController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
          _buildFirstNameField(),
          _buildLastNameField(),
          _buildDateOfBirthField(),
          _buildCellphoneField(),
          _buildEmailField(),
          _buildInputPasswordField(),
          _buildConfirmPasswordField(),
          _buildTermsLink(),
          _buildAcceptanceOfTermsField(),
          _buildRegisterButton(),
        ],
      ),
      );
  }

   _buildDateOfBirthField() {
    return  Padding(
          padding: const EdgeInsets.all(0.0),
          child: GestureDetector(
            onTap: () => _selectDate(),
            child: AbsorbPointer(
              child: TextFormField(
                key: Key('dateOfBirth'),
                controller: _dateOfBirthController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5.0),
                  icon: Icon(Icons.date_range),
                  labelText: 'Date of Birth *',
                  hintText: 'Date of Birth',
                  border: OutlineInputBorder(),)
                ,
                validator: (String value) {
                  if (value.isEmpty){
                    return 'Please enter date of birth.';
                  }
                  return null;
                },
              ),
            ),
          ),
        );
  }

   _buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(children: [
        ElevatedButton.icon(
          onPressed: () {
            register();
          },
          label: Text('Register'),
          icon: Icon(Icons.how_to_reg),
        )
      ]),
    );
  }

   _buildLastNameField() {
    return TextFormField(
            key: Key('lastName'),
            controller: lastNameController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(5.0),
              icon: Icon(Icons.person),
              labelText: 'Last Name *',
              hintText: 'Enter your last name',
              border: OutlineInputBorder(),
            ),
            validator: (String value) {
              if( value.contains('@')) {
                return 'Do not use the @ char.';
              }
              else if (value.isEmpty){
                return 'Please enter your last name.';
              }
              return null;
            },
          );
  }

   _buildFirstNameField() {
    return  TextFormField(
            key: Key('firstName'),
            controller: firstNameController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(5.0),
              icon: Icon(Icons.person),
              labelText: 'First Name *',
              hintText: 'Enter your first name',
              border: OutlineInputBorder(),
            ),
            validator: (String value) {
              if( value.contains('@')) {
                return 'Do not use the @ char.';
              }
              else if (value.isEmpty){
                return 'Please enter your first name.';
              }
              return null;
            },
          );
  }


   _buildCellphoneField() {
    return TextFormField(
      key: Key('cellphone'),
      controller: cellphoneController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(5.0),
        icon: Icon(Icons.phone),
        labelText: 'Cell phone *',
        hintText: 'Enter your cell phone number',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
       // maxLength: 9,
      validator: (String value) {
        String pattern = r'(^[0-9]*$)';
        RegExp regExp = new RegExp(pattern);
        if (value.length == 0) {
          return 'Cell phone number is required';
        } else if(value.length != 9){
          return 'Cell phone number must be 9 digits';
        }else if (!regExp.hasMatch(value)) {
          return 'Cell phone number must be digits';
        }
        return null;
      },
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
        return validateEmail (value);
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

  _buildInputPasswordField() {
    return TextFormField(
        controller: _passwordController,
        obscureText: visible,
        validator: validatePassword,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5.0),
            hintText: 'Password *',
            icon: Icon( Icons.lock),
            border: OutlineInputBorder(),
            suffix: InkWell(
              child: visible
                  ? Icon(
                Icons.visibility_off,
                size: 5,
                color: Colors.blue,
              )
                  : Icon(
                Icons.visibility,
                size: 5,
                color: Colors.blue,
              ),
              onTap: () {
                setState(() {
                  visible = !visible;
                });
              },
            )),
        onSaved: (str) {
          password = str;
        });
  }
  _buildConfirmPasswordField() {
    return TextFormField(
        controller: _confirmPasswordController,
        obscureText: visible,
        validator: (confirmation) {
          return confirmation.isEmpty
              ? 'Confirm password is required'
              : validationEqual(confirmation, _passwordController.text) ? null : 'Password does not match';
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5.0),
            hintText: 'Confirm password *',
            icon: Icon( Icons.lock),
            border: OutlineInputBorder(),
            suffix: InkWell(
              child: visible
                  ? Icon(
                Icons.visibility_off,
                size: 5,
                color: Colors.blue,
              )
                  : Icon(
                Icons.visibility,
                size: 5,
                color: Colors.blue,
              ),
              onTap: () {
                setState(() {
                  visible = !visible;
                });
              },
            )),
        onSaved: (str) {
          confirmPassword = str;
        });
  }

  _buildAcceptanceOfTermsField()
  {
    return
        CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text('I have read, understood and agreed to the Terms and Conditions and Privacy Policy.'),
      value: _acceptedTermsAndPrivacyPolicy,
      onChanged: (value) {
        setState(() {
          _acceptedTermsAndPrivacyPolicy = !_acceptedTermsAndPrivacyPolicy;
        });
      },
    );
  }

  _buildTermsLink(){
    return
        FlatButton(
      onPressed: (){
        //Terms and Conditions and Privacy Policy screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InfoPage()),
        );
      },
      textColor: Colors.blue,
      child: Text('Terms and Conditions and Privacy Policy',
          style:TextStyle(decoration: TextDecoration.underline)),
    );
  }
  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }
  String validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Confirm password is required';
    } else if (value.length < 4) {
      return 'Confirm password must be at least 4 characters';
    }
    return null;
  }
  bool validationEqual(String currentValue, String checkValue) {
    if (currentValue == checkValue) {
      return true;
    }
    return false;
  }

  _selectDate() async {
    //you need to be 10 years or older to sign up
    var pickedDate =  await showDatePicker(
        context: context,
        initialDate:DateTime(DateTime.now().year-10),
        firstDate:DateTime(1900),
        lastDate: DateTime(DateTime.now().year-10));
    _selectedDate = pickedDate;
    _dateOfBirthController.text = pickedDate.toString().substring(0,10);
  }

  Future<void> showTermsDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Policy Acceptance Required'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Cannot register without accepting the Terms and Conditions and the Privacy Policy.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  }

