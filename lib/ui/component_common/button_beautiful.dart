import 'package:flutter/material.dart';

class ButtonBeautiful extends StatelessWidget {
  const ButtonBeautiful({super.key, required this.onTap, required this.title});
  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.blue,
            Colors.lightBlueAccent,
            Colors.lightBlue.shade200,
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          // Xử lý khi nút được nhấn
        },
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
