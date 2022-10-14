import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key, this.height, this.radius, this.width}) : super(key: key);
  final width;
  final height;
  final radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.all(Radius.circular(radius)),

      
      ),
      child: 
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Image(image: AssetImage('images/chat.jpg'), fit: BoxFit.fitWidth,),
        ),
    );
  }
}