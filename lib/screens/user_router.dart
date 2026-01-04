import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_screen.dart';
import 'onboarding_screen.dart';

class UserRouter extends StatelessWidget {
  const UserRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          // Safety fallback
          return const OnboardingScreen();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final hasOnboarded = data['hasOnboarded'] == true;

        return hasOnboarded
            ? const HomeScreen()
            : const OnboardingScreen();
      },
    );
  }
}
