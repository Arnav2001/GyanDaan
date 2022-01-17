import 'package:flutter/material.dart';
class allList{

  List<Color> colorz =[
    Color(0xfff37736),
    Colors.lightGreen,
    Color(0xff63ace5),
    Color(0xffFF6D6D),
    Color(0xffffa700),
    Colors.purpleAccent.shade200,
    Colors.deepPurpleAccent.shade200,
    Color(0xfff37736),
    Colors.lightGreen,
    Color(0xff63ace5),
    Color(0xffFF6D6D),
    Color(0xffffa700),
    Colors.purpleAccent.shade200,
    Colors.deepPurpleAccent.shade200,
    Color(0xfff37736),
    Colors.lightGreen,
    Color(0xff63ace5),
    Color(0xffFF6D6D),
    Color(0xffffa700),
    Colors.purpleAccent.shade200,
    Colors.deepPurpleAccent.shade200,
    Color(0xfff37736),
    Colors.lightGreen,
    Color(0xff63ace5),
    Color(0xffFF6D6D),
    Color(0xffffa700),
    Colors.purpleAccent.shade200,
    Colors.deepPurpleAccent.shade200,
  ];
  //list of topics in particular subject
  List Maths = [
    "Number Systems",
    "Algebra",
    "Coordinate Geometry",
    "Geometry",
    "Trigonometry",
    "Statistics",
    "Probability",
  ];
  List Science = [
    "Chemical Substances",
    "World of Living",
    "Natural Phenomena",
    "Effects of Current",
    "Natural Resources",
  ];
  List Social_Science = [
    "India and Contemporary World - II",
    "Contemporary India - II",
    "Democratic Politics - II",
    "Understanding Economic Development",
  ];
  List French = [
    "Retrouvons nos amis",
    "Après le bac",
    "Chercher du travail",
    "Le plaisir de lire",
    "Les médias",
    "Chacun ses goûts",
    "En pleine forme",
    "L’environnement",
    "Métro, Boulot,Dodo",
    "Vive la République",
    "C’est bon le progrès",
    " Vers un monde interculturel",
  ];
  List English = [
    "Tenses",
    "Modals",
    "Subject - verb concord",
    "reported speech",
    "Commands and requests",
    "Statements",
    "Questions",
    "Determiner",
    "Use of Passive Voice",
    "Nouns",
    "Prepositions",
    ];

  Map<String,bool>CheckBoxValue = { };
  List<String> allTopics= new List();

//making map of topics and if student wants it
  mapFormation(){
    for(var x in Maths){
      CheckBoxValue.putIfAbsent(x, () => false);
      print(x);
      allTopics.add(x);
    }

    for(var x in Science){
      CheckBoxValue.putIfAbsent(x, () => false);
      allTopics.add(x);
    }
    for(var x in Social_Science){
      CheckBoxValue.putIfAbsent(x, () => false);
      allTopics.add(x);
    }
    for(var x in French){
      CheckBoxValue.putIfAbsent(x, () => false);
      allTopics.add(x);
    }
    for(var x in English){
      CheckBoxValue.putIfAbsent(x, () => false);
      allTopics.add(x);
    }
  }
}
