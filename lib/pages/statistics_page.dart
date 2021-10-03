import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/statistics_button.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var text = "Кнопка";
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        //  SizedBox(height: 24),
        Container(
          margin: const EdgeInsets.only(left: 16, top: 24, right: 16),
          child: Text('Statistics',
              style: TextStyle(
                  fontSize: 24,
                  color: FightClubColors.darkGreyText,
                  fontWeight: FontWeight.normal)),
        ),
        Expanded(child: SizedBox(height: double.infinity)),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: SecondaryActionButton(
              onTap: () => {Navigator.of(context).pop()}, text: 'Back'),
        ),
        //  SizedBox     SizedBox(height: 16)
      ]),
    ));
  }
}
