import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../model/network/color_model.dart';

class ColorInputDialog extends StatefulWidget {
  const ColorInputDialog(
      {super.key,
      this.colorShoe,
      required this.updateColor,
      required this.addColor});

  final ColorShoe? colorShoe;
  final Function(ColorShoe colorShoe) updateColor;
  final Function(ColorShoe colorShoe) addColor;

  @override
  State<ColorInputDialog> createState() => _ColorInputDialogState();
}

class _ColorInputDialogState extends State<ColorInputDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hexController = TextEditingController();
  Color _selectedColor = Colors.transparent;

  RxString validateName = ''.obs;
  RxString validateHexColor = ''.obs;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.colorShoe?.name ?? '';
    _hexController.text = widget.colorShoe?.colorCode ?? '';
    if (widget.colorShoe?.colorCode != null) {
      try {
        // final colorS = Colors
        Color colorS = Color(
            int.parse(widget.colorShoe!.colorCode!, radix: 16) + 0xFF000000);
        setState(() {
          _selectedColor = colorS;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _hexController.dispose();
    super.dispose();
  }

  void _updateColor() {
    String hex = _hexController.text;
    Color color = Color(int.parse(hex, radix: 16) + 0xFF000000);
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Text(
          //   widget.colorShoe != null ? 'Sửa màu sắc' : 'Thêm Màu Sắc',
          //   style: const TextStyle(
          //     fontSize: 18.0,
          //     fontWeight: FontWeight.bold,
          //   ),
          //   textAlign: TextAlign.center,
          // ),
          // const SizedBox(height: 16.0),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Tên màu',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: validateName.value.isNotEmpty
                            ? Colors.red
                            : const Color(0xFF000000),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                validateName.value.isNotEmpty
                    ? Text(
                        validateName.value,
                        style: const TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _hexController,
                  decoration: InputDecoration(
                    labelText: 'Mã màu',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: validateHexColor.value.isNotEmpty
                            ? Colors.red
                            : const Color(0xFF000000),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value) {
                    _updateColor();
                  },
                ),
                validateHexColor.value.isNotEmpty
                    ? Text(
                        validateHexColor.value,
                        style: const TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            height: 50.0,
            decoration: BoxDecoration(
              color: _selectedColor,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  backgroundColor: Colors.grey[200],
                ),
                child: const Text(
                  'Hủy',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(width: 8.0),
              TextButton(
                onPressed: () {
                  validateName.value = '';
                  validateHexColor.value = '';
                  String name = _nameController.text;
                  String hex = _hexController.text;
                  if (name.trim().isEmpty) {
                    validateName.value = 'Không được để trống';
                  } else if (!hex.isHexadecimal) {
                    validateHexColor.value = 'Giá trị không hợp lệ';
                  } else {
                    try {
                      Color color =
                          Color(int.parse(hex, radix: 16) + 0xFF000000);
                      widget.colorShoe != null
                          ? widget.updateColor(ColorShoe(
                              id: widget.colorShoe?.id,
                              name: name,
                              colorCode: hex))
                          : widget
                              .addColor(ColorShoe(name: name, colorCode: hex));
                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  }

                  // Do something with the color and name
                  // For example, you can pass the color and name back to the parent widget using Navigator.pop()

                  
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  widget.colorShoe != null ? 'Sửa' : 'Thêm',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
