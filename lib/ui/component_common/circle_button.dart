import 'package:flutter/material.dart';

class MyCircleButton extends StatelessWidget {
  const MyCircleButton({
    super.key,
    required this.child,
    required this.padding,
    required this.onTap,
  });

  final Widget child;
  final EdgeInsets padding;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: padding,
          child: child,
        ));
  }
}
