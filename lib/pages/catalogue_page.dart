import 'package:flutter/material.dart';
import 'package:uzuri/model/Catelogues.dart';
import 'package:uzuri/ws/userRepository.dart';

import 'catalogue_detail_page.dart';

class CataloguePage extends StatefulWidget {
  @override
  _CataloguePageState createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> {
  UserRepository userRepository;
  CateloguesList cateloguesList;
  @override
  void initState() {
    // TODO: implement initState
    userRepository = UserRepository();
    cateloguesList = CateloguesList();
    getListPdfs();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getListPdfs() async {
    final res = await userRepository.getListPdf();

    if (res.success) {
      setState(() {
        cateloguesList = res.value;
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
                height: 60,
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
                  "Catalogue",
                  style: TextStyle(fontSize: 24, color: Colors.grey[700]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              cateloguesList.catelogues != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: cateloguesList.catelogues.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return ContainerList(
                          catelogue: cateloguesList.catelogues[index],
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

class ContainerList extends StatefulWidget {
  Catelogue catelogue;
  ContainerList({Key key, this.catelogue}) : super(key: key);
  @override
  _ContainerListState createState() => _ContainerListState();
}

class _ContainerListState extends State<ContainerList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CatalogueDetailPage(
                          name: widget.catelogue.name,
                          pdfName: widget.catelogue.pdf_name,
                        )));
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.black, width: 2))),
            child: Text(
              widget.catelogue.name,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
