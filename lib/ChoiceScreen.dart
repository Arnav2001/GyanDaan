import 'package:flutter/material.dart';
import 'package:hackathon_project/formDetails.dart';
import 'package:hackathon_project/mentorForm.dart';
import 'package:hackathon_project/studentForm.dart';

class ChoiceScreen extends StatefulWidget {
  const ChoiceScreen({Key key}) : super(key: key);

  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> with SingleTickerProviderStateMixin, FormDetails{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image(image: AssetImage("assets/iconBg.png")),
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(_w / 17, _w / 20, 0, _w / 10),
              child: ListView(
                physics:
                const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Text(
                    'Choose...',
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.black.withOpacity(.6),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: _w / 35),
                  Text(
                    'Choose Your Post',
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black.withOpacity(.5),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: _w/1.5,
                  ),
                  GestureDetector(
                    onTap: (){
                      Details({},[], context,"post","Student",[]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => studentForm()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: _w/20,right: _w/10),
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 20,
                                offset: Offset(5, 10),
                              ),
                            ],
                            color: Colors.indigo,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.account_circle_outlined,color: Colors.white,size: 30,),
                            SizedBox(width: 20,),
                            Text("Student",style: TextStyle(
                                color: Colors.white,
                              fontSize: 25
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height/50,
                  ),
                  GestureDetector(
                    onTap: (){
                      Details({},[], context,"post","Mentor",[]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => mentorForm()),
                      );
                      },
                    child: Padding(
                      padding: EdgeInsets.only(left: _w/20,right: _w/10),
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 20,
                                offset: Offset(5, 10),
                              ),
                            ],
                            color: Colors.indigo,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.account_circle_outlined,color: Colors.white,size: 30,),
                            SizedBox(width: 20,),
                            Text("Mentor",style: TextStyle(
                                color: Colors.white,
                                fontSize: 25
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
