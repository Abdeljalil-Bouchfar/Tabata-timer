import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer/constant/const.dart';
import 'package:workout_timer/function/state_manege.dart';
import 'package:workout_timer/screen/timer_screen.dart';

Random random = Random();

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
    Timer(
      Duration(milliseconds: 1500),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => TimerUI(),
        ),
      ),
    );
  }

  int randomN = random.nextInt(ThemeColor.length);

  @override
  Widget build(BuildContext context) {
    var _state = Provider.of<StateService>(context);
    _state.getTheme();
    return Scaffold(
      backgroundColor: ThemeColor[randomN],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'images/logo.png',
                height: 100.0,
                width: 100.0,
              ),
            ),
            Text(
              'Tabata',
              style: KFirstStyle.copyWith(letterSpacing: 4),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'TIMER',
                style: KSecondStyle.copyWith(fontSize: 25, letterSpacing: 3.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
