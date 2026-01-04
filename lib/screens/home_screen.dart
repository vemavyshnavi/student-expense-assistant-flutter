import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/expense.dart';
import '../services/firestore_service.dart';
import 'add_expense_screen.dart';
import 'deadlines_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late final String currentMonthYear;
  late final String uid;

  @override
  void initState() {
    super.initState();

    uid = FirebaseAuth.instance.currentUser!.uid;

    final now = DateTime.now();
    final month = now.month.toString().padLeft(2, '0');
    currentMonthYear = '${now.year}-$month';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<List<Expense>>(
          stream: _firestoreService.getExpensesOrdered(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final allExpenses = snapshot.data ?? [];

            final expenses = allExpenses
                .where((e) => e.monthYear == currentMonthYear)
                .toList();

            final totalSpent = expenses.fold(0.0, (sum, e) => sum + e.amount);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('This Month', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),

                Text(
                  '₹ $totalSpent spent',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: expenses.isEmpty
                      ? const Center(child: Text('No expenses this month'))
                      : ListView.builder(
                          itemCount: expenses.length,
                          itemBuilder: (context, index) {
                            final expense = expenses[index];
                            return Card(
                              child: ListTile(
                                title: Text(
                                  '₹ ${expense.amount} - ${expense.category}',
                                ),
                                subtitle: Text(
                                  expense.date.toLocal().toString(),
                                ),
                              ),
                            );
                          },
                        ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DeadlinesScreen(),
                        ),
                      );
                    },
                    child: const Text('View Deadlines'),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddExpenseScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Expense'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
