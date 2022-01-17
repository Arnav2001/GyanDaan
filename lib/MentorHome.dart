//Home Screen for Mentors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:hackathon_project/allList.dart';
import 'package:hackathon_project/profile.dart';


class MentorPage extends StatefulWidget {
  @override
  _MentorPageState createState() => _MentorPageState();
}
bool loading =true;
String _name=" ";
String _email=" ";
List _subjects=new List();
Map _topicMap={};


class _MentorPageState extends State<MentorPage>
    with SingleTickerProviderStateMixin,allList{
  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _animation2;
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "b8zRyiOEGiO9eN03Df4rSMOHwrw1");
  final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  final nameText = TextEditingController(text: "Plugin Test User");
  final emailText = TextEditingController(text: "fake@email.com");
  final iosAppBarRGBAColor =
  TextEditingController(text: "#0080FF80"); //transparent blue
  bool isAudioOnly = true;
  bool isAudioMuted = true;
  bool isVideoMuted = true;


  @override
  void initState() {

    super.initState();
    retrievingData();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
    expended=[false,false,false,false,false];


    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: -30, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    _controller.forward();
  }

  @override
  void dispose() {
    JitsiMeet.removeAllListeners();
    _controller.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark
    ));
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// ListView
          ListView(
            physics:
            BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(_w / 17, _w / 20, 0, _w / 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WELCOME',
                      style: TextStyle(
                        fontSize: 27,
                        color: Colors.black.withOpacity(.6),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: _w / 35),
                    Text(
                      _name,
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "Mentor",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              _subjects[0]?Padding(
                padding: EdgeInsets.only(left: _w/25,right: _w/25),
                child: homePageCard(
                  0,
                  Color(0xfff37736),
                  AssetImage('assets/math.png'),
                  'Maths',
                  context,
                ),
              ):Container(),
              _subjects[1]?
              Padding(
                padding: EdgeInsets.only(left: _w/25,right: _w/25),
                child: homePageCard(
                  1,
                  Colors.lightGreen,
                  AssetImage('assets/science.png'),
                  'Science',
                  context,
                ),
              ):Container(),
              _subjects[2]?
              Padding(
                padding: EdgeInsets.only(left: _w/25,right: _w/25),
                child: homePageCard(
                  2,
                  Color(0xff63ace5),
                  AssetImage('assets/social-science.png'),
                  'Social Science',
                  context,
                ),
              ):Container(),
              _subjects[3]?
              Padding(
                padding: EdgeInsets.only(left: _w/25,right: _w/25),
                child: homePageCard(
                  3,
                  Color(0xffFF6D6D),
                  AssetImage('assets/english.png'),
                  'English',
                  context,
                ),
              ):Container(),
              _subjects[4]?
              Padding(
                padding: EdgeInsets.only(left: _w/25,right: _w/25),
                child: homePageCard(
                  4,
                  Color(0xffffa700),
                  AssetImage('assets/french.png'),
                  'French',
                  context,
                ),
              ):Container(),
              SizedBox(height: _w / 20),
            ],
          ),

          /// SETTING ICON
          Padding(
            padding: EdgeInsets.fromLTRB(0, _w / 9.5, _w / 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Profile();
                        },
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(99)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                      child: Container(
                        height: _w / 8.5,
                        width: _w / 8.5,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.05),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: _w / 17,
                            color: Colors.black.withOpacity(.6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


          // Blur the Status bar
          blurTheStatusBar(context),
        ],
      ),
    );
  }List<bool> expended = List<bool>(5);
  Widget homePageCard(int ind,Color color, AssetImage icon, String title,
      BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: _w / 17),
      child: Opacity(
        opacity: _animation.value,
        child: Transform.translate(
          offset: Offset(0, _animation2.value),
          child: Container(
            padding: EdgeInsets.all(15),
            width: _w / 2.4,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xff040039).withOpacity(.15),
                  blurRadius: 99,
                ),
              ],
              border: Border.all(color: Colors.black,),
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),

              child: ExpansionTile(
                initiallyExpanded: false,
                onExpansionChanged: (value){
                  setState(() {
                    title == "Maths"?expended[0]=value:
                    title =="Science"?expended[1]=value:
                    title =="Social Science"?expended[2]=value:
                    title == "English"?expended[3]=value:
                    expended[4]=value;
                  });
                },
                trailing: expended[ind]?Icon(Icons.arrow_drop_up,color: Colors.black,):Icon(Icons.arrow_drop_down,color: Colors.black,),
                leading: Image(image: icon,width: 25,height: 25,),
                //collapsedBackgroundColor: color,
                title: Text(
                  title,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(.5),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: title == "Maths"?Maths.length:
                      title =="Science"?Science.length:
                      title =="Social Science"?Social_Science.length:
                      title == "English"?English.length:
                      French.length,
                      itemBuilder: (context,index){
                        return title == "Maths"?_topicMap[Maths[index]] == true?GestureDetector(
                          child: ListTile(
                            onTap: (){
                              _joinMeeting(Maths[index]);
                            },
                            trailing: Icon(Icons.videocam,size: 20,),
                            title: Text(Maths[index]),
                          ),
                        ):Container():
                        title =="Science"?_topicMap[Science[index]] == true?ListTile(title: Text(Science[index],),
                            onTap: (){
                              _joinMeeting(Science[index]);
                            },
                            trailing: Icon(Icons.videocam,size: 20,)):Container():
                        title =="Social Science"?_topicMap[Social_Science[index]] == true?ListTile(
                            onTap: (){
                              _joinMeeting(Social_Science[index]);
                            },
                            trailing: Icon(Icons.videocam,size: 20,),
                            title: Text(Social_Science[index])):Container():
                        title == "English"?_topicMap[English[index]] == true?ListTile(
                            onTap: (){
                              _joinMeeting(English[index]);
                            },
                            title: Text(English[index]),
                            trailing: Icon(Icons.videocam,size: 20,)):Container():
                        _topicMap[French[index]] == true?ListTile(
                            title: Text(French[index]),
                            trailing: Icon(Icons.videocam,size: 20,),
                            onTap: (){
                              _joinMeeting(French[index]);
                            }):Container()
                        ;
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget blurTheStatusBar(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
        child: Container(
          height: _w / 18,
          color: Colors.transparent,
        ),
      ),
    );
  }
  retrievingData(){
    final firestoreInstance = FirebaseFirestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("userInfo").doc(firebaseUser.uid).get().then((value){

      setState(() {
        _email = value.data()["email"];
        loading = false;
        _name = value.data()["name"];
        _subjects = value.data()["subjects"];
        _topicMap = value.data()["topics"];
      });
    });
  }
  _joinMeeting(String TopicName) async {
    String serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
    }
    var options = JitsiMeetingOptions(room: roomText.text)
      ..serverURL = serverUrl
      ..subject = TopicName
      ..userDisplayName = _name
      ..userEmail = _email
      ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": roomText.text,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": nameText.text}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}