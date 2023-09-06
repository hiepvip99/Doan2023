import 'package:flutter/material.dart';

class TextFieldCommon extends StatelessWidget {
  const TextFieldCommon(
      {super.key,
      this.label,
      required this.controller,
      this.contentPadding,
      this.requiredInput = false,
      this.isTextPassword});

  final String? label;
  final TextEditingController controller;
  final EdgeInsets? contentPadding;
  final bool requiredInput;
  final bool? isTextPassword;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          decoration: InputDecoration(
              // suffixText: requiredInput ? '*' : null,
              // suffixStyle:
              //     requiredInput ? const TextStyle(color: Colors.red) : null,
              label: label != null ? Text(label!) : null,
              border: const OutlineInputBorder(),
              contentPadding: contentPadding ?? const EdgeInsets.all(12),
            isDense: true,
          ),
          obscureText: isTextPassword == true,
          enableSuggestions: !(isTextPassword == true),
          autocorrect: !(isTextPassword == true),
        ),
        Visibility(
          visible: requiredInput,
          child: Positioned.fill(
            child: Container(
              padding: const EdgeInsets.only(right: 8),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '*',
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
