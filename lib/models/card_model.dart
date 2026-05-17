import 'package:flutter/material.dart';

class CardModel {
  final String color;

  CardModel({required this.color});

  // Вспомогательный геттер для конвертации строки в реальный цвет Flutter
  Color get flutterColor {
    if (color == "blue") return const Color(0xFF1864C2);
    if (color == "red") return const Color(0xFFC82C31);
    return Colors.grey;
  }
}