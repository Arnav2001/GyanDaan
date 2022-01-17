//student form screen 1


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project/formDetails.dart';
import 'dart:ui';

import 'package:hackathon_project/studentForm2.dart';
import 'package:toast/toast.dart';

class studentForm extends StatefulWidget {
  @override
  _studentFormState createState() => _studentFormState();
}

List<bool> _checked = List<bool>(5);

class _studentFormState extends State<studentForm>
    with SingleTickerProviderStateMixin,FormDetails {
  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _animation2;

  @override
  void initState() {
    super.initState();
    for(int i=0;i<5;i++){
      _checked[i]=false;
    }
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
    _controller.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: _w/10,right: _w/50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Opacity(
            opacity: _animation.value,
            child: Transform.translate(
              offset:Offset(0, _animation2.value) ,
              child: GestureDetector(
                onTap: (){
                  Details({},[], context,"subjects","",[]);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 100,
                  height: 50,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Icon(Icons.arrow_back,color: Colors.white,size: 20,),
                        SizedBox(width: 10,),
                        Text("Prev",style: TextStyle(
                          color: Colors.white,
                        ),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
            GestureDetector(
              child: Opacity(
                opacity: _animation.value,
                child: Transform.translate(
                  offset:Offset(0, _animation2.value) ,
                  child: GestureDetector(
                    onTap: (){
                      print("$_checked");
                      Details(null,_checked, context,"subjects","",[]);

                      if(_checked.contains(true)){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => studentForm2(_checked)),
                      );}else{
                        Toast.show('Select atleast 1 subject',context,gravity: Toast.TOP,duration: Toast.LENGTH_SHORT);
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 50,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Next",style: TextStyle(
                              color: Colors.white,
                            ),),
                            SizedBox(width: 10,),
                            Icon(Icons.arrow_forward,color: Colors.white,size: 20,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
                      'STUDENT FORM',
                      style: TextStyle(
                        fontSize: 27,
                        color: Colors.black.withOpacity(.6),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: _w / 35),
                    Text(
                      'Choose Your Subject',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
                  homePageCard(
                    0,
                    Color(0xfff37736),
                    'Maths',
                    context,
                  ),
                  homePageCard(
                    1,
                    Colors.lightGreen,
                    'Science',
                    context,
                  ),
                  homePageCard(
                    2,
                    Color(0xff63ace5),
                    'Social Science',
                    context,
                  ),
                  homePageCard(
                    3,
                    Color(0xffFF6D6D),
                    'English',
                    context,
                  ),
                  homePageCard(
                    4,
                    Color(0xffffa700),
                    'French',
                    context,
                  ),
                  SizedBox(height: _w / 20),

            ],
          ),
          // Blur the Status bar
          blurTheStatusBar(context),
        ],
      ),
    );
  }
//selecting subjects
  Widget homePageCard(int i,Color color, String title,
      BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: _w / 17),
      child: Opacity(
        opacity: _animation.value,
        child: Transform.translate(
          offset: Offset(0, _animation2.value),
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(right: _w/20,left: _w/20),
              child: Container(
                padding: EdgeInsets.all(15),
                height: _w / 4,
                width: _w / 2.4,
                decoration: BoxDecoration(
                  color: color,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff040039).withOpacity(.15),
                      blurRadius: 99,
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: CheckboxListTile(
                    title: Text(title),
                    //secondary: Icon(Icons.beach_access),
                    controlAffinity: ListTileControlAffinity.leading,
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                    value: _checked[i],
                    onChanged: (value){
                      setState(() {
                        _checked[i] = value;
                      });
                    },
                  ),
                )
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
}
