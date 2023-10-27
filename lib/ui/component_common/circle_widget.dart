import 'package:flutter/material.dart';

class CircleNumberWidget extends StatelessWidget {
  final String text;
  final bool isSelected;

  const CircleNumberWidget(
      {super.key, required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34.0,
      height: 34.0,
      decoration: BoxDecoration(
        color: isSelected ? Colors.lightBlueAccent : Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 3.0,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Center(
        child: Text(
          '$text',
          style: const TextStyle(
            color: Colors.black,
            // fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
