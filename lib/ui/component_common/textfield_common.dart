import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCommon extends StatelessWidget {
  const TextFieldCommon({
    super.key,
    this.label,
    this.hintText,
    required this.controller,
    this.contentPadding,
    this.requiredInput = false,
    this.isTextPassword,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    this.keyboardType,
    this.border,
    this.backgroundColor,
    this.labelColor,
  });

  final String? label;
  final String? hintText;
  final TextEditingController controller;
  final EdgeInsets? contentPadding;
  final bool requiredInput;
  final bool? isTextPassword;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onChanged;
  final TextInputType? keyboardType;
  final InputBorder? border;
  final Color? backgroundColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: backgroundColor,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              focusedBorder: border ??
                  const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
              enabledBorder: border ??
                  const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
              label: label != null
                  ? Text(
                      label!,
                      style: TextStyle(color: labelColor),
                    )
                  : null,
              border: border ?? const OutlineInputBorder(),
              contentPadding: contentPadding ?? const EdgeInsets.all(12),
              isDense: true,
              
            ),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            validator: validator,
            obscureText: isTextPassword == true,
            enableSuggestions: !(isTextPassword == true),
            autocorrect: !(isTextPassword == true),
            onChanged: onChanged,
          ),
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
