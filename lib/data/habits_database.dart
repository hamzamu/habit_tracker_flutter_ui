import 'package:habit_tracker_ui_hive/data/datetime.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Habits_Database");

class HabitsDatabase {
  List HabitsList = [];
  Map<DateTime, int> heatMapDataSet = {};

  // create init data

  void createInitData() {
    HabitsList = [
      ['Create an app', false],
      ['run an app', false],
      ['design an app', false]
    ];

    _myBox.put("START_DATE", todaysDateFormatted());
  }

  // load the data
  void loadData() {
    if (_myBox.get(todaysDateFormatted()) == null) {
      HabitsList = _myBox.get("CURRENT_HABIT_LIST");
      for (int i = 0; i < HabitsList.length; i++) {
        HabitsList[i][1] = false;
      }
    } else {
      HabitsList = _myBox.get(todaysDateFormatted());
    }
  }

  // update the database
  void updateHabitData() {
    _myBox.put(todaysDateFormatted(), HabitsList);
    // Updating Current Habit List
    _myBox.put('CURRENT_HABIT_LIST', HabitsList);

    //
    // calculateHabitPercentages();

    // load heat map
    // loadHeatMap();
  }

  void calculateHabitPercentages() {
    int countCompleted = 0;
    for (int i = 0; i < HabitsList.length; i++) {
      if (HabitsList[i][1] == true) {
        countCompleted++;
      }
    }

    String percent = HabitsList.isEmpty
        ? '0.0'
        : (countCompleted / HabitsList.length).toStringAsFixed(1);

    // key: "PERCENTAGE_SUMMARY_yyyymmdd"
    // value: string of 1dp number between 0.0-1.0 inclusive
    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    // count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to today and add each percentage to the dataset
    // "PERCENTAGE_SUMMARY_yyyymmdd" will be the key in the database
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      // split the datetime up like below so it doesn't worry about hours/mins/secs etc.

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      // day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
      print(heatMapDataSet);
    }
  }
}
