import 'package:flutter/material.dart';
import 'package:uzuri/model/Message.dart';
import 'package:uzuri/ws/userRepository.dart';

class NotificationDetails extends StatefulWidget {
  int id;

  NotificationDetails({Key key, this.id}) : super(key: key);
  @override
  _NotificationDetailsState createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  Message message;
  UserRepository userRepository;

  @override
  void initState() {
    userRepository = UserRepository();
    getNotifyDetail();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getNotifyDetail() async {
    final res = await userRepository.getNotifDetails(widget.id);

    if (res.success) {
      setState(() {
        message = Message.fromJson(res.value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: message != null
            ? Container(
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
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Color.fromRGBO(125, 199, 200, 1),
                                width: 5),
                            bottom: BorderSide(
                                color: Color.fromRGBO(125, 199, 200, 1),
                                width: 5)),
                      ),
                      child: Text(
                        message.title,
                        style: TextStyle(fontSize: 24, color: Colors.grey[700]),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color.fromRGBO(125, 199, 200, 1),
                                width: 5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          message.message,
                          softWrap: true,
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[700]),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(child: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
