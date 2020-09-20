import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'api_service.dart';


class Pdf_viewer extends StatefulWidget {
  @override
  _Pdf_viewerState createState() => _Pdf_viewerState();
}

class _Pdf_viewerState extends State<Pdf_viewer> {

  String _localFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Apiservice.loadPDF().then((value) {
      setState(() {
        _localFile=value;
      });
    } );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"),
        centerTitle: true,
      ),
      body: _localFile!=null?Container(
        child: PDFView(
          filePath: _localFile,
        ),
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}
