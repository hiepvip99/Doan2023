import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900, // sử dụng màu xám đậm cho nền
    brightness: Brightness.dark,
    error: Colors.red.shade400,
    primary: Colors.white,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
    ),
    labelLarge: TextStyle(
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      color: Colors.white,
    ),
  ),
  appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade900, elevation: 0),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue.shade400,
    disabledColor: Colors.grey,
  ),
);

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    // sử dụng ColorScheme.light cho chế độ sáng
    primary: Colors.blue.shade700, // sử dụng màu xanh nhạt cho màu chủ đạo
    background: Colors.white, // sử dụng màu trắng cho nền
    error: Colors.red, // sử dụng màu đỏ cho thông báo lỗi
    brightness: Brightness.light,
  ),
  textButtonTheme: const TextButtonThemeData(
      style:
          ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.black))),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.black,
    ),
    displayMedium: TextStyle(
      color: Colors.black,
    ),
    displaySmall: TextStyle(
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      color: Colors.black,
    ),
    headlineSmall: TextStyle(
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
    ),
    titleSmall: TextStyle(
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      color: Colors.black,
    ),
    labelLarge: TextStyle(
      color: Colors.black,
    ),
    labelSmall: TextStyle(
      color: Colors.black,
    ),
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue,
    disabledColor: Colors.grey,
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    menuStyle: MenuStyle(
      maximumSize: MaterialStatePropertyAll(
        Size(2000, 200),
      ),
      // maximumSize: MaterialStatePropertyAll<Size>(Size.infinite),
      visualDensity: VisualDensity.standard,
    ),
  ),
);
