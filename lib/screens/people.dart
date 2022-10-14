//import 'dart:js';

import 'package:chat_app/screens/login/chat_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class People extends StatelessWidget {
   People({Key? key}) : super(key: key);
   var currentUser = FirebaseAuth.instance.currentUser?.uid;

   void callChatDetailScreen(BuildContext context,String name, String uid){
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ChatDetail(
        friendUid: uid,
        friendName: name,
      ))
    );
   }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
      .collection("users")
      .where('uid', isNotEqualTo: currentUser)
      .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError) //hata varsa
        {
          return Center(child: Text("Yolunda gitmeyen bir şeyler var"),);
        }
        if(snapshot.connectionState == ConnectionState.waiting)
        { //baglanti kurulmasi beklenirken
          return Center(
            child: Text("Yükleniyor"),
          );
        }
        if(snapshot.hasData)
        {
          return CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text("Kişiler"),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  snapshot.data!.docs.map( //tum dokumanlardaki veriler okunur
                    (DocumentSnapshot document){ //map tum verileri icerir
                    Map<String, dynamic>? data = document.data()! as Map<String, dynamic>?;
                    return CupertinoListTile(
                      onTap: ()=> callChatDetailScreen(context, data?['name'], data?['uid']),
                      title: Text(data!['name']), //kisinin ismi cekilir
                      subtitle: Text(data['status']),
                    );
                  }).toList()
                ),),
                
            ],
          );
        }
        return Container();
      });
  }
}