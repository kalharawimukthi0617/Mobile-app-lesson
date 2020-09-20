import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() => runApp(MaterialApp(
  theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.red,
      accentColor: Colors.red
  ),
  home: MyApp(),
)
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String studentName,studentID,studyProgrameID;
  double studentGPA;

  getStudentName(name){
    this.studentName=name;
  }

//  getStudentId(id){
//    this.studentID=id;
//  }

  getProgrammeID(programmeId){
    this.studyProgrameID=programmeId;
  }

  getStudentGPA(gpa){
    this.studentGPA=double.parse(gpa);
  }



  createData() {
    DocumentReference documentReference=
    Firestore.instance.collection('MyStudents')
        .document(studentName);//connect to the firebase
                  //^^19

//create map
    Map<String,dynamic> students={
    'studentName':studentName,
 //   'studentID':studentID,
    'studyProgrameID':studyProgrameID,
    'studentGPA':studentGPA,

  };

    documentReference.setData(students).whenComplete((){
      print('$studentName created');
    });

  }

  readData() {
    DocumentReference documentReference=
    Firestore.instance.collection('MyStudents')
        .document(studentName);

    documentReference.get().then((datasnapshot){
      print(datasnapshot.data['studentName']);//we shoukd put into the firebase name
//      print(datasnapshot.data['studentID']);
      print(datasnapshot.data['studyProgrameID']);
      print(datasnapshot.data['studentGPA']);

    });

  }

  updateData() {
    DocumentReference documentReference=
    Firestore.instance.collection('MyStudents')
        .document(studentName);//connect to the firebase
    //^^19

//create map
    Map<String,dynamic> students={
      'studentName':studentName,
      'studentID':studentID,
      'studyProgrameID':studyProgrameID,
      'studentGPA':studentGPA,

    };

    documentReference.setData(students).whenComplete((){
      print('$studentName updated');
    });
  }

  deleteData() {
    DocumentReference documentReference=
    Firestore.instance.collection('MyStudents')
        .document(studentName);

    documentReference.delete().whenComplete((){
      print('$studentName deleted');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My flutter college'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2.0
                    )
                  ),

                ),
                onChanged: (String name){
                  getStudentName(name);
                },
              ),
            ),

//            Padding(
//              padding:  EdgeInsets.only(bottom: 5.0),
//              child: TextFormField(
//                decoration: InputDecoration(
//                  labelText: 'student ID',
//                  fillColor: Colors.white,
//                  focusedBorder: OutlineInputBorder(
//                      borderSide: BorderSide(color: Colors.blue,
//                          width: 2.0
//                      )
//                  ),
//
//                ),
//                onChanged: (String id){
//                  getStudentId(id);
//                },
//              ),
//            ),



            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Study programme ID',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,
                          width: 2.0
                      )
                  ),

                ),
                onChanged: (String programeId){
                  getProgrammeID(programeId);
                },
              ),
            ),




            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'GPA',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,
                          width: 2.0
                      )
                  ),

                ),
                onChanged: (String gpa){
                  getStudentGPA(gpa);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: Text('create'),
                  textColor: Colors.white,
                  onPressed: (){
                    createData();
                  },
                ),

                RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: Text('read'),
                  textColor: Colors.white,
                  onPressed: (){
                    readData();
                  },
                ),

                RaisedButton(
                  color: Colors.amberAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: Text('update'),
                  textColor: Colors.white,
                  onPressed: (){
                    updateData();
                  },
                ),

                RaisedButton(
                  color: Colors.lightGreenAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: Text('delete'),
                  textColor: Colors.white,
                  onPressed: (){
                    deleteData();
                  },
                ),
              ],
            ),
//            Padding(
//              padding: const EdgeInsets.all(5.0),
//              child: Row(
//                textDirection: TextDirection.ltr,
//                children: <Widget>[
//                Expanded(
//                  child: Text('Name'),
//                ),
//
//                Expanded(
//                  child: Text('Student ID'),
//                ),
//
//                Expanded(
//                  child: Text('Program ID'),
//                ),
//
//                Expanded(
//                  child: Text('GPA'),
//                ),
//
//              ],),
//            ),
//            'studentName':studentName,
//            'studentID':studentID,
//            'studyProgrameID':studyProgrameID,
//            'studentGPA':studentGPA,
//            'kal':kal,
            StreamBuilder(
              stream: Firestore.instance.collection('MyStudents').snapshots(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    shrinkWrap: true,
                      itemCount:snapshot.data.documents.length,
                      itemBuilder: (context,index){
                        DocumentSnapshot documentSnapshot= snapshot.data.documents[index];
                        return Row(
                          children: <Widget>[
                            Expanded(child: Text(documentSnapshot
                            ["studentName"]),
                            ),

//                            Expanded(child: Text(documentSnapshot
//                            ["studentID"]),
//                            ),

                            Expanded(child: Text(documentSnapshot
                            ["studyProgrameID"]),
                            ),

                            Expanded(child: Text(documentSnapshot
                            ["studentGPA"].toString()),
                            ),
                          ],
                        );
                      });
                }else{
                  return Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CircularProgressIndicator(),

                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

