import 'package:flutter/material.dart';
import 'package:habit_tracker_ui_hive/comp/HabitTile.dart';
import 'package:habit_tracker_ui_hive/comp/fab.dart';
import 'package:habit_tracker_ui_hive/comp/newHabitInput.dart';

import 'package:hive_flutter/hive_flutter.dart';

import './data//habits_database.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('Habits_Database');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(),
    );
  }
}

// Home Screen
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool habitCompleted = false;
  final _newHabitcontroller = TextEditingController();

  HabitsDatabase db = HabitsDatabase();
  final _myBox = Hive.box('Habits_Database');
  // List
  // late List HabitsList = [
  //   ["Morning Pray", false],
  //   ["Medevel Articles", false],
  //   ["Flutter App", false],
  // ];
  //

  @override
  void initState() {
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createInitData();
      print("Database is empty");
    } else {
      print("DB is Not Empty");
      db.loadData();
    }
    super.initState();
  }

  //

  void CheckboxTabbed(bool? value, int index) {
    print('CheckboxTabbed: Habit Controller:: $value');
    setState(() {
      // habitCompleted = value!;
      db.HabitsList[index][1] = !db.HabitsList[index][1];
      db.updateHabitData();
    });
  }

  void onCancel() {
    _newHabitcontroller.clear();
    Navigator.of(context).pop();
  }

  void onSave(habit) {
    setState(() {
      if (_newHabitcontroller.text.isEmpty) {
        return;
      }
      db.HabitsList.add([_newHabitcontroller.text, false]);
      _newHabitcontroller.clear();
      // Update
      db.updateHabitData();
      Navigator.of(context).pop();
    });
  }

  // createNewHabit

  void createNewHabit() {
    print('Create New Habit');
    showDialog(
        context: context,
        builder: (context) {
          return newHabitInput(
              controller: _newHabitcontroller,
              onCancel: onCancel,
              onSave: () => onSave(_newHabitcontroller));
        });
  }

  //
  // remove

  void removeHabit(int index) {
    setState(() {
      print('remove habit $index');
      db.HabitsList.removeAt(index);

      db.updateHabitData();
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        floatingActionButton: FloatingButtonAdd(onPressed: createNewHabit),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: db.HabitsList.length,
                  itemBuilder: (context, index) {
                    return HabitTile(
                        text: db.HabitsList[index][0],
                        habitCompleted: db.HabitsList[index][1],
                        onRemove: () => removeHabit(index),
                        onChanged: (value) => CheckboxTabbed(value, index));
                  }),
            ),
            // Container(
            //   height: 100,
            //   margin: EdgeInsets.all(0),
            //   padding: EdgeInsets.all(15),
            //   decoration: BoxDecoration(
            //       color: Colors.amber, borderRadius: BorderRadius.circular(20)),
            //   child: TextField(
            //     decoration: InputDecoration(
            //         border: InputBorder.none,
            //         hintText: 'Add New Habit',
            //         hintStyle: TextStyle(fontSize: 12)),
            //   ),
            // )
          ],
          // height: 300,
        ));
  }
}
