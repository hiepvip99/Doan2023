import 'package:flutter/material.dart';

class CircleNumberWidget extends StatelessWidget {
  final String text;
  final bool isSelected;

  const CircleNumberWidget(
      {super.key, required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.lightBlueAccent : Colors.grey,
      child: Container(
        width: 36.0,
        height: 36.0,
        // decoration: BoxDecoration(

        //   // shape: BoxShape.circle,
        //   borderRadius: BorderRadius.circular(12),
        //   border: Border.all(color: Colors.black, width: 2.0),
        // ),
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
      ),
    );
  }
}
