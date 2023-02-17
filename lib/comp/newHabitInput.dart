import 'package:flutter/material.dart';

class newHabitInput extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const newHabitInput(
      {super.key,
      required this.controller,
      required this.onCancel,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(10)),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.red,
              hintText: "Enter your habit"),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          child: Text('save'),
        ),
        MaterialButton(
          onPressed: onCancel,
          child: Text('cancel'),
        )
      ],
    );
  }
}
