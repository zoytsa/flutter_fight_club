import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_icons.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FightPage extends StatefulWidget {
  FightPage({Key? key}) : super(key: key);

  @override
  FightPageState createState() => FightPageState();
}

class FightPageState extends State<FightPage> {
  bool enemyLosesLife = false;
  bool youLoseLife = false;
  String resultText = '';
  static int maxLives = 5;
  int yourLives = 5;
  int enemysLives = 5;
  BodyPart whatEnemyDefends = BodyPart.random();
  BodyPart whatEnemyAttacks = BodyPart.random();
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: FightClubColors.background,
        body: SafeArea(
          child: Column(children: [
            FightersInfo(
              maxLivesCount: maxLives,
              enemysLivesCount: enemysLives,
              yourLivesCount: yourLives,
            ),
            //Expanded(child: SizedBox()),
            //ResultWidget(text: resultText),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 30.0, left: 16, right: 16),
                    child: SizedBox(
                        width: double.infinity,
                        child: ColoredBox(
                          color: FightClubColors.blueBackground,
                          child: Center(
                            child: Text(resultText,
                                style: TextStyle(
                                    color: FightClubColors.darkGreyText)),
                          ),
                        )))),
            ControlsWidget(
              selectAttackingBodyPart: _selectAttackingBodyPart,
              attackingBodyPart: attackingBodyPart,
              defendingBodyPart: defendingBodyPart,
              selectDefendingBodyPart: _selectDefendingBodyPart,
            ),
            SizedBox(height: 14),
            ActionButton(
              title: enemysLives == 0 || yourLives == 0 ? 'Back' : 'Go',
              readyToStart:
                  defendingBodyPart != null && attackingBodyPart != null ||
                      enemysLives == 0 ||
                      yourLives == 0,
              onGoButtonClicked: _onGoButtonClicked,
            ),
            SizedBox(height: 16)
          ]),
        ));
  }

  String _calculateCenterText(
      final bool youLoseLife, final bool enemyLosesLife) {
    var result = '';

    if (yourLives == 0 && enemysLives == 0)
      return 'Draw';
    else if (yourLives == 0 && enemysLives > 0)
      return 'You lost';
    else if (yourLives > 0 && enemysLives == 0)
      return 'You win';
    else if (enemyLosesLife && youLoseLife)
      return 'You hit enemy\'s ${attackingBodyPart!.name.toLowerCase()}.\nEnemy hit your ${whatEnemyAttacks.name.toLowerCase()}.';
    else if (enemyLosesLife && !youLoseLife)
      return 'You hit enemy\'s ${attackingBodyPart!.name.toLowerCase()}.\nEnemy\'s attack was blocked.';
    else if (!enemyLosesLife && !youLoseLife)
      return 'Your attack was blocked.\nEnemy\'s attack was blocked.';
    else if (!enemyLosesLife && youLoseLife)
      return 'Your attack was blocked.\nEnemy hit your ${whatEnemyAttacks.name.toLowerCase()}.';
    return result;
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    if (enemysLives == 0 || yourLives == 0) {
      return;
    }
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingBodyPart(final BodyPart value) {
    if (enemysLives == 0 || yourLives == 0) {
      return;
    }
    setState(() {
      attackingBodyPart = value;
    });
  }

  void _onGoButtonClicked() {
    if (enemysLives == 0 || yourLives == 0) {
      Navigator.of(context).pop();
      // setState(() {
      //   enemysLives = maxLives;
      //   yourLives = maxLives;
      //   resultText = '';
      // }
      //);
    } else {
      if (defendingBodyPart != null && attackingBodyPart != null) {
        setState(() {
          enemyLosesLife = attackingBodyPart != whatEnemyDefends;
          youLoseLife = defendingBodyPart != whatEnemyAttacks;

          if (enemyLosesLife) --enemysLives;
          if (youLoseLife) --yourLives;

          final FightResult? fightResult =
              FightResult.calculateResult(yourLives, enemysLives);

          //  print('save0 $fightResult');
          if (fightResult != null) {
            // print('save1 ${fightResult!.result}');
            SharedPreferences.getInstance().then((sharedPreferences) => {
                  sharedPreferences.setString(
                      'last_fight_result', fightResult.result)
                });
          }

          resultText = _calculateCenterText(youLoseLife, enemyLosesLife);
          defendingBodyPart = null;
          attackingBodyPart = null;
          enemyLosesLife = false;
          youLoseLife = false;
          whatEnemyDefends = BodyPart.random();
          whatEnemyAttacks = BodyPart.random();
        });
      }
    }
  }
}

