import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        Registation.id: (context) => Registation(),
        Login.id: (context) => Login(),
        Chat.id: (context) => Chat(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String id ="HOMESCREEN";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  width: 100.0,
                  child: Image.asset('images/lion.png'),
                ),
              ),
              Text(
                'Kal',
                style: TextStyle(fontSize: 40.0),
              ),

            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          CustomButton(//below class called
            text: 'log in',
            callBack: (){
              Navigator.of(context).pushNamed(Login.id);
            },
          ),

          SizedBox(
            height: 20.0,
          ),
          CustomButton(//below class called
            text: 'Register',
            callBack: (){
              Navigator.of(context).pushNamed(Registation.id);
            },
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback callBack;
  final String text;

  const CustomButton({this.callBack,this.text});
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(8.0),
      child: Material(
        color: Colors.deepPurple,
        elevation: 6.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: callBack,
          minWidth: 200.0,
          height: 45.0,
          child: Text(text),
        ),
      ),
    );
  }
}

//rejistation
class Registation extends StatefulWidget {
  static const String id ="REGISTATION";
  @override
  _RegistationState createState() => _RegistationState();
}

class _RegistationState extends State<Registation> {
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;
//auth
  Future<void> registerUser()async{
    AuthResult result =await _auth.createUserWithEmailAndPassword(
        email: email, password: password,
    );
   FirebaseUser user= result.user;

   Navigator.push(context, MaterialPageRoute(
     builder: (context)=>Chat(user: user,),
   ),
   );
  }
//auth
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Descussion for IT'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Hero(
              tag: 'logo',
              child: Container(

                child: Image.asset('images/lion.png',
                ),
              ),
            ),
          ),

          SizedBox(height: 20.0,),
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value)=>email=value,
            decoration: InputDecoration(
                hintText: "Enter You email",
                border: const OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20.0,),
          TextField(
            autocorrect: false,
            obscureText: true,
            onChanged: (value)=>password=value,
            decoration: InputDecoration(
              hintText: "Enter You password",
              border: const OutlineInputBorder(),
            ),
          ),
          CustomButton(
            text: 'Register',
            callBack: () async{
              await registerUser();
            },
          ),
        ],
      ),
    );
  }
}

//login
class Login extends StatefulWidget {
  static const String id ="LOGIN";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser()async{//after this is called by custom button, this  start
    AuthResult result =await _auth.signInWithEmailAndPassword(
      email: email, password: password,
    );
    FirebaseUser user= result.user;

    Navigator.push(context, MaterialPageRoute(
      builder: (context)=>Chat(user: user,),
    ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Descussion for IT'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Hero(
              tag: 'logo',
              child: Container(

                child: Image.asset('images/lion.png',
                ),
              ),
            ),
          ),

          SizedBox(height: 20.0,),
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value)=> email =value,
            decoration: InputDecoration(
              hintText: "Enter You email",
              border: const OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20.0,),
          TextField(
            autocorrect: false,
            obscureText: true,
            onChanged: (value)=>password=value,
            decoration: InputDecoration(
              hintText: "Enter You password",
              border: const OutlineInputBorder(),
            ),
          ),
          CustomButton(
            text: 'Log in',
            callBack: () async{
              await loginUser();
            },
          ),
        ],
      ),
    );
  }
}

//chat............................................................................

class Chat extends StatefulWidget {
  static const String id ="CHAT";
  final FirebaseUser user;

   Chat({this.user});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final FirebaseAuth _auth =FirebaseAuth.instance;
  final Firestore _firestore=Firestore.instance;

  TextEditingController messangeController =TextEditingController();
  ScrollController scrollController= ScrollController();

  Future<void> callback() async{
    if (messangeController.text.length >0){
      await _firestore.collection('messages').add({
        'text' :messangeController.text,
        'from' :widget.user.email,
      });
      messangeController.clear();
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
          tag: 'logo',
          child: Container(
            height: 40.0,
            child: Image.asset('images/lion.png'),
          ),
        ),
        title: Text('Tensor Chat'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: (){
              _auth.signOut();//meka nathath palaweni ekata yanawa.
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').snapshots(),
                builder: (context,snapshots){
                    if(!snapshots.hasData)
                      return Center(
                          child: CircularProgressIndicator(),
                      );

                    List<DocumentSnapshot> docs =snapshots.data.documents;
                    
                    List<Widget> messages= docs.map((doc) => Message(
                      from: doc.data['from'],
                      text: doc.data['text'],
                      me: widget.user.email == doc.data['from'],
                    )).toList();

                  return ListView(
                    controller: scrollController,
                    children: <Widget>[

                      ...messages,
                    ],
                  );
                },
              ),
            ),

            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => callback(),
                      decoration: InputDecoration(
                        hintText: "Enter a massage...",
                      ),
                      controller: messangeController,
                    ),
                  ),
                  SendButton(
                    text: 'Send',
                    callback: callback,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({this.text,this.callback});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.amber,
      onPressed: callback,
      child: Text(text),
    );
  }
}

class Message extends StatelessWidget {
  final String from;
  final String text;
  final bool me;

  Message({this.text,this.from,this.me});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
        me ? CrossAxisAlignment.end :CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(from),

          Material(
            color: me? Colors.teal : Colors.red,
            borderRadius: BorderRadius.circular(10.0),
            elevation: 100,
            child:Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0 ),
              child: Text(text),

            ),
          ),
        ],
      ),
    );
  }
}

//51.15