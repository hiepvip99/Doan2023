import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox(
      {super.key,
      required this.text,
      this.onChangeCallBack,
      required this.isChecked});

  final String text;
  final Function()? onChangeCallBack;
  final bool isChecked;
  // bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // setState(() {
        //   isChecked = !isChecked;
        // });
        onChangeCallBack != null ? onChangeCallBack!() : null;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isChecked ? Colors.blue : Colors.grey,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isChecked
                ? const Icon(
                    Icons.check,
                    color: Colors.blue,
                  )
                : const SizedBox(
                    height: 24.0,
                    width: 24.0,
                  ),
            const SizedBox(width: 8.0),
            Text(
              text,
              style: TextStyle(
                fontSize: 16.0,
                color: isChecked ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
