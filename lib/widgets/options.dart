import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer/Database/database.dart';
import 'package:workout_timer/constant/const.dart';
import 'package:workout_timer/function/state_manege.dart';
import 'package:workout_timer/screen/timer_screen.dart';
import 'Tabataoption.dart';

class SetOptions extends StatefulWidget {
  final bool landscapeMode;

  SetOptions({this.landscapeMode = false});
  @override
  _SetOptionsState createState() => _SetOptionsState();
}

class _SetOptionsState extends State<SetOptions> {
  Database _database = Database();

  //create a list of Text (number ) for the CupertinoPicker widget
  List<Widget> widgitList(List number) {
    List<Widget> numbers = [];
    for (var index in number) {
      numbers.add(
        Text(
          '$index',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
    return numbers;
  }

  Duration _workMinute = Duration(minutes: 0);
  Duration _workSecond = Duration(seconds: 10);
  Duration _restMinute = Duration(minutes: 0);
  Duration _restSecond = Duration(seconds: 5);
  int cycle = 3;

  @override
  Widget build(BuildContext context) {
    bool _isLandscapeMode = widget.landscapeMode;
    var _state = Provider.of<StateService>(context);
    return Container(
      color: BottomSheetContainer[_state.currentTheme],
      child: Container(
        padding: EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          color: ThemeColor[_state.currentTheme],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          children: <Widget>[
            Tabataoption(
              text: 'WORK',
              timerPicker: Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: CupertinoPicker(
                          backgroundColor: Color(0xFF233360),
                          itemExtent: 32.0,
                          children: widgitList(Minute),
                          onSelectedItemChanged: (newvalue) {
                            setState(() {
                              _workMinute = Duration(minutes: newvalue);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:10),
                        child: Text(
                          'm',
                          style: KFirstStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          ':',
                          style: KFirstStyle.copyWith(fontSize: 50),
                        ),
                      ),
                      Flexible(
                        child: CupertinoPicker(
                          backgroundColor: Color(0xFF233360),
                          itemExtent: 32.0,
                          children: widgitList(secondInWork),
                          onSelectedItemChanged: (newvalue) {
                            setState(() {
                              _workSecond = Duration(seconds: newvalue + 10);
                            });
                          },
                        ),
                      ),
                      Text(
                        's',
                        style: KFirstStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Tabataoption(
              text: 'REST',
              timerPicker: Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: CupertinoPicker(
                          backgroundColor: Color(0xFF233360),
                          itemExtent: 32.0,
                          children: widgitList(Minute),
                          onSelectedItemChanged: (newvalue) {
                            setState(() {
                              _restMinute = Duration(minutes: newvalue);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          'm',
                          style: KFirstStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          ':',
                          style: KFirstStyle.copyWith(fontSize: 50),
                        ),
                      ),
                      Flexible(
                        child: CupertinoPicker(
                          backgroundColor: Color(0xFF233360),
                          itemExtent: 32.0,
                          children: widgitList(secondInRest),
                          onSelectedItemChanged: (newvalue) {
                            setState(
                              () {
                                _restSecond = Duration(seconds: newvalue + 5);
                              },
                            );
                          },
                        ),
                      ),
                      Text(
                        's',
                        style: KFirstStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Tabataoption(
              text: 'CYCLE',
              timerPicker: Flexible(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60, right: 60),
                    child: CupertinoPicker(
                      backgroundColor: Color(0xFF233360),
                      itemExtent: 32.0,
                      children: widgitList(cycleNum),
                      onSelectedItemChanged: (newvalue) {
                        setState(() {
                          cycle = newvalue + 3;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8, top: 4),
                  child: FlatButton(
                    onPressed: () {
                      _state.allCycle = cycle;
                      //write the new info in Database class
                      _database.cycle(write: true, lastcycle: cycle.toString());
                      _database.work(
                          write: true,
                          lastwork: (_workSecond.inSeconds + _workMinute.inSeconds)
                              .toString());
                      _database.rest(
                          write: true,
                          lastrest: (_restMinute.inSeconds + _restSecond.inSeconds)
                              .toString());
                      _database.date(
                          write: true,
                          lastdate: formatDate(DateTime.now(),
                              [D, ', ', M, ' ', dd, '  At ', HH, ':', nn]));
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return TimerUI();
                      },),);
                    },
                    child: Container(
                      height: 50,
                      width: 100,
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
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,color: Colors.red,size: 50,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
