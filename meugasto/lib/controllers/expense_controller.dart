import 'package:flutter/material.dart';
import '../models/expense_model.dart';
import '../services/firebase_service.dart';

class ExpenseController extends ChangeNotifier {
  final _service = FirebaseService();

  String? selectedCategory;
  int? selectedMonth;

  Stream<List<Expense>> expensesStream() {
    return _service.fetchExpenses();
  }

  List<Expense> applyFilters(List<Expense> expenses) {
    return expenses.where((e) {
      final byCategory =
          selectedCategory == null || e.category == selectedCategory;
      final byMonth =
          selectedMonth == null || e.date.month == selectedMonth;
      return byCategory && byMonth;
    }).toList();
  }

  Future<void> addExpense(
    String title,
    double value,
    String category,
  ) async {
    await _service.addExpense(
      Expense(
        id: '',
        title: title,
        value: value,
        category: category,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void setCategory(String? value) {
    selectedCategory = value;
    notifyListeners();
  }

  void setMonth(int? value) {
    selectedMonth = value;
    notifyListeners();
  }
}
