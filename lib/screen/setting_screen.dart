import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer/Database/database.dart';
import 'package:workout_timer/constant/const.dart';
import 'package:workout_timer/function/state_manege.dart';
import 'package:workout_timer/screen/privacy_screen.dart';
import 'package:workout_timer/widgets/list_of_themes_color.dart';
import 'package:workout_timer/screen/third_party_screen.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Database _database = Database();

  bool _voiceState = true;
  bool _onChange = false;
  int _themeIndex = 0;
  bool _setState = false;

  @override
  Widget build(BuildContext context) {
    var _state = Provider.of<StateService>(context);
    _currentV() {
      if (_onChange)
        return _voiceState;
      else
        return _state.voiceState;
    }

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
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            ClipRRect(
              borderRadius: new BorderRadius.circular(10.0),
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
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '     Settings',
                style: KFirstStyle,
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          '  Voice assistant',
                          style: KFirstStyle,
                        ),
                      ),
                      Switch(
                        activeColor: mainColor,
                        inactiveThumbColor: Colors.white,
                        value: _currentV(),
                        onChanged: (value) {
                          _database.voiceState(write: true, voiceS: value);
                          setState(() {
                            _voiceState = value;
                            _onChange = true;
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '  Theme',
                              style: KFirstStyle,
                            ),
                            FlatButton(
                              onPressed: () {
                                _state.currentTheme = _themeIndex;
                                setState(() {});
                                _database.themes(
                                    write: true, themeIndex: _themeIndex);
                              },
                              child: Container(
                                height: 25,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Save',
                                    style: KButtonStyle.copyWith(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: !_setState
                                ? ThemeColor[_state.currentTheme]
                                : ThemeColor[_themeIndex],
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: ThemeColor.length,
                            itemBuilder: (context, int index) {
                              return Themes(
                                index: index,
                                radius: _state.currentTheme == index ? 50 : 30,
                                onPressed: () {
                                  setState(() {
                                    _themeIndex = index;
                                    _setState = true;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '  About',
                      style: KFirstStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '  Version',
                          style: KFirstStyle.copyWith(fontFamily: 'd5'),
                        ),
                        Text(
                          '  1.0.0',
                          style: KFirstStyle.copyWith(fontFamily: 'd5'),
                        ),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PrivacyPolicy();
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '  Privacy Policy',
                            style: KFirstStyle,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ThirdParty();
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '  Third-party',
                            style: KFirstStyle,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
