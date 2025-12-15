import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../models/expense_model.dart';

class ExpenseChart extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseChart({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const SizedBox.shrink();
    }

    final total = expenses.fold<double>(
      0,
      (sum, e) => sum + e.value,
    );

    return SizedBox(
      height: 220,
      child: PieChart(
        PieChartData(
          sections: expenses.map((e) {
            final percent = (e.value / total) * 100;

            return PieChartSectionData(
              value: e.value,
              title: '${percent.toStringAsFixed(1)}%',
            );
          }).toList(),
        ),
      ),
    );
  }
}
