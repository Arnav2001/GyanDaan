import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:hackathon_project/loading.dart';
import 'package:toast/toast.dart';
class Connection {

  fun(BuildContext context)async{
    Map _topicMap;
    List _days;
    final firestoreInstance = FirebaseFirestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("userInfo").doc(firebaseUser.uid).get().then((value){
      _topicMap = value.data()["topics"];
      _days = value.data()["days"];
    });
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('userInfo');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List studentTopics= new List();
    List allMentors = new List();
    List<List<int>> topicMentors = List();
    List studentDays = new List();
    List<List<int>> dayMentors =  List();
    Map<String,List<String>> finalMentor={ };
    for(String x in _topicMap.keys){
      if(_topicMap[x]==true){
        studentTopics.add(x);
      }
    }
    //print('student topics........ $studentTopics');
    for(int i=0;i<allData.length;i++){
      if(allData[i]["post"]=="Mentor"){
      allMentors.add(i);}
    }
    //print('Mentor.......$allMentors');
    for(String x in studentTopics){
      List<int> temp = List();
      //print('topicMentorss......$x');
      for(int i in allMentors){

        //print('topicMentorss......$i');
        if(allData[i]["topics"][x] ==true){

          //print('topicMentorss......${allData[i]["topics"][x]}');
          temp.add(i);
          //topicMentors[ind].add(i);

        }
      }
      topicMentors.add(temp);

    }
    //print('topicMentorsssss......$topicMentors');
    for(int i=1;i<_days.length;i++){
      if(!_days[i]){
        studentDays.add(i);
      }
    }

   // print('studentDays......${studentDays}');

    dayMentors.add([-1]);
    for(int j=1;j<_days.length;j++){
      List<int> temp = List();
      for(int i in allMentors){
      if(!allData[i]["days"][j]){
        temp.add(i);
      }
      }
      if(temp.isEmpty){
        temp.add(-1);
      }
      dayMentors.add(temp);
    }
    //print('DayMentors........$dayMentors');

      for(int i=0;i<topicMentors.length;i++){

        List<String> nestedList =  List();
        for(int j in studentDays){
          List<int> temp = List();
          for(int k in dayMentors[j]){
            if(topicMentors[i].contains(k)){
              temp.add(k);
            }
          }
          if(temp.isEmpty){
            temp.add(-1);
          }
          final random = new Random();
          int index = random.nextInt(temp.length);
          nestedList.add(allData[temp[index]]["name"]);
        }

        finalMentor.putIfAbsent(studentTopics[i], () => nestedList);
      }

    print('Mentors............$finalMentor');
      if(finalMentor.isEmpty){
        Navigator.of(context).popUntil((route) => route.isFirst);
        Toast.show('Error Try again',context,gravity: Toast.TOP,duration: Toast.LENGTH_SHORT);
      }else{
      firestoreInstance.collection("userInfo")
        .doc(firebaseUser.uid)
        .update({"mentOrstud": finalMentor}).then((_) => {Navigator.of(context).popUntil((route) => route.isFirst),
          Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Loading()))});

      }
  }

}