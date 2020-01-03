import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer/constant/const.dart';
import 'package:workout_timer/function/state_manege.dart';
import 'package:workout_timer/screen/timer_screen_LandscapeMode.dart';
import 'package:workout_timer/screen/timer_screen_PortraitMode.dart';
import 'package:wakelock/wakelock.dart';

class TimerUI extends StatefulWidget {
  @override
  _TimerUIState createState() => _TimerUIState();
}

class _TimerUIState extends State<TimerUI> with WidgetsBindingObserver {
  AppLifecycleState _appLifecycleState;
  bool isDone = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setState(() {
      _appLifecycleState = state;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Wakelock.disable();
    super.dispose();
  }

  @override
  void deactivate() {
    WidgetsBinding.instance.removeObserver(this);
    super.deactivate();
  }

  var _or;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Wakelock.enable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _state = Provider.of<StateService>(context);

    //pause when the app goes to the background and build function is done
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('i run fuck ...');
      print(_appLifecycleState);
      if (_appLifecycleState == AppLifecycleState.paused ||
          _appLifecycleState == AppLifecycleState.inactive) {
        if (_state.currentStep == 'g') {
          _state.resetAll();
        } else
          _state.stop();
      }
    });

    //to read data work and rest and total cycle
    _state.readData();

    //get the current theme
    Color _color = ThemeColor[_state.currentTheme];

    return Scaffold(
      backgroundColor: _color,
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? PortraitMode()
                : LandscapeMode();
          },
        ),
      ),
    );
  }
}
