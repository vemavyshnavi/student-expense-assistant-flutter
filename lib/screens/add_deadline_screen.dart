import 'package:flutter/material.dart';
import '../models/deadline.dart';

class AddDeadlineScreen extends StatefulWidget {
  const AddDeadlineScreen({super.key});

  @override
  State<AddDeadlineScreen> createState() => _AddDeadlineScreenState();
}

class _AddDeadlineScreenState extends State<AddDeadlineScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Deadline')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Payment title (Exam fee, Books...)',
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? 'No date selected'
                        : 'Due: ${selectedDate!.toLocal().toString().split(' ')[0]}',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: const Text('Pick Date'),
                ),
              ],
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                if (selectedDate == null) return;

                final deadline = Deadline(
                  title: titleController.text,
                  amount: double.tryParse(amountController.text) ?? 0,
                  dueDate: selectedDate!,
                );

                Navigator.pop(context, deadline);
              },
              child: const Text('Save Deadline'),
            ),
          ],
        ),
      ),
    );
  }
}
