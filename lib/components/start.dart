import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  const Start({Key? key, this.onPressed}) : super(key: key);
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.right_chevron,
            color: CupertinoColors.white.withOpacity(0.7),
          ),
          Text(
            "Hadi Başla",
            style: TextStyle(
              color: CupertinoColors.white.withOpacity(0.7),
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}