import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  TabController tb;
  int hour =0;
  int min =0;
  int sec =0;
  bool started=true;
  bool stoped=true;
  int timeForTimer=0;
  String timetodiaplay ="";
  bool chektimer=true;

  @override
  void initState() {
    // TODO: implement initState

    tb = TabController(
        length: 2,
        vsync: this,);
    super.initState();
  }
  void start(){
    setState(() {
      started=false;
      stoped=false;
    });
      timeForTimer =((hour*60*60)+(min*60)+sec);
    //  debugPrint(timeForTimer.toString());
      Timer.periodic(Duration(
        seconds: 1,
      ), (Timer t){
        setState(() {
          if(timeForTimer<1 || chektimer ==false){
            t.cancel();
            chektimer=true;
            timetodiaplay="";
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=> MyHomePage(),
            ));
          }


          else if(timeForTimer<60){
              timetodiaplay= timeForTimer.toString();
              timeForTimer-=1;
          }
          else if(timeForTimer<3600){
            int m=timeForTimer~/60;
            int s=timeForTimer-(60*m);
            timetodiaplay=m.toString()+":"+s.toString();
            timeForTimer-=1;
          }
          else {
            int h=timeForTimer~/3600;
            int t=timeForTimer-(3600*h);
            int m=t~/60;
            int s=t-(60*m);
            timetodiaplay=h.toString()+":"+m.toString()+":"+s.toString();
            timeForTimer-=1;
          }

//          else{
//            timeForTimer-=1;
//          }
//          timetodiaplay=timeForTimer.toString();
        });
      });

  }
  void stop(){
    setState(() {
      started=true;
      stoped=true;
      chektimer=false;
    });
  }

  Widget timer(){
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text("HH",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w700),),
                    ),
                    NumberPicker.integer(
                        initialValue: hour,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60.0,
                        onChanged: (val){
                          setState(() {
                            hour=val;
                          });
                        }
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text("MM",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w700),),
                    ),
                    NumberPicker.integer(
                        initialValue: min,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60.0,
                        onChanged: (val){
                          setState(() {
                            min=val;
                          });
                        }
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text("SS",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w700),),
                    ),
                    NumberPicker.integer(
                        initialValue: sec,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60.0,
                        onChanged: (val){
                          setState(() {
                            sec=val;
                          });
                        }
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(timetodiaplay,style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600),),

          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(

                  onPressed: started ? start:null,
                  padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
                  color: Colors.amber,
                  child: Text("Start",style: TextStyle(fontSize: 18.0,color: Colors.white),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                ),
                RaisedButton(
                  onPressed: stoped ? null : stop,
                  padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
                  color: Colors.red,
                  child: Text("Stop",style: TextStyle(fontSize: 18.0,color: Colors.white),),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
    ),
              ],
            )
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("time projects"),
        centerTitle: true,
        bottom: TabBar(
            tabs: <Widget> [
              Text("Timer"),
              Text("Stopwatch"),
            ],
          labelPadding: EdgeInsets.only(
            bottom: 10.0,
          ),
          labelStyle: TextStyle(fontSize: 18.0),
          unselectedLabelColor: Colors.white60,
          controller: tb,
        ),
      ),
      body: TabBarView(
          children: <Widget>[

            timer(),
            Text("Stopwatch"),
          ],

        controller: tb,
      ),
    );
  }
}
