import 'package:flutter/material.dart';
import '../models/deadline.dart';
import 'add_deadline_screen.dart';

class DeadlinesScreen extends StatefulWidget {
  const DeadlinesScreen({super.key});

  @override
  State<DeadlinesScreen> createState() => _DeadlinesScreenState();
}

class _DeadlinesScreenState extends State<DeadlinesScreen> {
  final List<Deadline> deadlines = [];

  Color getUrgencyColor(Deadline d) {
    final daysLeft = d.dueDate.difference(DateTime.now()).inDays;
    if (daysLeft < 0) return Colors.red;
    if (daysLeft <= 3) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deadlines')),
      body: deadlines.isEmpty
          ? const Center(child: Text('No deadlines added'))
          : ListView.builder(
              itemCount: deadlines.length,
              itemBuilder: (context, index) {
                final d = deadlines[index];
                return Card(
                  child: ListTile(
                    title: Text(d.title),
                    subtitle: Text(
                      '₹${d.amount} • Due ${d.dueDate.toLocal().toString().split(' ')[0]}',
                    ),
                    trailing: Icon(Icons.circle,
                        color: getUrgencyColor(d)),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newDeadline = await Navigator.push<Deadline>(
            context,
            MaterialPageRoute(
              builder: (_) => const AddDeadlineScreen(),
            ),
          );

          if (newDeadline != null) {
            setState(() {
              deadlines.add(newDeadline);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
