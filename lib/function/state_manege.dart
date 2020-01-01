import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:workout_timer/Database/database.dart';
import 'package:workout_timer/constant/const.dart';

class StateService extends ChangeNotifier {
  //for timer
  Stopwatch _watch;
  Timer _timer;

  Duration get currentDuration => _currentDuration;
  Duration _currentDuration = Duration.zero;

  bool get isRunning => _timer != null;

  StateService() {
    _watch = Stopwatch();
  }

  //to read data
  Database _database = Database();
  List<String> workList = [];
  List<String> restList = [];
  List<String> cycleList = [];
  List<String> dateList = [];
  List<int> doneCycle = [];

  //to change status in screen and config the slider
  int work;
  int rest;
  String currentStep;
  bool voiceState = true;
  bool resetButton = false;
  int currentTheme = 0;

  //for the cycle in timer_screen
  int allCycle = 3;
  int currentCycle = 1;

  bool isInBackground = false;

  //read data
  readData() async {
    //for the steps
    currentStep = await _database.currentStep();

    //for the voice state
    voiceState = await _database.voiceState();

    workList = await _database.work(read: true);
    workList.removeWhere((value) => value == null);
    work = int.parse(workList.last);

    restList = await _database.rest(read: true);
    restList.removeWhere((value) => value == null);
    rest = int.parse(restList.last);

    cycleList = await _database.cycle(read: true);
    cycleList.removeWhere((value) => value == null);
    allCycle = int.parse(cycleList.last);

    dateList = await _database.date(read: true);
    dateList.removeWhere((value) => value == null);
    return 'done';
  }

  //For completed cycles from local storage
  getDoneCycle() async {
    List doneCycleAsString = await _database.done(read: true);
    doneCycleAsString.removeWhere((value) => value == null);
    doneCycle.clear();
    for (String i in doneCycleAsString) {
      doneCycle.add(int.parse(i));
    }
    return 'Done';
  }

  //check and update the theme
  getTheme() async {
    currentTheme = await _database.themes() ?? 0;
  }

  //check and update the cycle
  currentCycles() async {
    currentCycle = await _database.currentCycle();
  }

  //check and update the status
  currentStatus() {
    if (currentStep == 'p') return 'Prepare';
    if (currentStep == 'w') return 'Work';
    if (currentStep == 'r') return 'Rest';
    if (currentStep == 'g') return 'Get ready';
    if (currentStep == 'd') return 'Prepare';
  }

  //when user click reset button to reset all to the first status
  resetAll() async {
    currentStep = 'p';
    resetButton = true;
    currentCycle = 1;
    control.stop();
    await _database.currentStep(write: true, currentS: 'p');
    await _database.currentCycle(write: true, currentC: 1);
    readData();
  }

  //this function Responsible for check and  change between work and rest and stop status
  void _onTick(Timer timer) async {
    //to play 'get ready' voice and change current step to 'w' that's main work step
    if (currentStep == 'g') {
      reset();
      if (voiceState) control = await player.play('get.mp3');
      resetButton = false;
      await Future.delayed(Duration(milliseconds: 7600), () async {
        await _database.currentStep(write: true, currentS: 'w');
        if (!resetButton) start();
      });
    }

    //voice assistant and change to rest step and add 1 to current cycle
    if (currentStep == 'w') {
      _database.currentCycle(write: true, currentC: currentCycle + 1);
      if (currentDuration.inSeconds == work - 3 &&
          currentCycle != allCycle &&
          voiceState) control = await player.play('13rest.mp3');
      if (currentDuration.inSeconds == work) {
        reset();
        if (currentCycle != allCycle)
          await _database.currentStep(write: true, currentS: 'r');
        if (currentCycle == allCycle)
          await _database.currentStep(write: true, currentS: 'd');
        start();
      }
    }
    //voice assistant and change to work step and update the cycle
    if (currentCycle != allCycle) {
      if (currentStep == 'r') {
        if (currentDuration.inSeconds == rest - 3 && voiceState)
          control = await player.play('13work.mp3');
        if (currentDuration.inSeconds == rest) {
          reset();
          await _database.currentStep(write: true, currentS: 'w');
          start();
          currentCycles();
        }
      }
    }
    //to play 'done' voice and change current step to 'D' that's main finish all
    //step and rest all data
    if (currentCycle == allCycle) {
      if (currentStep == 'd') {
        _database.currentCycle(write: true, currentC: 1);
        currentCycle = 1;
        reset();
        resetAll();
        _database.done(
            write: true, lastIndex: (cycleList.length - 1).toString());
        if (voiceState) control = await player.play('done.mp3');
      }
    }
    _currentDuration = _watch.elapsed;
    // notify all listening widgets
    notifyListeners();
  }

  //when the user presses the start start button to start timer
  void start() async {
    if (currentStep == 'p' && voiceState)
      await _database.currentStep(write: true, currentS: 'g');
    if (currentStep == 'p' && !voiceState)
      await _database.currentStep(write: true, currentS: 'w');
    if (control.state == AudioPlayerState.PAUSED) control.resume();
    if (_timer != null) return;
    _timer = Timer.periodic(Duration(seconds: 1), _onTick);
    _watch.start();
    notifyListeners();
  }

  //when the user presses the pause button to pause timer
  void stop() {
    if (control.state == AudioPlayerState.PLAYING) control.pause();
    _timer?.cancel();
    _timer = null;
    _watch.stop();
    _currentDuration = _watch.elapsed;
    notifyListeners();
    print('its me stop');
  }

  //when the user presses the reset button to reset timer
  void reset() {
    stop();
    _watch.reset();
    _currentDuration = Duration.zero;
    notifyListeners();
  }
}
