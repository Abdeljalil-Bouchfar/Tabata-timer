import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer/constant/const.dart';
import 'package:workout_timer/function/state_manege.dart';

class TimelineList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _state = Provider.of<StateService>(context);
    _state.getDoneCycle();

    duration(int index, {bool inWork = false, bool inRest = false}) {
      String work = (Duration(
              seconds: (int.parse(_state.workList[_state.doneCycle[index]]))))
          .toString();
      String rest = (Duration(
              seconds: (int.parse(_state.restList[_state.doneCycle[index]]))))
          .toString();
      if (inWork) return work;
      if (inRest)
        return rest;
      else {
        int total = int.parse(_state.workList[_state.doneCycle[index]]) +
            int.parse(_state.restList[_state.doneCycle[index]]);
        String totalAsS = (Duration(
                seconds: (total *
                        (int.parse(_state.cycleList[_state.doneCycle[index]])) -
                    int.parse(_state.restList[_state.doneCycle[index]]))))
            .toString();
        return totalAsS;
      }
    }

    return FutureBuilder(
      future: _state.getDoneCycle(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Container();
        else
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _state.doneCycle.length - 1,
            itemBuilder: (context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(2),
                      child: Divider(
                        color: Color(0xFF00f260),
                        thickness: 2,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${_state.dateList[_state.doneCycle[index + 1]]}',
                          style: KFirstStyle,
                        ),
                        Text(
                          'Cycle : ${_state.cycleList[_state.doneCycle[index + 1]]}',
                          style: KFirstStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Work : ${duration(index + 1, inWork: true).split('.').first.substring(2)}',
                          style: KFirstStyle,
                        ),
                        Text(
                          'Rest : ${duration(index + 1, inRest: true).split('.').first.substring(2)}',
                          style: KFirstStyle,
                        ),
                        Text(
                          'Total : ${duration(index + 1).split('.').first.substring(2)}',
                          style: KFirstStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
      },
    );
  }
}
