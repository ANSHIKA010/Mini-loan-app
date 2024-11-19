class Loan {
  final String id;
  final double amount;
  final int term;
  final String status;
  final List<dynamic> repayments;

  Loan({
    required this.id,
    required this.amount,
    required this.term,
    required this.status,
    required this.repayments,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      id: json['_id'],
      amount: (json['amount'] as num).toDouble(),
      term: json['term'],
      status: json['status'],
      repayments: json['repayments'],
    );
  }
}
