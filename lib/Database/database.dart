import 'package:date_format/date_format.dart';
import 'package:shared_preferences/shared_preferences.dart';

//in this app we will use shared preferences to save app data in local storage

class Database {
  //to save the cycle every time the user click done button in the options
  cycle(
      {bool read = false,
      String lastcycle,
      bool remove = false,
      bool write = false}) async {
    SharedPreferences cycle = await SharedPreferences.getInstance();
    List<String> allCycle = [];
    if (read) {
      String cycleList = cycle.getString('cycle') ?? '3';
      allCycle = cycleList.split(" ");
      return allCycle;
    }
    if (remove) {
      await cycle.remove('cycle');
    }
    if (write) {
      String cycleList = cycle.getString('cycle') ?? '3';
      String allCycle = '$cycleList $lastcycle';
      await cycle.setString('cycle', allCycle);
    }
  }

  //to save the work duration every time the user
  // click done button in the options
  work(
      {bool read = false,
      String lastwork,
      bool remove = false,
      bool write = false}) async {
    SharedPreferences work = await SharedPreferences.getInstance();
    List<String> allwork = [];
    if (read) {
      String workList = work.getString('work') ?? '10';
      allwork = workList.split(" ");
      return allwork;
    }
    if (remove) {
      await work.remove('work');
    }
    if (write) {
      String worklist = work.getString('work') ?? '10';
      String allwork = '$worklist $lastwork';
      await work.setString('work', allwork);
    }
  }

  //to save the rest duration every time the user
  // click done button in the options
  rest(
      {bool read = false,
      String lastrest,
      bool remove = false,
      bool write = false}) async {
    SharedPreferences rest = await SharedPreferences.getInstance();
    List<String> allrest = [];
    if (read) {
      String restList = rest.getString('rest') ?? '5';
      allrest = restList.split(" ");
      return allrest;
    }
    if (remove) {
      await rest.remove('rest');
    }
    if (write) {
      String restlist = rest.getString('rest') ?? '5';
      String allrest = '$restlist $lastrest';
      await rest.setString('rest', allrest);
    }
  }

  //to save the date every time the user click done button in the options
  date(
      {bool read = false,
      String lastdate,
      bool remove = false,
      bool write = false}) async {
    SharedPreferences date = await SharedPreferences.getInstance();
    List<String> alldate = [];
    if (read) {
      String datelist = date.getString('date') ??
          formatDate(DateTime.now(), [D, ', ', M, ' ', dd, '  At ', HH, ':', nn]);
      alldate = datelist.split("/");
      return alldate;
    }
    if (remove) {
      await date.remove('date');
    }
    if (write) {
      String datelist = date.getString('date') ??
          formatDate(DateTime.now(), [D, ', ', M, ' ', dd, '  At ', HH, ':', nn]);
      String alldate = '$datelist/$lastdate';
      await date.setString('date', alldate);
    }
  }

  //to save the done cycle to add to timer line im My timers in the menu
  done(
      {bool read = false,
      String lastIndex,
      bool remove = false,
      bool write = false}) async {
    SharedPreferences index = await SharedPreferences.getInstance();
    List<String> allIndex = [];
    if (read) {
      String indexList = index.getString('donecycle') ?? '1';
      allIndex = indexList.split(" ");
      return allIndex;
    }
    if (remove) await index.remove('donecycle');
    if (write) {
      String indexList = index.getString('donecycle') ?? '1';
      String allIndex = '$indexList $lastIndex';
      await index.setString('donecycle', allIndex);
    }
  }

  //to save the current cycle and update when rest done
  currentCycle({bool write = false, int currentC}) async {
    SharedPreferences cycle = await SharedPreferences.getInstance();
    if (write)
      await cycle.setInt('currentC', currentC ?? 1);
    else
      return cycle.getInt('currentC');
  }

  //to save the current step use the first character in in every step
  currentStep({bool write = false, String currentS}) async {
    SharedPreferences step = await SharedPreferences.getInstance();
    if (write)
      await step.setString('currentS', currentS ?? 'p');
    else
      return step.getString('currentS') ?? 'p';
  }

  //to save the setting of the user  related voice
  voiceState({bool write = false, bool voiceS}) async {
    SharedPreferences voice = await SharedPreferences.getInstance();
    if (write)
      await voice.setBool('voiceS', voiceS ?? true);
    else
      return voice.getBool('voiceS') ?? true;
  }

  //to save the setting of the user  related voice
  themes({bool write = false, int themeIndex}) async {
    SharedPreferences index = await SharedPreferences.getInstance();
    if (write)
      await index.setInt('themeIndex', themeIndex ?? 0);
    else
      return index.getInt('themeIndex') ?? 0;
  }
}
