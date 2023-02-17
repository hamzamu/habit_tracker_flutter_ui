import 'package:flutter/material.dart';

class FloatingButtonAdd extends StatelessWidget {
  final Function()? onPressed;
  const FloatingButtonAdd({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(Icons.add),
    );
  }
}
