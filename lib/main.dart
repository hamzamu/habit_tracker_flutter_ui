import 'package:flutter/material.dart';
import 'package:habit_tracker_ui_hive/comp/HabitTile.dart';
import 'package:habit_tracker_ui_hive/comp/fab.dart';
import 'package:habit_tracker_ui_hive/comp/newHabitInput.dart';

import 'package:hive_flutter/hive_flutter.dart';

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

  // List
  late List HabitsList = [
    ["Morning Pray", false],
    ["Medevel Articles", false],
    ["Flutter App", false],
  ];
  //
  void CheckboxTabbed(bool? value, int index) {
    print('CheckboxTabbed: Habit Controller:: $value');
    setState(() {
      // habitCompleted = value!;
      HabitsList[index][1] = !HabitsList[index][1];
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
      HabitsList.add([_newHabitcontroller.text, false]);
      _newHabitcontroller.clear();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        floatingActionButton: FloatingButtonAdd(onPressed: createNewHabit),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: HabitsList.length,
                  itemBuilder: (context, index) {
                    return HabitTile(
                        text: HabitsList[index][0],
                        habitCompleted: HabitsList[index][1],
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
