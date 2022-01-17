//profile screen


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}
String _post;
String _name;
String _email;
String _phoneNo;
class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin  {
  bool isLogin=true;
  Animation<double> containerSize;
  AnimationController animationController;
  Duration animationDuration=Duration(milliseconds: 270);

  @override
  void initState(){
    super.initState();
    retrievingData();
    animationController=AnimationController(vsync: this,duration: animationDuration);
  }

  @override
  void dispose(){
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark
    ));
    Size size=MediaQuery.of(context).size;
    double defaultLoginSize=size.height-(size.height*0.2);
    double defaultRegisterSize=size.height-(size.height*0.1)-25;
    containerSize=Tween<double>(begin: size.height*0.1,end: defaultRegisterSize).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.deepPurpleAccent,
            leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white), onPressed: () {
              Navigator.pop(context);
            },)
        ),
        body: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                painter: HeaderCurvedContainer(),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(40),
                    child: Text("Profile",
                      style: TextStyle(
                          fontSize: 35,
                          letterSpacing: 1.5,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                      ),),
                  ),
                  CustomPaint(
                    child:Container(
                      width: MediaQuery.of(context).size.width/2,
                      height: MediaQuery.of(context).size.width/3,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage('https://github.com/kaushikchandru/kidseducation/blob/master/asset/images/boy1.png?raw=true'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedOpacity(
                opacity:1.0,
                duration: animationDuration*4,
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Container(
                      width: size.width,
                      height: defaultLoginSize,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: 150),
                              padding: EdgeInsets.symmetric(horizontal: 45,vertical: 10),
                              child: Text('Post',style: TextStyle(fontSize: 20))),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              width: size.width*0.8,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.deepPurpleAccent.shade100
                              ),
                              child: Text(_post,style: TextStyle(fontSize: 20),)
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: 4),
                              padding: EdgeInsets.symmetric(horizontal: 45,vertical: 10),
                              child: Text('Username',style: TextStyle(fontSize: 20))),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              width: size.width*0.8,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.deepPurpleAccent.shade100
                              ),
                              child: Text(_name,style: TextStyle(fontSize: 20),)
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 45,vertical: 10),
                              child: Text('Email',style: TextStyle(fontSize: 20))),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              width: size.width*0.8,
                              height: 50,
                              margin: EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.deepPurpleAccent.shade100
                              ),
                              child: Text(_email,style: TextStyle(fontSize: 20),)
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 45,vertical: 10),
                              child: Text('Contact No.',style: TextStyle(fontSize: 20))),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              width: size.width*0.8,
                              height: 50,
                              margin: EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.deepPurpleAccent.shade100
                              ),
                              child: Text(_phoneNo,style: TextStyle(fontSize: 20),)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ]
        )
    );
  }
  retrievingData(){
    final firestoreInstance = FirebaseFirestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("userInfo").doc(firebaseUser.uid).get().then((value){

      setState(() {
        _email = value.data()["email"];
        _name = value.data()["name"];
        _post = value.data()["post"];
        _phoneNo = value.data()["phoneNo"];
      });
    });
  }
}
class HeaderCurvedContainer extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size){
    Paint paint=Paint()..color=Colors.deepPurpleAccent;
    Path path=Path()
      ..relativeLineTo(0,150)
      ..quadraticBezierTo(size.width/2,225,size.width,150)
      ..relativeLineTo(0,-150)
      ..close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate)=>false;
}