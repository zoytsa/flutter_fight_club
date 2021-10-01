import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

class ActionButton extends StatelessWidget {
  final bool readyToStart;
  final String title;
  final VoidCallback onGoButtonClicked;
  ActionButton(
      {Key? key,
      required this.readyToStart,
      required this.onGoButtonClicked,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onGoButtonClicked(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        height: 40,
        alignment: Alignment.center,
        color: readyToStart
            ? FightClubColors.blackButton
            : FightClubColors.greyButton,
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: FightClubColors.whiteText),
        ),
      ),
    );

    return GestureDetector(
        onTap: () => onGoButtonClicked(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
              height: 40,
              // width: 40,
              child: ColoredBox(
                color: readyToStart
                    ? FightClubColors.blackButton
                    : FightClubColors.greyButton,
                child: Center(
                  child: Text(
                    title.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: FightClubColors.whiteText),
                  ),
                ),
              )),
        ));
  }
}
