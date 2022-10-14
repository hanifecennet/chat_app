import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/calls.dart';
import 'package:chat_app/screens/chats.dart';
import 'package:chat_app/screens/people.dart';
import 'package:chat_app/screens/settings.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  var screens = [Chats(), Calls(), People(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
        resizeToAvoidBottomInset: true,
      tabBar: CupertinoTabBar(
      items: [
        BottomNavigationBarItem( //alt menu
          label: "Sohbetler",
          icon: Icon(CupertinoIcons.chat_bubble_2_fill),
        ),
        BottomNavigationBarItem(
          label: "Aramalar",
          icon: Icon(CupertinoIcons.phone),
        ),
        BottomNavigationBarItem(
          label: "Kişiler",
          icon: Icon(CupertinoIcons.person_alt_circle),
        ),
        BottomNavigationBarItem(
          label: "Ayarlar",
          icon: Icon(CupertinoIcons.settings_solid),
        ),
      ],
    ), 
    tabBuilder: (BuildContext context, int index) {
      return screens[index];
      },),);
  }
}