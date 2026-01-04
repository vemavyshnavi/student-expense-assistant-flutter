class Deadline {
  final String title;
  final double amount;
  final DateTime dueDate;
  bool isPaid;

  Deadline({
    required this.title,
    required this.amount,
    required this.dueDate,
    this.isPaid = false,
  });
}
