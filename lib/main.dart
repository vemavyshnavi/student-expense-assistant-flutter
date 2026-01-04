import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const StudentExpenseApp());
}

class StudentExpenseApp extends StatelessWidget {
  const StudentExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Expense Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}
