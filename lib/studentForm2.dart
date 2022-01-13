import 'package:flutter/material.dart';
import 'package:hackathon_project/allList.dart';
import 'package:hackathon_project/formDetails.dart';
import 'dart:ui';
import 'package:hackathon_project/studentForm3.dart';
import 'package:toast/toast.dart';

class studentForm2 extends StatefulWidget {
  List _list;

  studentForm2(this._list);
  @override
  _studentForm2State createState() => _studentForm2State();
}
List _subject=["Maths","Science","Social Science","English","French"];
List SelectedTopic = [];
bool maths_topic_checker=false;
bool science_topic_checker=false;
bool social_science_topic_checker=false;
bool english_topic_checker=false;
bool french_topic_checker=false;
class _studentForm2State extends State<studentForm2>
    with SingleTickerProviderStateMixin,FormDetails,allList {

  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _animation2;
  @override
  void initState() {
    super.initState();
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
    mapFormation();
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
          children: [
            Opacity(
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
            Opacity(
              opacity: _animation.value,
              child: Transform.translate(
                offset:Offset(0, _animation2.value) ,
                child: GestureDetector(
                  onTap: (){
                    if(logic()){
                      Details(CheckBoxValue,null, context, "topics","",[]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => studentForm3()),
                      );
                    }else{
                      Toast.show('Select atleast 1 topic from every subject',context,gravity: Toast.TOP,duration: Toast.LENGTH_SHORT);
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
          ],
        ),
      ),

      backgroundColor: Colors.white,
      body:Stack(
        children: [
          ListView(
            shrinkWrap: true,
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
                      'Choose Your Topic Subject Wise',
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
              subjectChoice(context),

            ],
          ),
          // Blur the Status bar
          blurTheStatusBar(context),
        ],
      ),
    );
  }
  Widget homePageCard(Color color, String title,
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
                  width: _w,
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
                      controlAffinity: ListTileControlAffinity.leading,
                      checkColor: Colors.black,
                      activeColor: Colors.white,
                      value: CheckBoxValue[title],
                      onChanged: (value){
                        setState(() {
                          CheckBoxValue[title]=value;
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

  Widget subjectChoice(BuildContext context){
    var _w = MediaQuery.of(context).size.width;
    return Container(
      width: _w,
      child: ListView.builder(
        shrinkWrap: true,
       physics: NeverScrollableScrollPhysics(),
        itemCount: _subject.length,
          itemBuilder: (context, index){
          return widget._list[index] == true?
           Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: _w/10, bottom: _w/50),
                child: Text(_subject[index],style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _w/20

                ),),
              ),
              topicChoice(context,_subject[index])
            ],
          ): Container();
          }),
    );
  }
  Widget topicChoice(BuildContext context, String sub,){
    List listy=[];
    var _w = MediaQuery.of(context).size.width;
    if(sub == "Science"){
      listy = Science;
    }
    else if(sub == "Maths"){
      listy = Maths;
    }else if(sub == "Social Science"){
      listy = Social_Science;
    }else if(sub == "English"){
      listy = English;
    }else{
      listy = French;
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: _w/10, bottom: _w/50,),
      width: _w,
      child: ListView.builder(
        shrinkWrap: true,
        physics:NeverScrollableScrollPhysics(),
          itemCount: listy.length,
          itemBuilder: (context, index){
            return homePageCard(
              colorz[index],
              listy[index],
              context,
            );
          }),
    );

  }
  bool logic(){
    for(String i in CheckBoxValue.keys){
      if(CheckBoxValue[i]==true){
        if(Maths.contains(i)){
          maths_topic_checker=true;
        }else if(Science.contains(i)){
          science_topic_checker = true;
        }else if(Social_Science.contains(i)){
          social_science_topic_checker = true;
        }else if(English.contains(i)){
          english_topic_checker =true;
        }else if(French.contains(i)){
          french_topic_checker =true;
        }
      }
    }
    if(widget._list[0]==maths_topic_checker &&
    widget._list[1]==science_topic_checker &&
    widget._list[2]==social_science_topic_checker &&
    widget._list[3]== english_topic_checker &&
    widget._list[4]==french_topic_checker){
      return true;
  }else{
      return false;
    }
  }

}
