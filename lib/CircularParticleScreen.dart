import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon_project/MentorHome.dart';
import 'package:hackathon_project/VerifyScreen.dart';
import 'package:hackathon_project/database.dart';
import 'package:hackathon_project/homePage.dart';
import 'package:hackathon_project/loading.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:toast/toast.dart';

class CircularParticleScreen2 extends StatefulWidget {
  @override
  State<CircularParticleScreen2> createState() => _CircularParticleScreen2State();
}


class _CircularParticleScreen2State extends State<CircularParticleScreen2> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation<double> _opacity;
  Animation<double> _transform;

  bool isRememberMe =false;
  String _name;
  String _email;
  String _password;
  String image="";
  List subjects=[];
  String post;
  Map<String,List<String>> mentOrstud;
  Map<String,bool> topics ={ };
  List days;
  String time;
  bool isVerified = false;
  String number;
  String _reEnterPassword;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
      setState(() {});
    });

    _transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    signIn(_email, _password);
    signUp(_email, _password);
    _controller.dispose();
    super.dispose();
  }
  bool _isVisible = true;
  bool _isVisibleUp =false;
  bool _isVisibleForgot=false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffFEC37B),
              Color(0xffFF4184),
            ],
          ),
        ),
        child: Stack(
          children: [
            CircularParticle(
            width: w,
            height: h,
            particleColor: Colors.white.withOpacity(.6),
            numberOfParticles: 150,
            speedOfParticles: 1.5,
            maxParticleSize: 7,
            awayRadius: 0,
            onTapAnimation: false,
            isRandSize: true,
            isRandomColor: false,
            connectDots: false,
            enableHover: false,
          ),
          Center(
            child: Visibility(
              visible: _isVisible,
              child: Opacity(
                opacity: _opacity.value,
                child: Transform.scale(
                  scale: _transform.value,
                  child: Container(
                    width: size.width * .9,
                    height: size.width * 1.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 90,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(),
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(.7),
                          ),
                        ),
                        SizedBox(),
                        component1(
                            Icons.email_outlined, 'Email...', false, true),
                        component1(
                            Icons.lock_outline, 'Password...', true, false),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            component2(
                              'LOGIN',
                              2.6,
                                  () {
                                HapticFeedback.lightImpact();
                              },
                            ),
                            SizedBox(width: size.width / 25),
                            Container(
                              width: size.width / 2.6,
                              alignment: Alignment.center,
                              child: RichText(
                                text: TextSpan(
                                  text: 'Forgotten password!',
                                  style: TextStyle(color: Colors.blueAccent),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        _email = null;
                                        _isVisible = false;
                                        _isVisibleForgot = true;
                                      });
                                    },
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(),
                        RichText(
                          text: TextSpan(
                            text: 'Create a new Account',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 15,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  _email =null;
                                  _password =null;
                                  _isVisible=false;
                                  _isVisibleUp=true;
                                });
                              },
                          ),
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        Center(
            child: Visibility(
              visible: _isVisibleUp,
              child: Opacity(
                opacity: _opacity.value,
                child: Transform.scale(
                  scale: _transform.value,
                  child: Container(
                    width: size.width * .9,
                    height: size.width * 1.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 90,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(),
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(.7),
                          ),
                        ),
                        SizedBox(),

                            component1(Icons.account_circle_outlined,
                                'User name...', false, false),
                            component3(Icons.phone_android,
                                'Mobile Number...', false, true),
                            component1(
                                Icons.email_outlined, 'Email...', false, true),
                            component1(
                                Icons.lock_outline, 'Password...', true, false),
                            component3(Icons.lock_outline,
                                'Confirm Password...', true, false),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            component2(
                              'Sign Up',
                              2.6,
                                  () {
                                HapticFeedback.lightImpact();
                              },
                            ),
                            SizedBox(width: size.width / 25),
                            Container(
                              width: size.width / 2.6,
                              alignment: Alignment.center,
                              child: RichText(
                                text: TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(color: Colors.blueAccent),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                    setState(() {
                                      _email =null;
                                      _password = null;
                                      _reEnterPassword =null;
                                      number =null;
                                      _name =null;
                                      _isVisibleUp = false;
                                      _isVisible = true;
                                    });
                                    },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),),
            Center(
              child: Visibility(
                visible: _isVisibleForgot,
                child: Opacity(
                  opacity: _opacity.value,
                  child: Transform.scale(
                    scale: _transform.value,
                    child: Container(
                      width: size.width * .9,
                      height: size.width * 1.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            blurRadius: 90,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(),
                          Text(
                            'Forgot Password',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(.7),
                            ),
                          ),
                          SizedBox(),
                          component1(
                              Icons.email_outlined, 'Email...', false, true),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              component2(
                                'Forgot',
                                2.6,
                                    () {
                                  HapticFeedback.lightImpact();
                                  },
                              ),
                              SizedBox(width: size.width / 25),
                              Container(
                                width: size.width / 2.6,
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Sign In!',
                                    style: TextStyle(color: Colors.blueAccent),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        setState(() {
                                          _isVisibleForgot=false;
                                          _isVisible=true;
                                        });
                                      },
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
              ),)
          ]
        ),
      ),
    );
  }
  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        style: TextStyle(color: Colors.black.withOpacity(.8)),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        textCapitalization: isEmail ||isPassword ?TextCapitalization.none:TextCapitalization.words,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle:
          TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
        ),
        onChanged: (value){
          setState(() {
            if(hintText == 'Password...'){
              print("Password $_password");
             _password = value.trim();}
            else if(hintText == 'Email...')
             {_email = value.trim();
             print("Email");}
            else if(hintText == 'User name...'){
              print("Name");_name = value.trim();
            }
          });
        },
      ),
    );
  }
  Widget component2(String string, double width, VoidCallback voidCallback) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: voidCallback,
      child: GestureDetector(
        onTap: (){
          string == "Forgot"?forgotPassword():
          string == "Sign Up"? signUp(_email, _password) : signIn(_email, _password);
        },
        child: Container(
          height: size.width / 8,
          width: size.width / width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xff4796ff),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            string,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget component3(
      IconData icon, String hintText, bool isPassword, bool isNumber) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        style: TextStyle(color: Colors.black.withOpacity(.8)),
        obscureText: isPassword,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle:
          TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
        ),
        onChanged: (value){
          setState(() {
            if(isNumber){
              number = value.trim();
            }
            if(isPassword){
              _reEnterPassword = value.trim();
            }
          });
        },
      ),
    );
  }
  signIn(String _email,String _password) async{
    bool isVerified ;
    Navigator.of(context).popUntil((route) => route.isFirst);
    if(_email == null || _password == null){
      Toast.show('Invalid Input',context,gravity: Toast.TOP,duration: Toast.LENGTH_SHORT);
    }else{
      final firestoreInstance = FirebaseFirestore.instance;
      var firebaseUser = FirebaseAuth.instance.currentUser;
      try{
        final auth =FirebaseAuth.instance;
        await auth.signInWithEmailAndPassword(email: _email, password: _password);
        firestoreInstance.collection("userInfo").doc(firebaseUser.uid).get().then((value)async{
          print('value is' + value.data()["email"]);
          isVerified = value.data()["isVerified"];
          if ((value.data()["isVerified"]) == true ){
            print('post...............${value.data()["post"]}');
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Loading()));
            }
          else{
            Toast.show('Your have not verified your email register again',context,gravity: Toast.TOP,duration: Toast.LENGTH_LONG);
            firestoreInstance.collection("userInfo").doc(firebaseUser.uid).delete().then((_) => print('deleted successfully!!'));
            firebaseUser.delete();
          }
          print("you are verified: $isVerified");

        });
      } on FirebaseAuthException catch(error){
        Toast.show(error.message,context,gravity: Toast.TOP,duration: Toast.LENGTH_LONG);
      }
      print('user is: ${firebaseUser.uid}');



    }
  }
  forgotPassword()async{
    if(_email == null){
      Toast.show('Invalid Input',context,gravity: Toast.TOP,duration: Toast.LENGTH_SHORT);
    }else{
      try{
        await auth.sendPasswordResetEmail(email: _email);
        setState(() {

          _isVisible =true;
          _isVisibleForgot =false;
        });
      } on FirebaseAuthException catch(error){
        Toast.show(error.message,context,gravity: Toast.TOP,duration: Toast.LENGTH_SHORT);
      }
    }
  }
  signUp(String _email,String _password) async{
    if(_email == null || _password == null ||_name == null ||number ==null || _reEnterPassword == null){
      Toast.show('Fill All Entries',context,gravity: Toast.TOP,duration: Toast.LENGTH_SHORT);
    }else{
      if( _password != _reEnterPassword){
        Toast.show('Password Does Not Match',context,gravity: Toast.TOP,duration: Toast.LENGTH_SHORT);
      }else{
        try{
          await auth.createUserWithEmailAndPassword(email: _email, password: _password).then(
                  (value) async{Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => VerifyScreen()));
              User user = auth.currentUser;
              await DatabaseService(uid: user.uid).updateUserData(_name, _email,_password,number,image,isVerified,subjects,topics,time,post,days,mentOrstud);
                  });

        } on FirebaseAuthException catch(error){
          Toast.show(error.message,context,gravity: Toast.TOP,duration: Toast.LENGTH_SHORT);
        }
      }
    }
  }

}