class LivesWidget extends StatelessWidget {
  final int overallLivesCount;
  final int currentLivesCount;

  const LivesWidget(
      {Key? key,
      required this.currentLivesCount,
      required this.overallLivesCount})
      : assert(overallLivesCount > 0),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(overallLivesCount, (index) {
          if (index < currentLivesCount) {
            //return Text('1');
            return Padding(
              padding: EdgeInsets.only(top: index > 0 ? 4 : 0),
              child:
                  Image.asset(FightClubIcons.heartFull, width: 18, height: 18),
            );
          } else
            return Padding(
              padding: EdgeInsets.only(top: index > 0 ? 4 : 0),
              child:
                  Image.asset(FightClubIcons.heartEmpty, width: 18, height: 18),
            );
        }));
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLivesCount;
  final int yourLivesCount;
  final int enemysLivesCount;

  const FightersInfo({
    Key? key,
    required this.maxLivesCount,
    required this.yourLivesCount,
    required this.enemysLivesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      SizedBox(
        height: 160,
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(child: ColoredBox(color: FightClubColors.whiteBackground)),
          Expanded(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
              FightClubColors.whiteBackground,
              FightClubColors.blueBackground
            ]))),
          ),
          Expanded(child: ColoredBox(color: FightClubColors.blueBackground)),
        ]),
      ),
      SizedBox(
        height: 160,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch, //!!!3
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // RowWithData(text1: 'You', text2: 'Enemy'),

            Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LivesWidget(
                        currentLivesCount: yourLivesCount,
                        overallLivesCount: maxLivesCount),
                    Column(children: [
                      const SizedBox(height: 16),
                      Text('You',
                          style:
                              TextStyle(color: FightClubColors.darkGreyText)),
                      const SizedBox(height: 12),
                      SizedBox(
                          height: 92,
                          width: 92,
                          child: Image.asset(FightClubImages.youAvatar,
                              width: 92, height: 92))
                    ]),
                  ]),
            ),

            Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(children: [
                      const SizedBox(height: 16),
                      Text('Enemy',
                          style:
                              TextStyle(color: FightClubColors.darkGreyText)),
                      const SizedBox(height: 12),
                      SizedBox(
                          height: 92,
                          width: 92,
                          child: Image.asset(FightClubImages.enemyAvatar,
                              width: 92, height: 92))
                    ]),
                    LivesWidget(
                        currentLivesCount: enemysLivesCount,
                        overallLivesCount: maxLivesCount),
                  ]),
            ),

            // PlayerInfo(
            //   currentLivesCount: yourLivesCount,
            //   maxLivesCount: maxLivesCount,
            //   title: 'You',
            //   backgroundColor: FightClubColors.whiteBackground,
            //   imageAvatarPath: FightClubImages.youAvatar,
            // ),
            // PlayerInfo(
            //   currentLivesCount: enemysLivesCount,
            //   maxLivesCount: maxLivesCount,
            //   title: 'Enemy',
            //   backgroundColor: FightClubColors.blueBackground,
            //   imageAvatarPath: FightClubImages.enemyAvatar,
            // )
          ],
        ),
      ),
      SizedBox(
          height: 44,
          width: 44,
          child: DecoratedBox(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: FightClubColors.blueButton),
            child: Center(
              child: Text(
                'vs',
                style:
                    TextStyle(color: FightClubColors.whiteText1, fontSize: 16),
              ),
            ),
          )),
    ]);
  }
}

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({
    Key? key,
    required this.currentLivesCount,
    required this.maxLivesCount,
    required this.title,
    required this.backgroundColor,
    required this.imageAvatarPath,
  }) : super(key: key);

  final int currentLivesCount;
  final int maxLivesCount;
  final String title;
  final Color backgroundColor;
  final String imageAvatarPath;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ColoredBox(
        color: backgroundColor,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              title == 'You'
                  ? LivesWidget(
                      currentLivesCount: currentLivesCount,
                      overallLivesCount: maxLivesCount)
                  : Column(children: [
                      const SizedBox(height: 16),
                      Text(title,
                          style:
                              TextStyle(color: FightClubColors.darkGreyText)),
                      const SizedBox(height: 12),
                      SizedBox(
                          height: 92,
                          width: 92,
                          child: Image.asset(imageAvatarPath,
                              width: 92, height: 92))
                    ]),
              title == 'You'
                  ? Column(children: [
                      const SizedBox(height: 16),
                      Text(title,
                          style:
                              TextStyle(color: FightClubColors.darkGreyText)),
                      const SizedBox(height: 12),
                      SizedBox(
                          height: 92,
                          width: 92,
                          child: Image.asset(imageAvatarPath,
                              width: 92, height: 92))
                    ])
                  : LivesWidget(
                      currentLivesCount: currentLivesCount,
                      overallLivesCount: maxLivesCount),
            ]),
      ),
    );
  }
}

