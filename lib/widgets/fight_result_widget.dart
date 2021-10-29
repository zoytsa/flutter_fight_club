import 'package:flutter/material.dart';

import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';

class FightResultWidget extends StatelessWidget {
  final FightResult? fightResult;

  const FightResultWidget({Key? key, required this.fightResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(children: [
        SizedBox(
          height: 140,
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
                  style: TextStyle(
                      color: FightClubColors.whiteText1, fontSize: 16),
                ),
              ),
            )),
      ]),
    ]);
  }
}
