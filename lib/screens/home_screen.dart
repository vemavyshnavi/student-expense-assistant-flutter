import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'add_expense_screen.dart';
import 'deadlines_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> expenses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('This Month', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),

            Text(
              '₹ ${expenses.fold(0.0, (sum, e) => sum + e.amount)} spent',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: expenses.isEmpty
                  ? const Center(child: Text('No expenses yet'))
                  : ListView.builder(
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        final expense = expenses[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              '₹ ${expense.amount} - ${expense.category}',
                            ),
                            subtitle: Text('Paid via ${expense.paymentMethod}'),
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 12),

            // 🔔 VIEW DEADLINES BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeadlinesScreen(),
                    ),
                  );
                },
                child: const Text('View Deadlines'),
              ),
            ),

            const SizedBox(height: 12),

            // ➕ ADD EXPENSE BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final newExpense = await Navigator.push<Expense>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddExpenseScreen(),
                    ),
                  );

                  if (newExpense != null) {
                    setState(() {
                      expenses.add(newExpense);
                    });
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Expense'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