class ResultWidget extends StatelessWidget {
  final String text;
  const ResultWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.only(
                top: 30, bottom: 30.0, left: 20.0, right: 20),
            child: SizedBox(
                child: ColoredBox(
              color: FightClubColors.blueBackground,
              child: Center(
                child: Text(text,
                    style: TextStyle(color: FightClubColors.darkGreyText)),
              ),
            ))));
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;
  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;

  const ControlsWidget({
    Key? key,
    required this.defendingBodyPart,
    required this.selectDefendingBodyPart,
    required this.attackingBodyPart,
    required this.selectAttackingBodyPart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(width: 16),
        Expanded(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //  SizedBox(height: 40),
              Text('Defend'.toUpperCase(),
                  style: TextStyle(color: FightClubColors.darkGreyText)),
              SizedBox(height: 13),
              BodyPartButton(
                  bodyPart: BodyPart.head,
                  selected: defendingBodyPart == BodyPart.head,
                  bodyPartSetter: selectDefendingBodyPart),
              SizedBox(height: 14),
              BodyPartButton(
                  bodyPart: BodyPart.torso,
                  selected: defendingBodyPart == BodyPart.torso,
                  bodyPartSetter: selectDefendingBodyPart),
              //    SizedBox(height: 14),
              //   SizedBox(height: 40),
              SizedBox(height: 14),
              BodyPartButton(
                  bodyPart: BodyPart.legs,
                  selected: defendingBodyPart == BodyPart.legs,
                  bodyPartSetter: selectDefendingBodyPart),
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
              Text('Attack'.toUpperCase(),
                  style: TextStyle(color: FightClubColors.darkGreyText)),
              SizedBox(height: 13),
              BodyPartButton(
                  bodyPart: BodyPart.head,
                  selected: attackingBodyPart == BodyPart.head,
                  bodyPartSetter: selectAttackingBodyPart),
              SizedBox(height: 14),
              BodyPartButton(
                  bodyPart: BodyPart.torso,
                  selected: attackingBodyPart == BodyPart.torso,
                  bodyPartSetter: selectAttackingBodyPart),
              //    SizedBox(height: 14),
              //   SizedBox(height: 40),
              SizedBox(height: 14),
              BodyPartButton(
                  bodyPart: BodyPart.legs,
                  selected: attackingBodyPart == BodyPart.legs,
                  bodyPartSetter: selectAttackingBodyPart),
              //    SizedBox(height: 14),
              //   SizedBox(height: 40),
            ],
          ),
        ),
        SizedBox(width: 16),
      ],
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

  static const List<BodyPart> _bodyParts = [head, torso, legs];

  static BodyPart random() {
    int randomInt = Random().nextInt(_bodyParts.length);
    return _bodyParts[randomInt];
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
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: selected
                    ? FightClubColors.blueButton
                    //  : FightClubColors.greyButton,
                    : Colors.transparent,
                border: !selected
                    ? Border.all(color: FightClubColors.darkGreyText, width: 2)
                    : null),
            child: Center(
              child: Text(bodyPart.name.toUpperCase(),
                  style: TextStyle(
                      color: selected
                          ? FightClubColors.whiteText
                          : FightClubColors.darkGreyText)),
            ),
          )),
    );
  }
}
