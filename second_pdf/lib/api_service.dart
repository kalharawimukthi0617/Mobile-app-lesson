import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Apiservice{
  static final String PDF_URL="https://firebasestorage.googleapis.com/v0/b/ol-ict.appspot.com/o/ICT%20for%20grage%2010%2F1lession.pdf?alt=media&token=7066962f-dc77-4393-a12e-a3b45fe9ca32";

  static Future<String> loadPDF() async {
    var response=await http.get(PDF_URL);
    var dir=await getTemporaryDirectory();
    File file=new File(dir.path+"/data.pdf");
    
    await file.writeAsBytes(response.bodyBytes,flush: true);
    return file.path;
  }
}