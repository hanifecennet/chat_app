import 'dart:ui';

import 'package:chat_app/components/start.dart';
import 'package:chat_app/components/terms_and_conditions.dart';
import 'package:chat_app/components/bg_image_scaffold.dart';
import 'package:chat_app/screens/login/edit_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/components/logo.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BgImageScaffold(
      imagePath: 'images/bg.jpg',
      body: [
        Logo(
          height: 150.0, 
          radius: 50.0, 
          width: 150.0,
        ),
        Text(
          'Hoş Geldiniz',
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 60),
          ),
        Column(
          children: [
            Text(
              "Arkadaşlarınla mesajlaş",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7), 
                fontSize: 20
              ),
            ),
            Text(
              "Ailenle iletişim halinde kal",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7), 
                fontSize: 20
              ),
            ),
            Text(
              "Gör, Paylaş",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.7), 
                  fontSize: 20
                ),
              ),
            
          ],
        ),
        TermsAndConditions(onPressed: (){},),
        Start(onPressed: (){
          Navigator.push(
            context, CupertinoPageRoute(builder: (context) => EditNumber()));
        },),
      ],
    );
  }
}

