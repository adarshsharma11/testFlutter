import 'package:flutter/material.dart';
import 'package:uzuri/model/Notifications.dart';
import 'package:uzuri/pages/notification_detail_page.dart';
import 'package:uzuri/ws/userRepository.dart';

class NotificationPage extends StatefulWidget {
  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  UserRepository userRepository;
  NotificationList list;

  @override
  void initState() {
    userRepository = UserRepository();
    // TODO: implement initState
    getAllNotifactions();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getAllNotifactions() async {
    final res = await userRepository.getAllNotify();

    if (res.success) {
      setState(() {
        list = NotificationList.fromJson(res.value);
      });
    }
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
                height: 10,
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
                height: 20,
              ),
              list != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.notifactions.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return ContainerText(
                          notification: list.notifactions[index],
                        );
                      })
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerText extends StatefulWidget {
  Notifications notification;
  ContainerText({Key key, this.notification}) : super(key: key);
  @override
  _ContainerTextState createState() => _ContainerTextState();
}

class _ContainerTextState extends State<ContainerText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
          color: Colors.white,
          textColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Color.fromRGBO(125, 199, 200, 1))),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationDetails(
                          id: widget.notification.id,
                        )));
          },
          child: Text(
            widget.notification.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
      ),
    );
  }
}
