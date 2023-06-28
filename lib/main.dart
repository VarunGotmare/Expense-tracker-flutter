import 'package:expenses_tracker/models/expenses.dart';
import 'package:flutter/material.dart';

var kColor = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 232, 163, 241),
);
var kColorDark = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 181, 3, 204),
);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kColorDark,
        cardTheme: const CardTheme().copyWith(
          color: kColorDark.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorDark.primaryContainer,
            foregroundColor: kColorDark.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColor,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColor.onPrimaryContainer,
          foregroundColor: kColor.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColor.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColor.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColor.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      home: const Expenses(),
    ),
  );
}
