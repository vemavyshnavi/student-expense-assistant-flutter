import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String monthYear;

  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.monthYear,
  });

  /// Generates "YYYY-MM" (example: 2026-01)
  static String generateMonthYear(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    return '${date.year}-$month';
  }

  /// Convert Expense → Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
      'category': category,
      'date': Timestamp.fromDate(date),
      'monthYear': monthYear,
    };
  }

  /// Convert Firestore → Expense
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      title: map['title'],
      amount: (map['amount'] as num).toDouble(),
      category: map['category'],
      date: (map['date'] as Timestamp).toDate(),
      monthYear: map['monthYear'],
    );
  }
}
