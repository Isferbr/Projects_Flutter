import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:meugasto/controllers/expense_controller.dart';
import 'package:meugasto/models/expense_model.dart';
import 'package:meugasto/views/widgets/filters_widget.dart';
import 'package:meugasto/views/widgets/expense_chart.dart';
import 'package:meugasto/utils/categories.dart';

import 'add_expense_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ExpenseController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de Gastos'),
      ),
      body: StreamBuilder<List<Expense>>(
        stream: controller.expensesStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final expenses = snapshot.data!;
          final filtered = controller.applyFilters(expenses);

          return Column(
            children: [
              const FiltersWidget(),

              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 200,
                  child: ExpenseChart(expenses: filtered),
                ),
              ),

              const Divider(),

              Expanded(
                child: ListView.builder(
                  itemCount: expenseCategories.length,
                  itemBuilder: (_, index) {
                    final category = expenseCategories[index];

                    final categoryExpenses = filtered
                        .where((e) => e.category == category)
                        .toList();

                    final total = categoryExpenses.fold<double>(
                      0,
                      (sum, e) => sum + e.value,
                    );

                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          categoryIcons[category] ?? Icons.money_off,
                        ),
                      ),
                      title: Text(category),
                      subtitle: Text(
                        '${categoryExpenses.length} despesas',
                      ),
                      trailing: Text(
                        'R\$ ${total.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: total > 0 ? Colors.red : Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AddExpenseView(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
