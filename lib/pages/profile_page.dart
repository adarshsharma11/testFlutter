import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uzuri/authPages/auth.dart';
import 'package:uzuri/main.dart';
import 'package:uzuri/ws/Constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void logout(BuildContext context) async {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      prefs.clear();
      Constants.token = 0;
    });
    Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(builder: (context) => new AuthPages()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/uzuri_logo.png',
                        ),
                        fit: BoxFit.fill)),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Color.fromRGBO(125, 199, 200, 1), width: 5),
                      bottom: BorderSide(
                          color: Color.fromRGBO(125, 199, 200, 1), width: 5)),
                ),
                child: Text(
                  "Notifications",
                  style: TextStyle(fontSize: 24, color: Colors.grey[700]),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: Color.fromRGBO(125, 199, 200, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(
                            color: Color.fromRGBO(125, 199, 200, 1))),
                    onPressed: () {
                      logout(context);
                    },
                    child: Text(
                      "Logout",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
