//loading screen when data is being retrieved from database


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackathon_project/MentorHome.dart';
import 'package:hackathon_project/homePage.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    retrievingData(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitWave(
              color: Colors.deepOrange.shade300,
              size: 50.0,
            ),
            SizedBox(height: 10,),
            Text('Loading', style: TextStyle(color: Colors.deepOrange.shade300),)
          ],
        ),
      ),
    );
  }

  retrievingData(BuildContext context){
    final firestoreInstance = FirebaseFirestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("userInfo").doc(firebaseUser.uid).get().then((value){

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => value.data()["post"] == "Student"?HomePage():MentorPage()));


    });
  }
}
