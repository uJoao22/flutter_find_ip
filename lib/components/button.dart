import 'package:flutter/material.dart';

class Button<T> extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const Button({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20.0)),
        child: Text(title),
      ),
    );
  }
}