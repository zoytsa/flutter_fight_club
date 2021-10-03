import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

class SecondaryActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  SecondaryActionButton({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(border: Border.all(width: 2)),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        height: 44,
        alignment: Alignment.center,
        //  color: FightClubColors.background,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: FightClubColors.darkGreyText),
        ),
      ),
    );
  }
}
