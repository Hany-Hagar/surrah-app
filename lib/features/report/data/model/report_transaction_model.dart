import 'package:flutter/material.dart';

class ReportTransactionModel {
  final int id;
  final String title;
  final Color color;
  final double amount;
  ReportTransactionModel({
    required this.id,
    required this.title,
    required this.color,
    required this.amount,
  });
}
