import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../utilities/extension_helper.dart';
// import '../../../utilities/resource/screen_size.dart';
// import '../../app_theme.dart';
// import '../button_border.dart';

class MyDropdownButton2StateFull extends StatefulWidget {
  MyDropdownButton2StateFull({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset,
    this.borderRadius,
    this.maxLineButton,
    Key? key,
  }) : super(key: key);
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset? offset;
  final Color? colorBorder = Colors.black;

  /// VietND: #589: fix item for all dropdown
  final double? borderRadius;

  final int? maxLineButton;

  @override
  State<StatefulWidget> createState() => CustomDropdownButton2();
}

class CustomDropdownButton2 extends State<MyDropdownButton2StateFull>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );

    _animationController?.forward(from: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton2(
            customButton: widget.maxLineButton != null
                ? _buttonDropDown(_animationController, widget)
                : null,
            dropdownStyleData: DropdownStyleData(
              offset: const Offset(0, -7),
              maxHeight: widget.dropdownHeight ?? 200,
              width: widget.dropdownWidth,
              padding: const EdgeInsets.only(left: 0.5, right: 0.5),
              decoration: widget.dropdownDecoration ??
                  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      strokeAlign: 0,
                      color: widget.colorBorder ??
                          (_isExpanded ? Colors.blue : Colors.black),
                    ),
                  ),
              elevation: widget.dropdownElevation ?? 0,
              isOverButton: false,
              scrollbarTheme: ScrollbarThemeData(
                radius: widget.scrollbarRadius ?? const Radius.circular(40),
                thickness: widget.scrollbarThickness != null
                    ? MaterialStateProperty.all<double>(
                        widget.scrollbarThickness!)
                    : null,
                thumbVisibility: widget.scrollbarAlwaysShow != null
                    ? MaterialStateProperty.all<bool>(
                        widget.scrollbarAlwaysShow!)
                    : null,
                //Null or Offset(0, 0) will open just under the button. You can edit as you want.
              ),
            ),
            onMenuStateChange: (val) {
              setState(() {
                _isExpanded = val;
                setState(() {
                  if (_isExpanded) {
                    _animationController?.reverse(from: 0.5);
                  } else {
                    _animationController?.forward(from: 0.0);
                  }
                });
              });
            },
            //To avoid long text overflowing.
            isExpanded: true,
            hint: Container(
              alignment: widget.hintAlignment,
              child: Text(
                widget.hint,
                maxLines: null,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            value: widget.value,
            items: widget.dropdownItems
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(
                            item,
                            maxLines: null,
                            style: const TextStyle(color: Colors.black),
                          )),
                          // Visibility(
                          //   visible: widget.upSuffixIcon != null && widget.downSuffixIcon != null,
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(left: 4),
                          //     child: item.contains('up') ? widget.upSuffixIcon! : widget.downSuffixIcon!
                          //   ),
                          // )
                        ],
                      ),
                    ))
                .toList(),
            onChanged: (val) {
              if (widget.onChanged != null) {
                widget.onChanged!(val);
              }
            },
            //selectedItemBuilder: widget.selectedItemBuilder,
            iconStyleData: IconStyleData(
              icon: _iconDropDown(_animationController),
              iconSize: widget.iconSize ?? 12,
              iconEnabledColor: widget.iconEnabledColor,
              iconDisabledColor: widget.iconDisabledColor,
            ),
            buttonStyleData: ButtonStyleData(
              height: widget.buttonHeight ?? 44,
              width: widget.buttonWidth ?? 140,
              // padding: widget.buttonPadding ??
              //     const EdgeInsets.only(left: 11, right: 18),
              decoration: widget.buttonDecoration ??
                  BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 7),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
              elevation: widget.buttonElevation,
            ),

            //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.

            menuItemStyleData: MenuItemStyleData(
              selectedMenuItemBuilder: (ctx, child) {
                return Container(
                  constraints:
                      BoxConstraints(minHeight: widget.itemHeight ?? 44),
                  color: Colors.grey.shade300,
                  child: child,
                );
              },
            )),
      ),
    );
  }
}

Widget _iconDropDown(AnimationController? animationController) {
  return RotationTransition(
      turns: Tween(begin: 1.0, end: 0.0).animate(animationController!),
      child: const Icon(
        Icons.keyboard_arrow_up,
        size: 24,
      ));
}

Widget _buttonDropDown(AnimationController? animationController,
    MyDropdownButton2StateFull widget) {
  return Container(
    padding: widget.buttonPadding,
    width: widget.buttonWidth,
    height: widget.buttonHeight,
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 7),
        border: Border.all(color: widget.colorBorder!)),
    child: Row(
      children: [
        Expanded(
            child: Text(
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.black),
          widget.value ?? '',
          maxLines: widget.maxLineButton ?? 1,
        )),
        _iconDropDown(animationController)
      ],
    ),
  );
}
