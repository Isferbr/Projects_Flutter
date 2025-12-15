class Expense {
  final String id;
  final String title;
  final double value;
  final String category;
  final DateTime date;

  Expense({
    required this.id,
    required this.title,
    required this.value,
    required this.category,
    required this.date,
  });

  factory Expense.fromMap(String id, Map<String, dynamic> data) {
    return Expense(
      id: id,
      title: data['title'],
      value: (data['value'] as num).toDouble(),
      category: data['category'],
      date: DateTime.parse(data['date']),
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'value': value,
        'category': category,
        'date': date.toIso8601String(),
      };
}
