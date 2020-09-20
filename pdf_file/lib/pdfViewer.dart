import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
class PdfviewerPage extends StatefulWidget {
  @override
  _PdfviewerPageState createState() => _PdfviewerPageState();
}

class _PdfviewerPageState extends State<PdfviewerPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadfile();
  }

  PDFDocument document;
  loadfile()async{
    document=await PDFDocument.fromURL("http://smartlife-prezentace.cz/wp-content/uploads/2018/02/Oracle-Certified-Professiona-Java-SE-8-Programmer-Exam-1Z0-809.pdf");

    setState(() {
      document=document;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PDFViewer(document: document),
    );
  }
}

