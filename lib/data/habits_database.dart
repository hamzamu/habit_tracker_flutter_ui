import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Habits_Database");

class HabitsDatabase {
  List todayHabits = [];

  // create init data

  // void createInitData() {
  //   todayHabitsList = [
  //     ['Create an app', false],
  //     ['run an app', false],
  //     ['design an app', false]
  //   ];
  // }

  // load the data
  void loadHabitsData() {}

  // update the database
  void updateHabitData() {}
}
