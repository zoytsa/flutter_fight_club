import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/pages/main_page.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:google_fonts/google_fonts.dart';

import 'resources/fight_club_colors.dart';
import 'resources/fight_club_icons.dart';
import 'resources/fight_club_images.dart';
//import 'dart:ui';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.pressStart2pTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'Flutter Demo',
      home: MainPage(),
    );
  }
}
