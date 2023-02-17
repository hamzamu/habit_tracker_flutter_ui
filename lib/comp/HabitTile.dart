import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  String text;
  bool habitCompleted;
  final Function(bool?)? onChanged;
  HabitTile(
      {super.key,
      required this.text,
      required this.habitCompleted,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Checkbox(value: habitCompleted, onChanged: onChanged),
          Text(text)
        ],
      ),
    );
  }
}
