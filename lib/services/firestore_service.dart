import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save expense for user
  Future<void> addExpense(String uid, Expense expense) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .add(expense.toMap());
  }

  // Read expenses ordered (stable on web)
  Stream<List<Expense>> getExpensesOrdered(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .orderBy('monthYear', descending: true)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Expense.fromMap(doc.data()))
              .toList();
        });
  }
}
