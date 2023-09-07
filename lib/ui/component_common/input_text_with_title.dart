import 'package:flutter/material.dart';

import 'textfield_common.dart';

class InputTextWithTitle extends StatelessWidget {
  const InputTextWithTitle(
      {super.key, required this.textEditingController, required this.title});

  final TextEditingController textEditingController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 16,
        ),
        TextFieldCommon(controller: textEditingController),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
