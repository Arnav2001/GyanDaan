import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class FormDetails{
  Details(Map mapx,List listx,BuildContext context,String name,String post,List days) async {
    final firestoreInstance = FirebaseFirestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;

    if(name == "post"){
      firestoreInstance.collection("userInfo")
          .doc(firebaseUser.uid)
          .update({"post": post}).then((_) => print("Success"));
    }else
    if(name == "subjects") {
      firestoreInstance.collection("userInfo")
          .doc(firebaseUser.uid)
          .update({"subjects": listx}).then((_) => print("Success"));
    }else if(name =="topics"){
      firestoreInstance.collection("userInfo")
          .doc(firebaseUser.uid)
          .update({"topics": mapx}).then((_) => print("Success"));
    }else if(name =="days"){
      firestoreInstance.collection("userInfo")
          .doc(firebaseUser.uid)
          .update({"days": days}).then((_) => print("Success"));
    }else{

        firestoreInstance.collection("userInfo")
            .doc(firebaseUser.uid)
            .update({"time": name}).then((_) => print("Success"));



    }

  }
}

