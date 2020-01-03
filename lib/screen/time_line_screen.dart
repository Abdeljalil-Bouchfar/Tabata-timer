import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer/Database/database.dart';
import 'package:workout_timer/constant/const.dart';
import 'package:workout_timer/function/state_manege.dart';
import 'package:workout_timer/widgets/time_line_isempty.dart';
import 'package:workout_timer/widgets/time_line_list.dart';

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  Database _database = Database();
  Widget currentWidget = TimelineList();

  @override
  Widget build(BuildContext context) {
    var _state = Provider.of<StateService>(context);
    _state.getDoneCycle();
    return Scaffold(
      backgroundColor: ThemeColor[_state.currentTheme],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding:  EdgeInsets.only(top: 8.0),
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
                    Text(
                      'Timeline',
                      style: KSecondStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _database.done(remove: true);
                        setState(() {
                          currentWidget = TimelineIsEmpty();
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _state.doneCycle.length <= 1 || _state.doneCycle.isEmpty
                ? TimelineIsEmpty()
                : currentWidget,
          ],
        ),
      ),
    );
  }
}
