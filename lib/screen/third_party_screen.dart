import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer/constant/const.dart';
import 'package:workout_timer/function/state_manege.dart';
import 'package:workout_timer/widgets/url_luncher.dart';

class ThirdParty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _state = Provider.of<StateService>(context);
    return Scaffold(
      backgroundColor: ThemeColor[_state.currentTheme],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, bottom: 25),
              child: Text(
                '   The third-party libraries and sources were employed during development of this application. We gratefully acknowledge authors for their excellent work made on these libraries and resources.\n\n    Third party software and resources has been used in the Tabata timer app:',
                style: KFirstStyle.copyWith(fontSize: 18),
              ),
            ),
            Url(
              text: '- State management : Provider package.',
              url: 'https://pub.dev/packages/provider',
            ),
            Url(
              text: '- Database : Shared preferences package.',
              url: 'https://pub.dev/packages/shared_preferences',
            ),
            Url(
              text: '- Audio player : Audioplayers package.',
              url: 'https://pub.dev/packages/audioplayers',
            ),
            Url(
              text: '- Date : Date format package.',
              url: 'https://pub.dev/packages/date_format',
            ),
            Url(
              text: '- Url : Url launcher package.',
              url: 'https://pub.dev/packages/url_launcher#-readme-tab-',
            ),
            Url(
              text: '- Fonts : Google fonts.',
              url: 'https://fonts.google.com/',
            ),
            Url(
              text: '- Audio : Google translate.',
              url: 'https://translate.google.com/',
            ),
            Url(
              text: '-Icon and Image from www.flaticon.com.',
              url: 'https://www.flaticon.com',
            ),
          ],
        ),
      ),
    );
  }
}
