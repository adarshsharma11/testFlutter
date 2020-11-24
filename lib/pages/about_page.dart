import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/aboutus.jpg',
                            ),
                            fit: BoxFit.fill)),
                  ),
                  Positioned(
                    bottom: 60,
                    left: 0,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/uzuri_logo.png',
                                      ),
                                      fit: BoxFit.fill))),
                        ),
                      ),
                    ),
                  )
                ],
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
                  "About Us",
                  style: TextStyle(fontSize: 24, color: Colors.grey[700]),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Was are a Durban based business that",
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                    Text(
                      "supplies superior service and",
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                    Text(
                      "products to salons in the Hair and",
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                    Text(
                      "Beauty Industry throughout the",
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                    Text(
                      "KwaZulu Natal region",
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration:
                    BoxDecoration(color: Color.fromRGBO(125, 199, 200, 1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "We are proud agents for",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      "Hair Health & Beauty in KZN",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
