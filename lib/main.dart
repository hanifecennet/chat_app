import 'dart:io';

import 'package:chat_app/screens/login/edit_number.dart';
import 'package:chat_app/screens/login/select_country.dart';
import 'package:chat_app/screens/login/verify_number.dart';
import 'package:chat_app/screens/login/welcome.dart';
import 'package:chat_app/screens/calls.dart';
import 'package:chat_app/screens/chats.dart';
import 'package:chat_app/screens/home_page.dart';
import 'package:chat_app/screens/people.dart';
import 'package:chat_app/screens/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const bool USE_EMULATOR = true;
Future main() async {

  WidgetsFlutterBinding.ensureInitialized(); //baslat komutunun calismasi icin
  await Firebase.initializeApp(); //firebase i baslatma
  if(USE_EMULATOR)
  {
    _connectToFirebaseEmulator();
  }
  runApp(const MyApp());
}

Future _connectToFirebaseEmulator() async {
  final fireStorePort = "8080";
  final authPort = "9099";
  final localHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  FirebaseFirestore.instance.settings = Settings(
    host: "$localHost:$fireStorePort",
    sslEnabled: false,
    persistenceEnabled: false
  );

  await FirebaseAuth.instance.useEmulator("http://$localHost:$authPort");












  
}
class MyApp extends StatelessWidget 
{
  const MyApp({Key? key}) : super(key: key);
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) 
  {
    return CupertinoApp(
      home: Welcome(), 
      theme: CupertinoThemeData(
        brightness: Brightness.light, 
        primaryColor: Color.fromARGB(255, 156, 8, 193),
      ), 
    );
  }
}


