import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/expense_model.dart';

class FirebaseService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  User? get _user => _auth.currentUser;
  
  Stream<List<Expense>> fetchExpenses() {
    final user = _user;

    if (user == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('expenses')
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Expense.fromMap(
                  doc.id,
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Future<void> addExpense(Expense expense) async {
    final user = _user;

    if (user == null) {
      throw Exception('Usuário não autenticado');
    }

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('expenses')
        .add(expense.toMap());
  }
}
