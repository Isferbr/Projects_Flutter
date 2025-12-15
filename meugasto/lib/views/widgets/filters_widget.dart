import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/expense_controller.dart';
import '../../utils/categories.dart';
import '../../utils/months.dart';

class FiltersWidget extends StatelessWidget {
  const FiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ExpenseController>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // ===== FILTRO DE CATEGORIA =====
          Expanded(
            child: DropdownButtonFormField<String?>(
              decoration: const InputDecoration(
                labelText: 'Categoria',
                border: OutlineInputBorder(),
              ),
              initialValue: controller.selectedCategory,
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('Todas'),
                ),
                ...expenseCategories.map(
                  (c) => DropdownMenuItem<String?>(
                    value: c,
                    child: Text(c),
                  ),
                ),
              ],
              onChanged: controller.setCategory,
            ),
          ),

          const SizedBox(width: 12),

          // ===== FILTRO DE MÊS =====
          Expanded(
            child: DropdownButtonFormField<int?>(
              decoration: const InputDecoration(
                labelText: 'Mês',
                border: OutlineInputBorder(),
              ),
              initialValue: controller.selectedMonth,
              items: [
                const DropdownMenuItem<int?>(
                  value: null,
                  child: Text('Todos'),
                ),
                ...List.generate(months.length, (index) {
                  final monthNumber = index + 1;
                  return DropdownMenuItem<int?>(
                    value: monthNumber,
                    child: Text(months[index]),
                  );
                }),
              ],
              onChanged: controller.setMonth,
            ),
          ),
        ],
      ),
    );
  }
}
