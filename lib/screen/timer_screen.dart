import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer/constant/const.dart';
import 'package:workout_timer/function/state_manege.dart';
import 'package:workout_timer/screen/setting_screen.dart';
import 'package:workout_timer/screen/time_line_screen.dart';
import 'package:workout_timer/widgets/menu_item.dart';
import 'package:workout_timer/widgets/options.dart';
import 'package:workout_timer/widgets/slider.dart';
import '../widgets/bottun.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 40,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //this is the left PopupMenu
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        height: 150,
                        value: 1,
                        child: MenuItem(
                          image: 'timer.png',
                          name: 'Timer',
                        ),
                      ),
                      PopupMenuItem(
                        height: 150,
                        value: 2,
                        child: MenuItem(
                          image: 'timers.png',
                          name: 'My timers',
                          onpress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Timeline();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      PopupMenuItem(
                        height: 150,
                        value: 3,
                        child: MenuItem(
                          image: 'time_settings.png',
                          name: 'Setting',
                          onpress: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Setting();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    icon: Icon(Icons.menu),
                    color: _color,
                  ),
                  // this is the text in top right screen
                  Row(
                    textBaseline: TextBaseline.ideographic,
                    children: <Widget>[
                      Text(
                        'CYCLE ',
                        style: KFirstStyle.copyWith(fontSize: 25),
                      ),
                      Text(
                        ' ${_state.currentCycle} ',
                        style: KFirstStyle.copyWith(
                          color: Colors.red,
                          fontSize: 35,
                        ),
                      ),
                      Text(
                        '/ ${_state.allCycle}  ',
                        style: KFirstStyle.copyWith(fontSize: 25),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //this is the text for the the status
            Text(
              _state.currentStatus() ?? 'Prepare',
              style: KSecondStyle.copyWith(fontSize: 60, color: Colors.white),
            ),
            //this is the centre circle
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Slidertime(),
            ),
            //these are the start and rest buttons
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              child: Button(),
            ),
            //this is the bottom button for work and rest and cycle option
            Column(
              children: <Widget>[
                Text(
                  'Options',
                  style: KFirstStyle,
                ),
                //option button to set work and rest and cycle
                FlatButton(
                  child: CircleAvatar(
                    backgroundColor: Color(0xff000000),
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      color: Color(0xFF00f260),
                      size: 40,
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SetOptions(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
