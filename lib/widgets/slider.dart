import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer/constant/const.dart';
import 'package:workout_timer/function/myPainter.dart';
import 'package:workout_timer/function/state_manege.dart';

class SliderTimer extends StatelessWidget {
  final bool landscapeMode;

  SliderTimer({this.landscapeMode = false});

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    var _state = Provider.of<StateService>(context);
    var stopwatch =
        _state.currentDuration.toString().split('.').first.split('0:').last;

    return Center(
      child: Container(
        height: landscapeMode ? 240 : 250.0,
        width: landscapeMode ? 240 : 250.0,
        child: CustomPaint(
          foregroundPainter: MyPainter(
            lineColor: ThemeColor[_state.currentTheme],
            completeColor: mainColor,
            completePercent: _state.currentDuration.inSeconds.toDouble() ?? 0,
            duration: _state.currentStep == 'w'
                ? _state.work ?? 10
                : _state.rest ?? 5,
            sectorcolor: Color(0xffff4050),
          ),
          child: Center(
            child: _state.currentStep == 'g'
                ? Container(
                    height: 90,
                    child: Image(
                      image: AssetImage('images/hourglass.png'),
                      color: Colors.white,
                    ),
                  )
                : Text(
                    stopwatch,
                    style: KFirstStyle.copyWith(fontSize: 100),
                  ),
          ),
        ),
      ),
    );
  }
}
