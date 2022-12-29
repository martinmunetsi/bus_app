import 'package:flutter/material.dart';


class InfoPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return
        DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Text(
                    'Terms and Conditions',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Tajawal',
                        fontSize: 20),
                  ),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Tajawal',
                        fontSize: 20),
                  ),
                ],
              ),
              title: Center(child: Text('Info')),
            ),
            body: TabBarView(
              children: [
                TermsAndConditions(),
                PrivacyPolicy(),
              ],
            ),
          ),
        );
    }

}

class TermsAndConditions extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: ListView( //Allows scrolling
            children: <Widget>[
                    Text(''),
                    Text('terms line 1......................'),
                    Text('terms line 2......................'),
                    Text('terms line 3......................'),
                    Text('terms line 4......................'),
                    Text('terms line 5......................'),
                    Text('terms line 6......................'),
                    Text('terms line 7......................'),
                    Text('terms line 8......................'),
                    Text('terms line 9......................'),
                    Text('terms line 10......................'),
          ]
        ),
      ),
    );
  }

}

class PrivacyPolicy extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: ListView( //Allows scrolling
            children: <Widget>[
              Text(''),
              Text('privacy policy line 1......................'),
              Text('privacy policy line 2......................'),
              Text('privacy policy line 3......................'),
              Text('privacy policy line 4......................'),
              Text('privacy policy line 5......................'),
              Text('privacy policy line 6......................'),
              Text('privacy policy line 7......................'),
              Text('privacy policy line 8......................'),
              Text('privacy policy line 9......................'),
              Text('privacy policy line 10......................'),
            ]
        ),
      ),
    );
  }

}