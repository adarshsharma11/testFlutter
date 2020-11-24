import 'package:flutter/material.dart';
import 'package:uzuri/ws/userRepository.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  UserRepository userRepository;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userRepository = UserRepository();
  }
  // final _userRepository =

  void login() async {
    var snackBar;
    if (_formKey.currentState.validate()) {
      Map<String, dynamic> data = Map<String, dynamic>();
      data['customerCode'] = _codeController.text;
      data['password'] = _passwordController.text;

      final res = await userRepository.postLogin(data);

      if (!res.success) {
        Navigator.pushNamedAndRemoveUntil(context, "/app", (route) => false);
      } else {
        snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text(res.message),
          duration: Duration(seconds: 5),
        );
        _formKey.currentState.reset();
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    } else {
      snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text("Incomplete fields"),
        duration: Duration(seconds: 3),
      );
      _formKey.currentState.reset();
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    height: 30,
                  ),
                  Card(
                    color: Color.fromRGBO(125, 199, 200, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (val) => val.length > 0
                            ? null
                            : "Please enter customer code.",
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Customer code",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        controller: _codeController,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (val) =>
                            val.length > 0 ? null : "Please enter password.",
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        controller: _passwordController,
                      ),
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
                        color: Colors.white,
                        textColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Color.fromRGBO(125, 199, 200, 1))),
                        onPressed: () {
                          login();
                        },
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.white,
                        textColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Color.fromRGBO(125, 199, 200, 1))),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, "/auth");
                        },
                        child: Text(
                          "Go Back",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
