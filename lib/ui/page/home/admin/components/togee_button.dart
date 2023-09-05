import 'package:flutter/material.dart';

class DrawerToggleButton extends StatefulWidget {
  const DrawerToggleButton({super.key, required this.callBack});

  final Function() callBack;

  @override
  State<DrawerToggleButton> createState() => _DrawerToggleButtonState();
}

class _DrawerToggleButtonState extends State<DrawerToggleButton>
    with SingleTickerProviderStateMixin {
  bool isDrawerOpen = false;
  double turns = 0.0;

  void toggleDrawer() {
    widget.callBack();
    isDrawerOpen = !isDrawerOpen;
    if (isDrawerOpen) {
      setState(() => turns += 1.0 / 2.0);
    } else {
      setState(() => turns -= 1.0 / 2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment:
      //     isDrawerOpen ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: toggleDrawer,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: AnimatedRotation(
              turns: turns,
              duration: const Duration(milliseconds: 350),
              child: const Icon(Icons.keyboard_arrow_right),
              // icon: AnimatedIcons.arrow_menu,
              // progress: _animationController,
            ),
          ),
        ),
      ],
    );
  }
}
