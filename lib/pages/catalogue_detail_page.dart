import 'dart:async';
import 'dart:io';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CatalogueDetailPage extends StatefulWidget {
  String name;
  String pdfName;
  CatalogueDetailPage({Key key, this.name, this.pdfName}) : super(key: key);
  @override
  _CatalogueDetailPageState createState() => _CatalogueDetailPageState();
}

class _CatalogueDetailPageState extends State<CatalogueDetailPage>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final Completer<PDFViewController> _controller =
  //     Completer<PDFViewController>();
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  String name;
  String remotePDFpath = "";
  String pdfName;
  @override
  void initState() {
    // TODO: implement initState

    name = widget.name;
    pdfName = widget.pdfName;

    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    try {
      final url = "http://uzuriadmin.co.za/pdf/$pdfName" + ".pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      if (await file.exists()) {
        await file.delete();
      }

      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      File newfile = File("${dir.path}/$filename");
      print("Download files");
      print("${dir.path}/$filename");

      await newfile.writeAsBytes(bytes, flush: true);
      completer.complete(newfile);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return remotePDFpath != ""
        ? Scaffold(
            body: Center(
            child: RaisedButton(
              child: Text(name + " pdf"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PDFScreen(remotePDFpath, name)),
              ),
            ),
          ))
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}

class PDFScreen extends StatelessWidget {
  String pdf = "";
  String name = "";
  PDFScreen(this.pdf, this.name);
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text(name),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    useSafeArea: true,
                    builder: (context) {
                      return AlertDialog(
                        title: Center(child: Text("Products")),
                        contentPadding: const EdgeInsets.all(16.0),
                        content: SizedBox(
                          height: 100.0,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: new TextField(
                                    onChanged: (String value) {},
                                    autofocus: true,
                                    decoration: new InputDecoration(),
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          new FlatButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          new FlatButton(
                              child: Text('Submit'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              })
                        ],
                      );
                    });
              },
            ),
          ],
        ),
        path: pdf);
  }
}

// Scaffold(
//       key: _scaffoldKey,
//       body: remotePDFpath != ""
//           ? Container(
//               child: PDFView(
//                 gestureRecognizers: ,
//                 filePath: remotePDFpath,
//                 enableSwipe: false,
//                 swipeHorizontal: false,
//                 autoSpacing: false,
//                 pageFling: true,
//                 pageSnap: true,
//                 defaultPage: currentPage,
//                 fitPolicy: FitPolicy.BOTH,

//                 preventLinkNavigation:
//                     true, // if set to true the link is handled in flutter
//                 onRender: (_pages) {
//                   setState(() {
//                     pages = _pages;
//                     isReady = true;
//                   });
//                 },
//                 onError: (error) {
//                   setState(() {
//                     errorMessage = error.toString();
//                   });
//                   print(error.toString());
//                 },
//                 onPageError: (page, error) {
//                   setState(() {
//                     errorMessage = '$page: ${error.toString()}';
//                   });
//                   print('$page: ${error.toString()}');
//                 },
//                 onViewCreated: (PDFViewController pdfViewController) {
//                   _controller.complete(pdfViewController);
//                 },
//                 onLinkHandler: (String uri) {
//                   print('goto uri: $uri');
//                 },
//                 onPageChanged: (int page, int total) {
//                   print('page change: $page/$total');
//                   setState(() {
//                     currentPage = page;
//                   });
//                 },
//               ),
//               errorMessage.isEmpty
//                   ? !isReady
//                       ? Center(
//                           child: CircularProgressIndicator(),
//                         )
//                       : Container()
//                   : Center(
//                       child: Text(errorMessage),
//                     )
//             )
//           : Container(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//       floatingActionButton: FutureBuilder<PDFViewController>(
//         future: _controller.future,
//         builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
//           if (snapshot.hasData) {
//             return FloatingActionButton.extended(
//                 onPressed: () async {

//                   showDialog(
//                       context: context,
//                       barrierDismissible: false,
//                       useSafeArea: true,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: Center(child: Text("Products")),
//                           contentPadding: const EdgeInsets.all(16.0),
//                           content: SizedBox(
//                             height: 100.0,
//                             child: Column(
//                               children: <Widget>[
//                                 Row(
//                                   children: <Widget>[
//                                     Expanded(
//                                         child: new TextField(
//                                       onChanged: (String value) {},
//                                       autofocus: true,
//                                       decoration: new InputDecoration(),
//                                     ))
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           actions: <Widget>[
//                             new FlatButton(
//                                 child: Text('Cancel'),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 }),
//                             new FlatButton(
//                                 child: Text('Submit'),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 })
//                           ],
//                         );
//                       });
//                 },
//                 label: Icon(Icons.add));
//           }

//           return Container();
//         },
//       ),
//     );
