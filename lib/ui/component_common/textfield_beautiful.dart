import 'package:flutter/material.dart';

class TextFieldBeautiful extends StatelessWidget {
  const TextFieldBeautiful(
      {super.key,
      required this.title,
      required this.controller,
      this.autofocus = false});

  final String title;
  final bool autofocus;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.lightBlueAccent,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          autofocus: autofocus,
          controller: controller,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.lightBlueAccent),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
