import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer/constant/const.dart';
import 'package:workout_timer/function/state_manege.dart';

class Button extends StatefulWidget {
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    var _timer = Provider.of<StateService>(context);
    timerStatus() {
      if (_timer.currentStep == 'g') return null;
      if (_timer.isRunning) return _timer.stop();
      if (!_timer.isRunning) return _timer.start();
    }

    resetButton() {
      _timer.resetAll();
      return _timer.reset();
    }

    // ignore: missing_return
    buttonText() {
      if (_timer.currentStep == 'g') return 'READY  ';
      if (_timer.isRunning) return 'PAUSE  ';
      if (!_timer.isRunning) return 'START  ';
    }

    // ignore: missing_return
    buttonIcon() {
      if (_timer.currentStep == 'g') return 'hourglass.png';
      if (_timer.isRunning) return 'pause.png';
      if (!_timer.isRunning) return 'start.png';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            timerStatus();
          },
          child: Container(
            height: 55,
            width: 145,
            decoration: BoxDecoration(
              color: Color(0xFF00f260),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Image(
                      image: AssetImage('images/${buttonIcon()}'),
                      height: 30,
                    ),
                  ),
                ),
                Text(
                  buttonText(),
                  style: KButtonStyle,
                ),
              ],
            ),
          ),
        ),
        FlatButton(
          onPressed: resetButton,
          child: Container(
            height: 55,
            width: 145,
            decoration: BoxDecoration(
              color: Color(0xFF00f260),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Image(
                      image: AssetImage('images/reset.png'),
                      height: 30,
                      color: Colors.red,
                    ),
                  ),
                ),
                Text(
                  'RESET  ',
                  style: KButtonStyle,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
