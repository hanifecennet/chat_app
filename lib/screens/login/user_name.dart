import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';

class UserName extends StatefulWidget {
  UserName({Key? key}) : super(key: key);

  @override
  State<UserName> createState() => _UserNameState();
  
}

class _UserNameState extends State<UserName> {
  var _text = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  void createUserInFirestore(){
    users
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .limit(1) //sahip olunan doküman sayisi
      .get() //dokümani getirir
      .then(
        (QuerySnapshot querySnapshot){
          if(querySnapshot.docs.isEmpty) //doc bossa kisi ekle
          {
            users.add({
              'name':_text.text,
              'phone': FirebaseAuth.instance.currentUser!.phoneNumber,
              'status':'Available',
              'uid': FirebaseAuth.instance.currentUser?.uid
            });
          }
      },
      ).catchError((error){});
  }
    
  @override
  void initState() {
    _text.text = (FirebaseAuth.instance.currentUser?.displayName != null
        ? FirebaseAuth.instance.currentUser?.displayName
        : '')!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         /* CupertinoButton(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Observer(
                  builder: (BuildContext context) => CircleAvatar(
                    radius: 60,
                    child: usersState.imagefile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              usersState.imagefile!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50)),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
              ),
              //onPressed: () => usersState.takeImageFromCamera()),
          ),*/
          Text("İsmninizi giriniz"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 55),
            child: CupertinoTextField(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
              maxLength: 15,
              controller: _text,
              keyboardType: TextInputType.name,
              autofillHints: <String>[AutofillHints.name],
            ),
          ),
          CupertinoButton.filled(
              child: Text("Devam"),
              onPressed: () {
                FirebaseAuth.instance.currentUser
                    ?.updateDisplayName(_text.text);
                    //?.updateProfile(displayName: _text.text);

                createUserInFirestore();
               // usersState.createOrUpdateUserInFirestore(_text.text);

                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => HomePage()));
              })
        ],
      ),
    );
  }
}
