import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Categoryy { food, travel, leisure, work, misc }

const categoryIcons = {
  Categoryy.food: Icons.fastfood_outlined,
  Categoryy.travel: Icons.travel_explore,
  Categoryy.leisure: Icons.attach_money,
  Categoryy.work: Icons.work,
  Categoryy.misc: Icons.folder_copy,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.categoryy,
  }) : id = uuid.v4();
  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Categoryy categoryy;
  String get formattedDate {
    return formatter.format(date);
  }
}
