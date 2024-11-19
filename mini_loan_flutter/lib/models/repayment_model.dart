class Repayment {
  final String id;
  final double amount;
  final String status;
  final DateTime dueDate;


  Repayment({required this.id, required this.amount, required this.status, required this.dueDate});

  factory Repayment.fromJson(Map<String, dynamic> json) {
    return Repayment(
      id: json['_id'],
      amount: (json['amount'] as num).toDouble(),
      dueDate: DateTime.parse(json['dueDate']),
      status: json['status'],
    );
  }

}
