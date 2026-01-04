import 'package:flutter/material.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String? moneyType;
  final TextEditingController budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setup your profile')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How do you usually get money?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            RadioListTile(
              title: const Text('Monthly allowance'),
              value: 'monthly',
              groupValue: moneyType,
              onChanged: (value) {
                setState(() {
                  moneyType = value.toString();
                });
              },
            ),
            RadioListTile(
              title: const Text('Occasional / whenever needed'),
              value: 'occasional',
              groupValue: moneyType,
              onChanged: (value) {
                setState(() {
                  moneyType = value.toString();
                });
              },
            ),
            RadioListTile(
              title: const Text('No allowance (only essentials paid)'),
              value: 'none',
              groupValue: moneyType,
              onChanged: (value) {
                setState(() {
                  moneyType = value.toString();
                });
              },
            ),

            const SizedBox(height: 24),

            const Text(
              'Monthly spending limit (optional)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: budgetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter amount or skip',
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },

                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
