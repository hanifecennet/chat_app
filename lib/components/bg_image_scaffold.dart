import 'dart:ui';

import 'package:flutter/material.dart';

class BgImageScaffold extends StatelessWidget {
  const BgImageScaffold({Key? key, this.body, this.imagePath}) : super(key: key);
  final body;
  final imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),//arkaplan
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), //flu 
      child: Container(
        color: Colors.black.withOpacity(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: 
            body,
            
        ),
        ),
        ),
        
      );
    
  }
}