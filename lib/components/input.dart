import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final String label;
  final ValueChanged<String>? onChanged;
  final String value; // Adicione esta linha

  const InputTextField({
    super.key,
    required this.label,
    required this.value, // Adicione esta linha
    this.onChanged,
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder(),
        ),
        onChanged: widget.onChanged,
        controller: TextEditingController(text: widget.value), // Adicione esta linha
      ),
    );
  }
}

