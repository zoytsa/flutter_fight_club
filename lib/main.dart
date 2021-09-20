//import 'dart:html';

//import 'dart:ffi';
//import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  //print('hello');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(213, 222, 240, 1),
        body: Column(children: [
          SizedBox(height: 36),
          rowWithData(text1: 'You', text2: 'Enemy'),
          SizedBox(height: 7),
          rowWithData(text1: '1', text2: '1'),
          rowWithData(text1: '1', text2: '1'),
          rowWithData(text1: '1', text2: '1'),
          rowWithData(text1: '1', text2: '1'),
          rowWithData(text1: '1', text2: '1'),
          Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //  SizedBox(height: 40),
                    Text('Defend'.toUpperCase()),
                    SizedBox(height: 13),
                    BodyPartButton(
                        bodyPart: BodyPart.head,
                        selected: defendingBodyPart == BodyPart.head,
                        bodyPartSetter: _selectDefendingBodyPart),
                    SizedBox(height: 14),
                    BodyPartButton(
                        bodyPart: BodyPart.torso,
                        selected: defendingBodyPart == BodyPart.torso,
                        bodyPartSetter: _selectDefendingBodyPart),
                    //    SizedBox(height: 14),
                    //   SizedBox(height: 40),
                    SizedBox(height: 14),
                    BodyPartButton(
                        bodyPart: BodyPart.legs,
                        selected: defendingBodyPart == BodyPart.legs,
                        bodyPartSetter: _selectDefendingBodyPart),
                    //    SizedBox(height: 14),
                    //   SizedBox(height: 40),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    //      SizedBox(height: 40),
                    Text('Attack'.toUpperCase()),
                    SizedBox(height: 13),
                    BodyPartButton(
                        bodyPart: BodyPart.head,
                        selected: attackingBodyPart == BodyPart.head,
                        bodyPartSetter: _selectAttackingBodyPart),
                    SizedBox(height: 14),
                    BodyPartButton(
                        bodyPart: BodyPart.torso,
                        selected: attackingBodyPart == BodyPart.torso,
                        bodyPartSetter: _selectAttackingBodyPart),
                    //    SizedBox(height: 14),
                    //   SizedBox(height: 40),
                    SizedBox(height: 14),
                    BodyPartButton(
                        bodyPart: BodyPart.legs,
                        selected: attackingBodyPart == BodyPart.legs,
                        bodyPartSetter: _selectAttackingBodyPart),
                    //    SizedBox(height: 14),
                    //   SizedBox(height: 40),
                  ],
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: goButton(
                  readyToStart:
                      defendingBodyPart != null && attackingBodyPart != null,
                  resetSelection: _resetSelection,
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
          SizedBox(height: 40)
        ]));
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    // print('defend ${value.name}');
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingBodyPart(final BodyPart value) {
    // print('attack ${value.name}');
    setState(() {
      attackingBodyPart = value;
    });
  }

  void _resetSelection() {
    if (defendingBodyPart != null && attackingBodyPart != null) {
      setState(() {
        defendingBodyPart = null;
        attackingBodyPart = null;
      });
    }
  }
}

class rowWithData extends StatelessWidget {
  final String text1;
  final String text2;

  const rowWithData({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(//mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        SizedBox(width: 16),
        Expanded(child: Center(child: Text(text1))),
        SizedBox(width: 12),
        Expanded(child: Center(child: Text(text2))),
        SizedBox(width: 16),
      ]),
    );
  }
}

class goButton extends StatelessWidget {
  final bool readyToStart;

  final VoidCallback resetSelection;
  goButton({Key? key, required this.readyToStart, required this.resetSelection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => resetSelection(),
      child: SizedBox(
          height: 40,
          width: 40,
          child: ColoredBox(
            color: readyToStart
                ? Color.fromRGBO(0, 0, 0, 0.87)
                : Color.fromRGBO(0, 0, 0, 0.38),
            child: Center(
              child: Text(
                'Go'.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          )),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._('Head');
  static const torso = BodyPart._('Torso');
  static const legs = BodyPart._('Legs');

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    Key? key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
          height: 40,
          child: ColoredBox(
            color: selected ? Color.fromRGBO(28, 121, 206, 1) : Colors.black38,
            child: Center(
              child: Text(bodyPart.name.toUpperCase()),
            ),
          )),
    );
  }
}
