import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer/constant/const.dart';
import 'package:workout_timer/function/state_manege.dart';
import 'package:workout_timer/screen/setting_screen.dart';
import 'package:workout_timer/screen/time_line_screen.dart';
import 'package:workout_timer/widgets/bottun.dart';
import 'package:workout_timer/widgets/menu_item.dart';
import 'package:workout_timer/widgets/options.dart';
import 'package:workout_timer/widgets/slider.dart';

class LandscapeMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _state = Provider.of<StateService>(context);
    //get the current theme
    Color _color = ThemeColor[_state.currentTheme];
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
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
                                return TimeLine();
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
                //this is the text for the the status
                Text(
                  _state.currentStatus() ?? 'Prepare',
                  style:
                      KSecondStyle.copyWith(fontSize: 45, color: Colors.white),
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
        ),
        //this is the centre circle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 50, bottom: 50, top: 20),
              child: SliderTimer(
                landscapeMode: true,
              ),
            ),
            //these are the start and rest buttons
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: Button(
                    landscapeMode: true,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
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
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: SetOptions(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
