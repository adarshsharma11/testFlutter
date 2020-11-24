import 'package:flutter/material.dart';
import 'package:uzuri/model/Response.dart';
import 'package:uzuri/ws/userRepository.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UserRepository user;
  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var success = false;

  @override
  void initState() {
    // TODO: implement initState

    user = UserRepository();

    super.initState();
  }

  saveRegister() async {
    var snackBar;

    if (!_formKey.currentState.validate()) {
      snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text("Incomplete fields"),
        duration: Duration(seconds: 3),
      );
      return;
      // _formKey.currentState.reset();
    }

    var data = Map<String, dynamic>();
    data["email"] = _emailController.text;
    data["firstname"] = _firstNameController.text;
    data["surname"] = _surnameController.text;

    Response res = await user.postRegister(data);

    if (res.success) {
      _formKey.currentState.reset();
      setState(() {
        success = true;
      });
      snackBar = SnackBar(
        backgroundColor: Color.fromRGBO(125, 199, 200, 1),
        content: Text(res.message),
        duration: Duration(seconds: 10),
      );
      _formKey.currentState.reset();
    } else {
      snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(res.message),
        duration: Duration(seconds: 5),
      );
      _formKey.currentState.reset();
    }

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: success == false
                    ? <Widget>[
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
                                "Register",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (val) => val.length > 0
                                  ? null
                                  : "Please enter your first name",
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "First Name",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              controller: _firstNameController,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (val) => val.length > 0
                                  ? null
                                  : "Please enter your surname",
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "Surname",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              controller: _surnameController,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value);

                                if (emailValid) {
                                  return null;
                                } else {
                                  return "Please enter a valid email.";
                                }
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              controller: _emailController,
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
                                saveRegister();
                              },
                              child: Text(
                                "Next",
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
                      ]
                    : <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
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
                                "Register",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Thank you"),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            "An email will be sent to you shortly to register."),
                        SizedBox(
                          height: 50,
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
